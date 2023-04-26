//APIs urls
//const baseUrl = 'https://nest-keja.com/Nest/backend/public/api';
const baseUrl = 'http://192.168.100.4:8000/api';

//Register, Login, Logout, Update User
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/register';
const userUrl = '$baseUrl/user';

///---------Errors---------////
const serverError = "Internet connection lost";
const unauthorized = "Unauthorized";
const somethingWentWrong = "Something went wrong, try again";