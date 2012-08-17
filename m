From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V4 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Fri, 17 Aug 2012 16:54:52 +0300
Message-ID: <1345211692.3158.160.camel@deskari>
References: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
	 <1345115913-6773-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-yDzCBgc3GfHBxhLwOIz4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:43506 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752240Ab2HQNy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 09:54:58 -0400
Received: by lbbgk1 with SMTP id gk1so2251266lbb.12
        for <linux-omap@vger.kernel.org>; Fri, 17 Aug 2012 06:54:55 -0700 (PDT)
In-Reply-To: <1345115913-6773-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-yDzCBgc3GfHBxhLwOIz4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 16:48 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dss_init_features function provi=
ding a
> much more generic and cleaner interface. The OMAP version and revision sp=
ecific
> initializations in various functions are cleaned and the necessary data a=
re
> moved to dss_features structure which is local to dss.c.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>

> +static int __init dss_init_features(struct device *dev)
> +{
> +	dss.feat =3D devm_kzalloc(dev, sizeof(*dss.feat), GFP_KERNEL);
> +	if (!dss.feat) {
> +		dev_err(dev, "Failed to allocate local DSS Features\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (cpu_is_omap24xx())
> +		dss.feat =3D &omap24xx_dss_features;
> +	else if (cpu_is_omap34xx())
> +		dss.feat =3D &omap34xx_dss_features;
> +	else if (cpu_is_omap3630())
> +		dss.feat =3D &omap3630_dss_features;
> +	else if (cpu_is_omap44xx())
> +		dss.feat =3D &omap44xx_dss_features;
> +	else
> +		return -ENODEV;
> +
> +	return 0;
> +}

This is not correct (and same problem in dispc). You allocate the feat
struct and assign the pointer to dss.feat, but then overwrite dss.feat
pointer with the pointer to omap24xx_dss_features (which is freed
later). You need to memcpy it.

I also get a crash on omap3 overo board when loading omapdss:

loading nfs/work/linux/drivers/video/omap2/dss/omapdss.ko debug=3Dy def_dis=
p=3Dlcd43
[   20.411224] Unable to handle kernel NULL pointer dereference at virtual =
address 00000008
[   20.419921] pgd =3D ce8a8000
[   20.422790] [00000008] *pgd=3D8e8c5831, *pte=3D00000000, *ppte=3D0000000=
0
[   20.429473] Internal error: Oops: 17 [#1] SMP ARM
[   20.434448] Modules linked in: omapdss(+)
[   20.438690] CPU: 0    Tainted: G        W     (3.5.0-rc2-00058-g1c1e55c =
#93)
[   20.446350] PC is at omap_dsshw_probe+0xa4/0x290 [omapdss]
[   20.452148] LR is at 0x2e39
[   20.455108] pc : [<bf043288>]    lr : [<00002e39>]    psr: 80000013
[   20.455108] sp : ce89ddd0  ip : c0b797e0  fp : 00006133
[   20.467224] r10: 00000028  r9 : c0c5c07c  r8 : bf02eadc
[   20.472717] r7 : 00000000  r6 : c06e9644  r5 : cf0cf808  r4 : bf02f430
[   20.479614] r3 : cf0cf808  r2 : 00000000  r1 : 00000000  r0 : 00000000
[   20.486511] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 user
[   20.494049] Control: 10c5387d  Table: 8e8a8019  DAC: 00000015
[   20.500091] Process insmod (pid: 664, stack limit =3D 0xce89c2f8)
[   20.506347] Stack: (0xce89ddd0 to 0xce89e000)
[   20.510955] ddc0:                                     cf0cf808 c0c96ed8 =
c0c96ee8 c02c22e4
[   20.519592] dde0: c02c22cc c02c0f28 22222222 cf0cf808 bf02eadc cf0cf83c =
00000000 00000001
[   20.528198] de00: 00000028 c02c113c bf02eadc c02c10a8 00000000 c02bf6c8 =
cf0192a8 cf0cec10
[   20.536834] de20: bf02eadc c072fab8 cf3e7440 c02c05dc bf0249e0 00000000 =
cf04ce40 bf02eadc
[   20.545471] de40: c0748880 ce89c000 00000000 00000001 c0c5c07c 00000028 =
00006133 c02c1670
[   20.554107] de60: 00000000 bf02eac8 c0748880 ce89c000 00000000 00000001 =
00000028 c02c26e0
[   20.562744] de80: 00000003 00000000 c0748880 bf043124 00000000 c0748880 =
ce89c000 00000000
[   20.571380] dea0: 00000001 c0008730 bf02f29c 00000001 00000001 bf0430cc =
c071bcd0 00000000
[   20.580017] dec0: bf02f29c c006823c 00000000 ce827ec0 cf0001c0 00000000 =
bf02f29c 00000001
[   20.588623] dee0: ce851480 00000001 c0c5c07c 00000028 00006133 c0099d20 =
bf02f2a8 00007fff
[   20.597259] df00: c0098aa4 c012480c 00000000 c0098890 bf02f3f0 ce89c000 =
c06d32d8 d08fe09c
[   20.605895] df20: d0a19624 000a7008 d08ce000 001f2ab7 d0a18bd4 d0a18948 =
d0aba984 00030ed0
[   20.614532] df40: 0003b0e0 00000000 00000000 00000042 00000043 00000026 =
0000002a 00000014
[   20.623138] df60: 00000000 bf022024 00000043 00000000 00000000 00000000 =
00000000 c0623b14
[   20.631774] df80: 001f2ab7 001f2ab7 00000004 beb48e7c 00000080 c0013f28 =
ce89c000 00000000
[   20.640411] dfa0: 00000000 c0013d60 001f2ab7 00000004 b6c49008 001f2ab7 =
000a7008 beb48e7c
[   20.649047] dfc0: 001f2ab7 00000004 beb48e7c 00000080 000a47f8 00000000 =
b6f80000 00000000
[   20.657684] dfe0: beb48bb8 beb48ba8 00019dfc b6f10020 60000010 b6c49008 =
00000000 00000000
[   20.666442] [<bf043288>] (omap_dsshw_probe+0xa4/0x290 [omapdss]) from [<=
c02c22e4>] (platform_drv_
probe+0x18/0x1c)
[   20.677276] [<c02c22e4>] (platform_drv_probe+0x18/0x1c) from [<c02c0f28>=
] (driver_probe_device+0x
9c/0x21c)
[   20.687499] [<c02c0f28>] (driver_probe_device+0x9c/0x21c) from [<c02c113=
c>] (__driver_attach+0x94
/0x98)
[   20.697418] [<c02c113c>] (__driver_attach+0x94/0x98) from [<c02bf6c8>] (=
bus_for_each_dev+0x50/0x7
c)
[   20.706970] [<c02bf6c8>] (bus_for_each_dev+0x50/0x7c) from [<c02c05dc>] =
(bus_add_driver+0xa0/0x2a
8)
[   20.716522] [<c02c05dc>] (bus_add_driver+0xa0/0x2a8) from [<c02c1670>] (=
driver_register+0x78/0x17
4)
[   20.726074] [<c02c1670>] (driver_register+0x78/0x174) from [<c02c26e0>] =
(platform_driver_probe+0x
18/0x9c)
[   20.736267] [<c02c26e0>] (platform_driver_probe+0x18/0x9c) from [<bf0431=
24>] (omap_dss_init+0x58/
0x118 [omapdss])
[   20.747192] [<bf043124>] (omap_dss_init+0x58/0x118 [omapdss]) from [<c00=
08730>] (do_one_initcall+
0x34/0x194)
[   20.757568] [<c0008730>] (do_one_initcall+0x34/0x194) from [<c0099d20>] =
(sys_init_module+0xdc/0x1
cc4)
[   20.767333] [<c0099d20>] (sys_init_module+0xdc/0x1cc4) from [<c0013d60>]=
 (ret_fast_syscall+0x0/0x
3c)
[   20.776947] Code: ea00000d e5941248 e3a00000 e584600c (e5911008)=20
[   20.783599] ---[ end trace bcb6e89e4ea810ae ]---



--=-yDzCBgc3GfHBxhLwOIz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLk0sAAoJEPo9qoy8lh71EB4QAJh6FN7zMaVeACxbHH06gVHe
/SO5t6MTnjvdoMXR+ZyNhW3ukXXbUCJeWbIprNWcCx0MNTPoBJbw74X0GRnzxWa+
ayElKEUeaFD7hIKiZQdiLySrELLl7semLpMUL+yj0yPgxYIqH8QmNw+OTSYZ1+td
DOn5+z6hnM6QaX/fzafudM2NB+ZHneCevowOIjq9Q5sT2f/8gpeLgjCUw62LqkB4
KuKSUDwAvrIyvnCx/EhbHwApHVXiyDva0X6s4pTPy1epB0/Hoy2a3HBaiLW3EkZT
WYrWxKNSohAgkdJm3Jrh1pfPtcmhklT/h+2mh6trMbYLNyeYu1p+xFlUWPz10qnr
hg8M3tfI9gH0bSDZkhmb2nZCaERa27HDTFQCWqefvdRLhLJEbyfYiKkpVNHyA5bG
H8f+IP2pVfbvU7NlLB6hwVtTQNkwrBnTDGI6uXM8Mwqr+PfKD01QKjeuyiQOJeL0
+X139UcswM5NoKYnpJl7ORWLmfx7Oc2JH/QLxD1IcSy/GpwJJmO2kiAnSEqrFMPj
7pBfLk+vhXNO9LtlKI50kFP+RyE57rP8lKqCdGXKg4EZCiSFAV5H9JTGrjc6oWW5
xnVGoZ247X8yw9HYARLhmKJErX2wJnW8MtkDVimKEyxn7RL7bigkxzEwMCfWAErK
3z2FRC/KBNbhg9lGTTTI
=FSFh
-----END PGP SIGNATURE-----

--=-yDzCBgc3GfHBxhLwOIz4--

