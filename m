From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: poweroff does not work? calls
Date: Sun, 9 Dec 2018 18:24:04 +0100
Message-ID: <20181209172404.GA4593@amd>
References: <20181209121318.GA24478@amd>
 <20181209164650.GX6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209164650.GX6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 08:46:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> > Hi!
> >=20
> > Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> > seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> > affected. It is bad, because when your battery is low, you get into
> > reboot loop and discharge it furher, which batteries do not like.
> >=20
> > Any ideas, or at least idea how to debug this?
>=20
> Hmm can you check if this is happening with usb unloaded or
> unbind? I suspect ohci or musb..

Ok, let me try: musb unbound, v4.20:

root@devuan:/sys/devices/platform/44000000.ocp/4a0ab000.usb_otg_hs#
echo 4a0ab000.usb_otg_hs > driver/unbind

(I hope I did not pull the USB too late). It rebooted instead of
poweroff. Now on 4.18:

root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll# echo
4a062000.usbhstll > driver/unbind
root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll#
uname -a
Linux devuan 4.18.0-rc4-88970-gf075a2c-dirty #764 SMP Mon Jul 9
12:51:47 CEST 2018 armv7l GNU/Linux

I get nice oops doing that:

[  170.705383] ------------[ cut here ]------------
[  170.710235] WARNING: CPU: 0 PID: 2371 at drivers/clk/clk.c:697
clk_core_unpre
pare+0xcc/0xec
[  170.718749] Unpreparing enabled l3_init_cm:clk:0048:8
[  170.723968] Modules linked in:

root@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.=
ohci#
echo 4a064800.ohci > driver/unbind

=2E.Hmm. I'm not sure how to unbind ehci. Let me try sudo
poweroff... no, it reboots, too.

Can you check if it works for you?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNT7QACgkQMOfwapXb+vKzBACffSEF6vwWVha2uJMPdeAzqeP5
J9IAoJgKqEA/LXbRGiTz5NFIuF3I6xAG
=1Tt9
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
