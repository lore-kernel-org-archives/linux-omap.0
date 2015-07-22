From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
Date: Wed, 22 Jul 2015 18:15:54 -0500
Message-ID: <20150722231554.GA19228@deathstar>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437590769-14632-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 22, 2015 at 08:46:09PM +0200, Sebastian Reichel wrote:
> Since commit ddcad7e9068eb omap2_mcspi_set_cs() is called without
> runtime power management requested. Thus the below kernel oops may be
> generated if a device is accessed after the runtime power management
> timeout. This patch fixes the problem by requesting runtime power
> management in omap2_mcspi_set_cs().
>=20
> [   13.933959] Unhandled fault: external abort on non-linefetch (0x10=
28) at 0xfa09802c
> [   13.940490] pgd =3D cfb38000
> [   13.946594] [fa09802c] *pgd=3D48011452(bad)
> [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> [   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt om=
ap_wdt
> [   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1+ =
#363
> [   13.971801] Hardware name: Nokia RX-51 board
> [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
> [   13.991485] LR is at spi_set_cs+0x5c/0x60
> [   13.997985] pc : [<c02bd3ac>]    lr : [<c02baecc>]    psr: 2000001=
3
> [   13.997985] sp : cb1f3dd0  ip : 00000001  fp : 00000004
> [   14.011260] r10: cfce5be8  r9 : 00000fff  r8 : c0654f98
> [   14.017913] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 0000=
0000
> [   14.024505] r3 : 200103dc  r2 : fa098000  r1 : 00000001  r0 : cf09=
bc00
> [   14.031036] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  S=
egment user
> [   14.037689] Control: 10c5387d  Table: 8fb38019  DAC: 00000015
> [   14.044403] Process modprobe (pid: 183, stack limit =3D 0xcb1f2210=
)
> [   14.051300] Stack: (0xcb1f3dd0 to 0xcb1f4000)
> [   14.058105] 3dc0:                                     cf09bc00 c02=
bafa4 cf09bc00 cf09bc00
> [   14.065277] 3de0: bf013444 bf01254c cf0e2230 cf0e2230 00000001 c06=
54f98 00000fff 00000fff
> [   14.072570] 3e00: 00000008 00000002 00000118 00001f40 00000031 cf0=
9bc00 ffffffed bf013444
> [   14.080078] 3e20: 00000031 c0654f98 cb1f2000 00000000 00000000 c02=
bb5c0 cf09bc00 00000000
> [   14.087738] 3e40: bf013454 c027a2f4 00000000 cf09bc00 bf013454 bf0=
13454 00000000 c027a594
> [   14.095367] 3e60: 00000000 cf09bc00 cf09bc34 c027a60c bf013454 cb1=
f3e80 c027a5ac c0278ec8
> [   14.102935] 3e80: cf972c4c cf09d630 bf013454 bf013454 cbb55300 c06=
848d8 00000000 c0279c84
> [   14.110473] 3ea0: bf01327c bf01327d 00000000 bf013454 cb889180 000=
00000 c0654f98 c027b0c8
> [   14.117980] 3ec0: 00000000 bf015000 cb889180 c00095b0 0040003e cfe=
6a080 0040003f 00000000
> [   14.125457] 3ee0: 00080000 cfcf9000 cb1f2000 60000013 0040003e cbf=
1bbc0 00000000 00000001
> [   14.132843] 3f00: bf0134cc cb1f2000 bf0134c0 cb1f3f58 00000000 c04=
352d0 cf801f00 000000d0
> [   14.140136] 3f20: bf0134c0 bf0134c0 0000416c cb889040 00000080 c00=
0ebe4 cb1f2000 c0089f68
> [   14.147308] 3f40: bf0134c0 cbf1bc00 001a9193 0000416c 001f8d20 c00=
8ab30 d0b10000 0000416c
> [   14.154571] 3f60: d0b1267c d0b1252b d0b13514 000016c0 00001ad0 000=
00000 00000000 00000000
> [   14.161865] 3f80: 0000001f 00000020 00000017 00000014 00000012 000=
00000 00201208 00000000
> [   14.169097] 3fa0: 00000000 c000ea60 00201208 00000000 001f8d20 000=
0416c 001a9193 00000000
> [   14.176177] 3fc0: 00201208 00000000 00000000 00000080 00208c20 001=
a9193 bee09e98 00000000
> [   14.183197] 3fe0: b6f742b4 bee09ae4 000153f0 000093e4 60000010 001=
f8d20 72757463 69665f65
> [   14.190277] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (s=
pi_set_cs+0x5c/0x60)
> [   14.197479] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup=
+0xd4/0x10c)
> [   14.204833] [<c02bafa4>] (spi_setup) from [<bf01254c>] (tsc2005_pr=
obe+0x104/0x484 [tsc2005])
> [   14.212249] [<bf01254c>] (tsc2005_probe [tsc2005]) from [<c02bb5c0=
>] (spi_drv_probe+0x50/0x6c)
> [   14.219818] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really=
_probe+0xd4/0x230)
> [   14.227478] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_=
probe_device+0x30/0x48)
> [   14.235290] [<c027a594>] (driver_probe_device) from [<c027a60c>] (=
__driver_attach+0x60/0x84)
> [   14.243286] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_=
for_each_dev+0x50/0x84)
> [   14.251281] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus=
_add_driver+0xcc/0x1e0)
> [   14.259246] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (drive=
r_register+0x9c/0xe0)
> [   14.267272] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_o=
ne_initcall+0x100/0x1b0)
> [   14.275421] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_i=
nit_module+0x58/0x1bc)
> [   14.283477] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_i=
nit_module+0x54/0x64)
> [   14.291412] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_=
fast_syscall+0x0/0x3c)
> [   14.299407] Code: e5823018 e5902188 e5922000 e582302c (e592302c)
> [   14.307403] ---[ end trace d21553dcaefcb5ac ]---
>=20
> Reported-By: Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Fixes: ddcad7e9068eb (spi: omap2-mcspi: Fix native cs with new set_cs=
)
> Tested-By: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Hi Mark,
>=20
> Previous discussion about this patch happened in the following thread=
:
>=20
> https://lkml.org/lkml/2015/7/11/98
>=20
> Michael also tested the patch, but have not explicitly written an
> Tested-By, so you may want to wait for feedback from him. The patch
> should be sent for 4.2-rc, which introduced the regression.
>=20
> -- Sebastian
> ---
>  drivers/spi/spi-omap2-mcspi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mc=
spi.c
> index 5867384..3d09e0b 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct s=
pi_device *spi, int enable)
> =20
>  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>  {
> +	struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
>  	u32 l;
> =20
>  	/* The controller handles the inverted chip selects
> @@ -255,6 +256,12 @@ static void omap2_mcspi_set_cs(struct spi_device=
 *spi, bool enable)
>  		enable =3D !enable;
> =20
>  	if (spi->controller_state) {
> +		int err =3D pm_runtime_get_sync(mcspi->dev);
> +		if (err < 0) {
> +			dev_err(mcspi->dev, "failed to get sync: %d\n", err);
> +			return;
> +		}
> +

Acked-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
=20
>  		l =3D mcspi_cached_chconf0(spi);
> =20
>  		if (enable)
> @@ -263,6 +270,9 @@ static void omap2_mcspi_set_cs(struct spi_device =
*spi, bool enable)
>  			l |=3D OMAP2_MCSPI_CHCONF_FORCE;
> =20
>  		mcspi_write_chconf0(spi, l);
> +
> +		pm_runtime_mark_last_busy(mcspi->dev);
> +		pm_runtime_put_autosuspend(mcspi->dev);
>  	}
>  }
> =20
> --=20
> 2.1.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
