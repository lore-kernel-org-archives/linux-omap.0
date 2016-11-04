From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 04 Nov 2016 10:31:38 +0200
Message-ID: <87r36rk5n9.fsf@linux.intel.com>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com> <20161020082318.GA2903@localhost.localdomain> <20161020123524.oepmqvlhzzu7elgj@atomide.com> <20161020193612.GA29736@localhost.localdomain> <20161021071722.2cetd2mt23t245ao@atomide.com> <20161024180708.kpx6s2jb7dpg6xfx@atomide.com> <20161101211358.GA2597@localhost.localdomain> <20161103205902.GB21430@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161103205902.GB21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161021 00:18]:
>> > > * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 12:37]:
>> > > > [  186.457519] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_bc=
on (90, <VBusValid), retry #3, port1 0008010c
>> > > >=20
>> > > > And that's the end, since now it does not react on hub plug/unplug.
>> > > >=20
>> > > > Also all that VBUS_ERROR conditions are strange as hub is powered =
separately
>> > > > and power lines from phy are not used.
>> > >=20
>> > > Hmm yeah. I'd like to be able to reproduce this. Can you email me
>> > > your .config (again)? You have things in host mode with a powered
>> > > hub plus few devices with no USB gadgets configured?
>> >=20
>> > Well I found your earlier .config so presumably that did not change.
>> > Below patch seems to do the trick for me, but I need to test more.
>> >=20
>> > Care to test if it helps for you? Please test with v4.9-rc2 and the
>> > following two fixes heading in Greg's usb-linus branch:
>> >=20
>> > cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
>> > d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order e=
rror")
>>=20
>> tested with v4.9-rc3 which have these included.
>
> OK thanks.
>
>> > I'll send a proper patch if that works for you.
>>=20
>> Unfortunately it's still the same. Direct connection (without hub) remai=
ns
>> untested as there's not enough power to supply display:
>> usb 2-1: USB disconnect, device number 2
>> usb 2-1: new high-speed USB device number 3 using musb-hdrc
>> usb 2-1: New USB device found, idVendor=3D17e9, idProduct=3D0335
>> usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
>> usb 2-1: Product: MIMO
>> usb 2-1: Manufacturer: DisplayLink
>> usb 2-1: SerialNumber: 1071007195
>> usb 2-1: rejected 1 configuration due to insufficient available bus power
>> usb 2-1: no configuration chosen from 1 choice
>
> Hmm yeah playing with a hub connected devices don't always enumerate.
> When that happens, I get this:
>
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: USB disconnect, device number 45
> usb 1-1: new high-speed USB device number 47 using musb-hdrc
> usb 1-1: new high-speed USB device number 48 using musb-hdrc
> ...
>
> And that keeps on going until I reconnect the hub.

Sounds like VBUS dropping to me. Remember, MUSB is really anal about
VBUS levels. If it drops enough for the PHY to report one of those 4
VBUS levels, then MUSB just gives up.

What we used to do back at Nokia was disable reporting of some of those
VBUS levels at the PHY driver.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYHEdqAAoJEMy+uJnhGpkGAu0QAMbPYtYzymFEkc2JXOFo6ILJ
vWSrm2pappUW0b1apbCVF4OgBxkyO5bBMo3g23/W5sf9WZpulKyiG2uvo1Di7rt9
zmYIbO9hKwYZpo2LxTsMIYSt9d0yu6QY4azpNp/kW4vYPx/EuMfurqRPgTdTtxqR
1wVAiK2VP32X8R3sTpIUOSLM9X3XQq2/M0rnYDNZqfgjrbQLBKfQrUXhJvd0fyKD
CHEEw540pU+FyS0ioKGQoF/4K1wkjzKNb09s+Pmve1tJGadgkZkm6YZWEzb6r1de
jAwJjj/02OhfCm7iIWcFYbCPqj8AzVjcUf0ws6bvxcKO7EfXHaGKy5hIErCHUfaJ
o7JvUcz3irRSWkGLEf7yON01/wtB0h89pgQDt0IoxbFkuT6cGJiGxxBrXsiHp9XM
sAQMly+v6el9USlbA+Vsi0m8cB77PiVZP/pPs00b0vfRI2AFrR0FAelw8HZEGVt/
dne/0vC/oJopvzwvoHsd7n6ypfvLJlVC7O+wmkteLrlxhyUKVoYrSYjWY7dLy63T
PBqddMqnu1c4owOihOeukVQksm0lhS8bEC8RiD29bF8gObQ8k9BEr6zB19j0+3Ks
UFxrVyc6GCGlWQs7w/bSCZKILF8YBoaJarDv0ZNi+23nLDA06emoKmc/Cs0Ltcly
Z/DO2sISbMiq0o4PJwoj
=RDvu
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
