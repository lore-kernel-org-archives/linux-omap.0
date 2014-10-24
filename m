From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
Date: Fri, 24 Oct 2014 14:29:48 -0500
Message-ID: <20141024192948.GE11455@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
 <20141024160845.GM26941@saruman> <20141024190251.GB19377@localhost>
 <20141024192540.GD11455@saruman>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2169792607324695941=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141024192540.GD11455@saruman>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============2169792607324695941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 24, 2014 at 02:25:40PM -0500, Felipe Balbi wrote:
> On Fri, Oct 24, 2014 at 09:02:51PM +0200, Johan Hovold wrote:
> > [ +CC: Russell ]
> >=20
> > On Fri, Oct 24, 2014 at 11:08:45AM -0500, Felipe Balbi wrote:
> >=20
> > > I tested this entire series with my BBB and it still works fine. Howe=
ver
> > > I still get below panic. This time without any DRM errors:
> > >=20
> > > [   63.087832] Kernel panic - not syncing: Attempted to kill init! ex=
itcode=3D0x00000000
> > > [   63.087832]=20
> > > [   63.097399] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 3.18.0=
-rc1-00095-g8524e69 #556
> > > [   63.106060] [<c00175a4>] (unwind_backtrace) from [<c00132f0>] (sho=
w_stack+0x20/0x24)
> > > [   63.114160] [<c00132f0>] (show_stack) from [<c0657404>] (dump_stac=
k+0x8c/0xa4)
> > > [   63.121706] [<c0657404>] (dump_stack) from [<c0654f70>] (panic+0xa=
0/0x220)
> > > [   63.128895] [<c0654f70>] (panic) from [<c0049e64>] (do_exit+0x974/=
0x9d0)
> > > [   63.135900] [<c0049e64>] (do_exit) from [<c006775c>] (SyS_reboot+0=
x14c/0x1e8)
> > > [   63.143361] [<c006775c>] (SyS_reboot) from [<c000f080>] (ret_fast_=
syscall+0x0/0x48)
> > > [   63.151596] ---[ end Kernel panic - not syncing: Attempted to kill=
 init! exitcode=3D0x00000000
> > >=20
> > > Then again, this also happens by simply calling poweroff without
> > > enabling wakealarm.
> >=20
> > Bah, I forgot to look into that. I haven't seen this myself as I don't
> > use systemd (which does the syscall from process 0).
> >=20
> > Some driver power-off implementations and some arch machine_power_off
> > spin indefinitely (or use an mdelay and WARN) after trying to power off.
> >=20
> > I think this is really a bug in arch/arm that should be fixed
> > analogously to how failed reboot is handled in machine_restart().
> >=20
> > Care to try the patch below?
> >=20
> > I should still add a two-second delay to rtc-omap to avoid the arch
> > error message.
> >=20
> > Andrew, can you update one patch in the series or should I just resend
> > them all (with proper Tested-by tags)?
> >=20
> > > In any case, for the whole series:
> > >=20
> > > Tested-by: Felipe Balbi <balbi@ti.com>
> >=20
> > Thanks for testing!
> >=20
> > Johan
> >=20
> >=20
> > >From aaa1d1d6171c895b6966ba5b738ac7946ada97c7 Mon Sep 17 00:00:00 2001
> > From: Johan Hovold <johan@kernel.org>
> > Date: Fri, 24 Oct 2014 18:53:09 +0200
> > Subject: [PATCH] ARM: fix failed power-off handling
> >=20
> > Make sure to handle failed power off by printing an error message and
> > halting (analogously to how failed reboot is handled).
> >=20
> > Power off can fail for example if the hardware has not been wired up
> > correctly.
> >=20
> > This avoids a kernel panic when called from process 0:
> >=20
> > [   63.087832] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000000
> > [   63.087832]
> > [   63.097399] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 3.18.0-r=
c1-00095-g8524e69 #556
> > [   63.106060] [<c00175a4>] (unwind_backtrace) from [<c00132f0>] (show_=
stack+0x20/0x24)
> > [   63.114160] [<c00132f0>] (show_stack) from [<c0657404>] (dump_stack+=
0x8c/0xa4)
> > [   63.121706] [<c0657404>] (dump_stack) from [<c0654f70>] (panic+0xa0/=
0x220)
> > [   63.128895] [<c0654f70>] (panic) from [<c0049e64>] (do_exit+0x974/0x=
9d0)
> > [   63.135900] [<c0049e64>] (do_exit) from [<c006775c>] (SyS_reboot+0x1=
4c/0x1e8)
> > [   63.143361] [<c006775c>] (SyS_reboot) from [<c000f080>] (ret_fast_sy=
scall+0x0/0x48)
> > [   63.151596] ---[ end Kernel panic - not syncing: Attempted to kill i=
nit! exitcode=3D0x00000000
> >=20
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  arch/arm/kernel/process.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index a35f6ebbd2c2..68c38af5687c 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -212,6 +212,12 @@ void machine_power_off(void)
> > =20
> >  	if (pm_power_off)
> >  		pm_power_off();
> > +
> > +	/* Give a grace period for failure to power off */
> > +	mdelay(1000);
> > +
> > +	pr_err("Power off failed -- system halted\n");
> > +	while (1);
> >  }
>=20
> with this I always get to "Power off failed -- system halted". If I
> switch to v3.18-rc1 vanilla, then it works. So it's definitely caused by
> your rtc-only patches.

ok, so it seems like it takes more than 1 second for things to
propagate. If I increase that mdelay() to 3000, then everything works
fine on my end. I think we should get RMK's input on this 3000ms delay
to machine_power_off(). Should it be generic, or should we add it to our
rtc pm_power_off implementation ?

--=20
balbi

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSqisAAoJEIaOsuA1yqREWq4QAJySPqKIc0D8GgdJKwTKMtFE
7dDB6Cr/IACoeu9vjRbBXTdZG4D9uAtkFuaSCPeiAXJ2Y/U6gE/uF3DP13RDTvs3
LuQBxoC2cwQtb99BjgUnY2vq2PTSxJYIF7tmEATET1qstw4eP5C+GQ20/hOa5dZI
W9ng0Kkhhhn/IQLjtcRvcyto4Q59S3mEjbOxyyrkEMiKCo3G6yPa0zT/HT1rWHM1
YpvZIk+AIdtgXXqRGKyccGzeBlpyOKRdcl5HNQAnSnyS+rPmDOKOWXOcz/TyE63s
6LiUKKGSNr2UxHhZrUgy+oZUHfjCVjSWUs2RFN590LAh3qUlFgwLXqEcydXXBxjz
+PGGZ1r+EmlH+8PMvTAUKxwz/UDiENpDB8/EIxIFP+dP4fCf7Cch2ChrnxKaVLA8
dm3hheeHCgHIdhd15458BZz1b9Muxgv+pyzdhdluuJfey5BTybeKy68Y9WExRHt7
74PElq5tToRcm95ahDSB9cnWTtRS95rmnjmuyxkcqwrMb/HTFLUSE3nvXBi80Kfz
kRMHr2a+xhr0If91d7CibqfbmEE6lskXjTMuI/jg5rKbkhc8CYuWDE3H2udvX6aY
vARGAY+vXlgRL7i3J08U2+Umgu1UOK9K653gBOIW2EeFKcikejWr/OQN2rRv2jeF
teEUvIRJXqriAybGSi3R
=9Xhv
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--


--===============2169792607324695941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2169792607324695941==--
