import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();
  @override
  List<Object?> get props => [];
} 

class AuthStarted extends AuthEvent{}

class AuthSignUp extends AuthEvent{
  final String nama_lengkap; 
  final String username; 
  final String email; 
  final String password; 
  final String confirm_password;

  const AuthSignUp({
    required this.nama_lengkap, 
    required this.username, 
    required this.email,
    required this.password,
    required this.confirm_password
    });
  @override
  List<Object?> get props => [
    nama_lengkap, 
    username, 
    email, 
    password, 
    confirm_password];
}

class AuthSignIn extends AuthEvent{
  final String email;
  final String password;
  const AuthSignIn({
    required this.email, 
    required this.password});
  @override
  List<Object?> get props => [email, password];
}

class AuthSignOut extends AuthEvent{}
