From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Tue, 26 Apr 2016 09:22:04 +0300
Message-ID: <87a8kgrisz.fsf@intel.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com> <57081105.2050206@gmail.com> <87oa97gxkw.fsf@intel.com> <571E6943.30305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571E6943.30305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>> Looks like there's some issue with the USB gadgets and configfs.
>>>>>
>>>>> I'm seeing rmmod of the UDC driver cause a warning and then reboot
>>>>> hangs the system. This happens at least with v4.4, and I've reproduced
>>>>> it with dwc3 and musb so it seems to be generic.
>>>>>
>>>>
>>>> Having configfs is not needed, disabling usb gadgets (#
>>>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least poweroff
>>>> hang issue on N900. Also, g_nokia is not a module in the config I use,
>>>> so I guess the problem is not related whether gadgets are modular or
>>>> not. Unfortunately I was not able to test reboot, as rootfs became
>>>> corrupted after the first poweroff :( . So it looks like my theory that
>>>> onenand corruption on N900 is because poweroff/reboot hangs is wrong.
>>>
>>> (copied from "Re: [PATCH] usb: f_mass_storage: test whether thread is
>>> running before starting another" thread)
>>>
>>> Yet another problem with USB gadget, this time with f_acm - if there is
>>> an open /dev/ttyGSn device, it is impossible to reboot/power down the
>>> device.
>>>
>>> My investigation shown that there is a process(pnatd) that opens
>>> /dev/ttyGSn devices, so gserial_free_port() hangs on
>>> wait_event(port->close_wait, gs_closed(port)); if I do "cd
>>> /sys/bus/platform/drivers/musb-hdrc && echo musb-hdrc.0.auto > unbind".
>>>
>>> Unfortunately I don't have serial debug port connector on my N900, so I
>>> can't capture logs after the reboot command, however, I suspect it hangs
>>> on the same place as with unbind.
>>>
>>> That looks weird, as one would expect that close() is called when the
>>> kernel kills user processes on reboot/powerdown.
>>
>> right, care to enable lockup detection and see if you can get more info
>> out of it ?
>>
>
> Nothing interesting, besides that screen does not work :(. However, the=20
> device boots, I can connect through wifi and reboot still hangs. Also, I=
=20
> don't see that port->close_wait in /proc/lockdep. Is that expected?

no idea what /proc/lockdep is supposed to show

> Is there a reason why a process (pnatd in this particular case) doesn't=20
> get killed on reboot?

there might be, and that's probably the bug we're trying to figure
out. But so far, no idea.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHwkMAAoJEIaOsuA1yqRE3pEP/3FrlMhOMaOoSqkvgzVijmcQ
Exqs2ABMv530UjDnJc9NU5+UAdZTeLYgWrdm5ycyd/RAM5t3/tvCS8A5DxK0fieM
2us2Ff1Ko2ZTeGAYMkdkiTc9IE1vDO6I5n1w9uWBwChzAZyEU+auhGtNmW25w7gG
mMqz328mVPgFyXuyfp4Q2XSNNs1TABG1DO+FGVhc7scptSVXRtx1jD5p35OPQjAW
DzQjuxwUIapxQbBEcTQ9p8XkcZcmO7nIsyFn4XxOziGP4BoyN3068MDXeofQd39f
MUkaMwnaPWv9nvMwfOgSnMMVpeGsTGulHVHaCWBr4/9cBj9kG0aNhjYYHs9U0t9c
lj7NDZCHvW3DiyKlGT4o7SZs4UrwrsdC2VIByCtsTgRrwFlXeX0DjKbUm2i43A+g
e2tddAwjqa6X2K+XHgQ4xjLvUf3XHXFKm5DDIUwMOrNcNAfZcFUQZLEfak+cyMDb
axk1IyTk4tVbK7RXa43Cfrvz7OYaTjjsIZBvCHzKjXcZ19qvia3d99V+w1T+Jx5Q
ZXnIsNCilkm5gOEdwj1c1kxpb+UCoICEdsIWB+R1tp3nusLfedn9Dy1r70gYggXt
VsAozLoTx7PyXGysK2u1t4a5GTbFuJYJVb/UKUOOtdOU/892dBBSUaaCb5UmRDPz
tqOZlqxO8Am+G+31IVX8
=wDVt
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
