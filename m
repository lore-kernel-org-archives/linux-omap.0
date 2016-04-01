From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Sat, 02 Apr 2016 00:16:14 +0200
Message-ID: <xa1tbn5tynyp.fsf@mina86.com>
References: <Pine.LNX.4.44L0.1604011452580.1957-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1604011452580.1957-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> On Fri, 1 Apr 2016, Michal Nazarewicz wrote:
>> @@ -3050,9 +3053,11 @@ static int fsg_bind(struct usb_configuration =
*c, struct usb_function *f)
>>                 if (ret)
>>                         return ret;
>>                 fsg_common_set_inquiry_string(fsg->common, NULL, NUL=
L);
>> -               ret =3D fsg_common_run_thread(fsg->common);
>> -               if (ret)
>> -                       return ret;
>> +               if (common->thread_task) {
>
On Fri, Apr 01 2016, Alan Stern wrote:
> Do you mean: if (!common->thread_task)?

Correct.

>> +                       ret =3D fsg_common_run_thread(fsg->common);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>>         }
>> =20
>>         fsg->gadget =3D gadget;
>> ---- >8 ------------------------------------------------------------=
----
>>=20
>> With that, the whole fsg_common_run_thread call should be moved outs=
ide
>> of the if (!no_configfs) and legacy should no longer call it IMO.
>
> I'm not so sure about this.  Earlier I was undecided about what to do
> if there are multiple mass-storage interfaces in the same config, but
> now I realize that one thread won't work in that situation.  The
> difficulty is exception handling.  If an error occurs in one of the
> interfaces, it shouldn't affect the others -- but with only one threa=
d
> you can't make that work.
>
> I don't know the details of how the composite core works (I don't eve=
n
> remember the difference between a usb_function and
> a usb_function_instance).

configfs made things quite confusing, yes.  IIRC, usb_function roughly
corresponds to an interface while usb_function_instance corresponds to
a module/function driver, except you can easily create multiple
instances.

> Suppose there are several interfaces in one config, each bound to the
> mass-storage driver.  Then won't the driver's bind routine get called
> several times whenever the config is installed?
>
> If so, then each of those calls should create a new thread.  There's =
no
> need to check if the thread has already been started.
>
> If not, then there's no way to use f_mass_storage on multiple
> interfaces in a single config.  The driver should refuse to run on
> more than one interface at a time.

Right, but that=E2=80=99s not what is happening.  We have a situation w=
here
single mass storage instance is bound to two interfaces on two differen=
t
configs:

	mkdir functions/mass_storage.0
	echo $file > functions/mass_storage.0/lun.0/file
	ln -s functions/mass_storage.0 configs/c.1
	ln -s functions/mass_storage.0 configs/c.2

configfs doesn=E2=80=99t even allows to express situation where a singl=
e
instance of a function is bound to multiple interfaces in a single
configuration (IIRC).

At the same time, mass storage should work fine if it=E2=80=99s bound t=
o
multiple configurations.  Only one configuration can be active at any
given time so interfaces on different configurations cannot interfere
with each other.

The problem we are having is that when mass storage is added to
a configuration, fsg_bind is called and it starts the thread.

If someone wanted to have two mass storage interfaces on a single
configuration they would have to create two mass storage instances and
each instance has it=E2=80=99s own fsg_common struct (see fsg_alloc_ins=
t
function).

PS. It seems that legacy/multi is broken because it calls
    fsg_common_run_thread twice.

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=
=83=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
