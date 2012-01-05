From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] OMAP/I2C - Fix timeout problem during suspend.
Date: Thu, 5 Jan 2012 18:10:26 +1100
Message-ID: <20120105181026.24b8c0f4@notabene.brown>
References: <20111230124030.12c3d02c@notabene.brown>
	<87boqjaz5n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/knpVEH+fr0iZ4ZOYUyUOD3u"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87boqjaz5n.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/knpVEH+fr0iZ4ZOYUyUOD3u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Jan 2012 14:19:48 -0800 Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:

> +Felipe
>=20
> NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> writes:
>=20
> > On a board with OMAP3 processor and TWL4030 Power management,
> > we need to talk to the TWL4030 during late suspend but cannot
> > because the I2C interrupt is disabled (as late suspend disables
> > interrupt).
>=20
> I'm not convinced this is the right solution to this problem.
>=20
> IMO, this problem is caused by the MUSB driver being broken for
> suspend/resume.  I've reported this problem (and an RFC/PATCH)
> already[1], but I don't think the driver has been fixed.
>=20
> Can you try my patch[1] to see if it fixes your problem as well?
>=20
> Kevin
>=20
> [1] http://marc.info/?l=3Dlinux-omap&m=3D132252827112721&w=3D2
>=20

Yes... and no.

I reverted my patch to confirm that the timeout messages come back which
they did.
I then applied your patch and the suspend was nice and smooth again with no
timeouts.  So that is good.

However immediately after I wake it up I get:

[  109.193054] Powerdomain (core_pwrdm) didn't enter target state 1
[  109.199310] Could not enter target state in pm_suspend

whereas with my patch in place I get:

[  123.666046] Successfully put all powerdomains to target state

Following this hint I looked into current draw.  With my patch I get a
suspend-time current draw of 60-80mA (which is still too high..).
With your patch in place I get 120mA or more (about 4 tests, definitely at
least 30mA difference).  I measure this by checking the 'charge_now' report=
ed
by the bq27000 in the battery.

This is without the usb cable plugged in.  With usb plugged in your version
has the positive effect that charging continues while in suspend while with
mine it doesn't.  But I don't think that justifies the extra current drain =
:-)

So I'll be sticking with my patch for now.

My next problem I need to resolve relates to i2c and the charger as well.
When entering suspend the various twl4030 interrupts are disabled by not
masked.  This means they can still fire but are not handled until after
suspend.  This effectively blocks other interrupts from the twl4030 that I
actually want (like the RTC alarm).
I think there are at least 3 or 4 bugs in here making it rather hard to sort
out.  However I think I will want to mask interrupt sources when they are
disabled.  To mask the interrupts I need to talk to the twl4030 over i2c.
And this means that I need the i2c interrupt to still be working.

So I feel that my patch might be more generally useful.  However I confess
that there is a lot here that I don't completely understand, and I might ha=
ve
a different opinion tomorrow.

Thanks,
NeilBrown


--Sig_/knpVEH+fr0iZ4ZOYUyUOD3u
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTwVM4jnsnt1WYoG5AQLmRA/+L+GDHyyweJuo5Ot4BJzPjb3rPnHZN25A
Qo/+0mhgwMtZylDj+m3gAEeD3XqdnjlY4Ck4+lrstynNUWze8GatN+BVCGHbz6fS
kXhgXZlXukU5Uk69tDDYwvn+QM+8dhw/902zQ0Z6Ew9ngM/GasW/e+gf3hAiIKCo
F3rgJctW3/S92KU/bBGfUJAETSpeZcbCO/9953ujsNNs9FcHVO6YJ+Eh301S4BpO
AHXTUuzhyJCuhOH26rSvM5V8ZiAGQ6pSRkGiKhZ/6dP3DzCDp66lPQSouRFMBHII
G2HtoLplSSGHBHaPkHrrswC7DtTPPGhJ/GGvcCBbTKR76u28JIQxaoJfZPiWLolm
dZHkOiqbQJYzg+alBUgAjN9KLvOIZ4XUeS3YN624noxzNYJ19FtyZXXIYUtf3CN+
EEoyIbJ8eL/dgShHwDfDbODd+5xTlOzg3+P8sLhu9fyZmx4cNXEshxVnZm5Ps/pf
IzGEV/R/u+pfNLo4ZHH5L3AlRSbmhLq53dFalrzybGnY0HomshRPMfyvFVbroEEG
v1Q8KF0WkdHQeuzMy4ugOXS3SGseKrJF9fZkHOcdg72cLL/4LLsCuVCoNuqPgxmB
xAfR04oIjwb0l27rYyjjfvns22NsI2l9e+3kO7qyMqKpLLGX2WxYkHuD7ubIpJhx
rEX7Uuc0Tdo=
=OaJS
-----END PGP SIGNATURE-----

--Sig_/knpVEH+fr0iZ4ZOYUyUOD3u--
