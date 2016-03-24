From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Thu, 24 Mar 2016 08:50:36 +0200
Message-ID: <87fuvgxtc3.fsf@intel.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com> <56F2DF79.6010903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F2DF79.6010903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
>> Hi,
>>
>> On 16.01.2016 00:48, Tony Lindgren wrote:
>>> Hi all,
>>>
>>> Looks like there's some issue with the USB gadgets and configfs.
>>>
>>> I'm seeing rmmod of the UDC driver cause a warning and then reboot
>>> hangs the system. This happens at least with v4.4, and I've reproduced
>>> it with dwc3 and musb so it seems to be generic.
>>>
>>
>> Having configfs is not needed, disabling usb gadgets (#
>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least poweroff
>> hang issue on N900. Also, g_nokia is not a module in the config I use,
>> so I guess the problem is not related whether gadgets are modular or
>> not. Unfortunately I was not able to test reboot, as rootfs became
>> corrupted after the first poweroff :( . So it looks like my theory that
>> onenand corruption on N900 is because poweroff/reboot hangs is wrong.
>>
>> Ivo
>
>
> Is there any progress on the issue?

I don't have any DT-based system anymore, so there's very little I can
do to help. That being said, it's not the first time
of_platform_depopulate() causes problems.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8449AAoJEIaOsuA1yqREoX8P/RrAJcPYlHOpZi1hD0qOD7qJ
+peNR+1ZFGMFhjr8jHUCjBDiiK7TPMdpx22711UxEFc56to4KrUZmW8dc9z5wxJI
9drRqRYsdX6sS/G7IYjpfbe3vIURYJAVoAgSjqtAHuZPYseWPlDduQzmJveC7ebX
JroP/NJzGelnbXmy8vK83bA74LfqpOKPFI7hJpFqkf1LI9KBW4yXCGvajYyfEXB0
bf2KSXTIsOvKo/r9L8sCnn/KF7nz9At0kD5t/SQW1IMfTtV7uCJlGx11O+MS0Pp5
9syavPW/eACR+zVQAOONChAwedHd5lW1W3YcA6WuaOul1yd9B8q/GlS31x2pjeJc
AMyKOZQ8zYuaSvBuhmBSrubY50DPC5M/nDIWQoZXTjDIA/xzyzF+SO4J2Z8jpvAv
GqzqPZ7H7ExwZmuK7qx+eSDb4pMAQxzSz2460ZptO/1BupcL+/QFQH2tuS/pZF70
ylcA77PHF3NyBzGuyAaTAY6oG9sW1r3iNWd7YEZ9vDzlV8A64IX7lgqImua0ncxx
jU4E2dpVkSxwdu+Rl4JWNikn3GLplWNxN/uARAyrm2APHU+gJphdhmFwmNR1cD09
DhjN6nUQ6+kiG3fH8D74UUROsx5RDshV31JMH+U/u1vgWJyKoceu7bRXxVLHYDhv
lz4FfQv95PKmxb8TSnn+
=2Zqp
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
