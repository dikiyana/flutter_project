import 'package:bootcamp_flutter_tm06/blocs/auth/auth_event.dart';
import 'package:bootcamp_flutter_tm06/blocs/auth/auth_state.dart';
import 'package:bootcamp_flutter_tm06/repositories/auth_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories authRepositories;

  AuthBloc(this.authRepositories) : super(AuthInitial()) {
    // Cek apakah user sudah login
    on<AuthStarted>((event, emit) async {
      try {
        final user = authRepositories.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError("Gagal memeriksa status login: ${e.toString()}"));
      }
    });

    // Sign Up
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepositories.signUp(
          event.nama_lengkap,
          event.username,
          event.email,
          event.password,
          event.confirm_password,
        );
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError("Gagal mendaftar: ${e.toString()}"));
        emit(AuthUnAuthenticated()); // fallback biar status jelas
      }
    });

    // Sign In
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepositories.signIn(
          event.email,
          event.password,
        );
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError("Gagal login: ${e.toString()}"));
        emit(AuthUnAuthenticated());
      }
    });

    // Sign Out
    on<AuthSignOut>((event, emit) async {
      try {
        await authRepositories.signOut();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError("Gagal logout: ${e.toString()}"));
      }
    });
  }
}
