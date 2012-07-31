From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx
Date: Tue, 31 Jul 2012 11:45:23 +0300
Message-ID: <1343724323.2633.22.camel@deskari>
References: <20120719200429.GD3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BPHa456mAo1W7749tFjl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39011 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755833Ab2GaIp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 04:45:27 -0400
Received: by lboj14 with SMTP id j14so4499561lbo.35
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:45:24 -0700 (PDT)
In-Reply-To: <20120719200429.GD3850@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>


--=-BPHa456mAo1W7749tFjl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-07-19 at 16:04 -0400, Raphael Assenat wrote:
> On our AM3505 based board, dpi.c complains that there is no VDSS_DSI regu=
lator
> and the framebuffer cannot be enabled. However, this check does not seem =
to
> apply to AM3505/17 chips.
>=20
> I am not the first facing this issue, see this thread from Nov. 2011:
> http://marc.info/?l=3Dlinux-omap&m=3D132147745930213&w=3D2
>=20
> The string 'vdds_dsi' does appear once in the technical reference manual[=
1]
> but there is no corresponding power pin on the package[2]. I failed to=
=20
> locate any signal that could be an equivalent. I am trying to obtain some
> clarifications on TI's forum[3]...
>=20
> In any case, I am currently running with the patch below. In order to kee=
p
> cpu_is_xx uses to a minimum, I check for am35xx once at init time and all=
ow
> dpi.vdds_dsi_reg to be NULL from then on, getting rid of all the other
> cpu_is_omap34xx uses in the process.
>=20
> Your comments would be appreciated. Please also consider for merging.

VDDS_DSI is used to power up some of the DSS pins on OMAP3. I don't know
why the HW was designed like that... If you have a correct image without
the power, then obviously it's not needed.

We don't currently deal with AM3xxx SoCs in any way in the driver. It's
difficult enough trying to handle just OMAP DSS versions, and now we
need to add AM3xxx to the mix. Sigh =3D).

However, I don't want to apply this patch, as we're trying to remove the
cpu_is checks (soc_is goes in the same category).

I guess we need to add entries for the AM3xxx SoCs in the
dss_features.c.

Any idea what other differences AM3xxx has compared to OMAP3?

 Tomi


--=-BPHa456mAo1W7749tFjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF5sjAAoJEPo9qoy8lh71pCoQAKX1V/27fnxvJypBc0pZTx8U
IXRAkSU4pjN1wbK9ko3LU5RBsC5mp5Te7ZVSilv1lkCU3fXIayPO35dRoQv8imln
b+K7LVpioxTmoYnEpu3Q/82F3kUjriDXR75AKmG6MRhvqB5UCzgjXAcID+TToJQw
6TPbec043oH+QIR55Eg8b1SISWI8+pY9GD4YClxrPUGLYaXs/pOP6vLqUa2I0Za7
bn3UAjGmRL9BvCLvCvrm5wg0F1XEISHks2rDpNXj7046u1WUglMphEpG/j0CDxTt
+CBqJqGrWa40tGdHN2YYetv4K8bdK+6PwPvhpndE3jaF3dTw5A0j8sX5qyCdjh7A
MRPq0HeEL9qC73IkTLghBmA3zVhRmIx7e6bFAJ2mYIOLLTQT1R29bvUERFrtYJ4H
bNWA+OEyTDzJym45i+30aNRLba/Bq7LB0vH4qSO0sjLRasO5JuzCVebUYG1rmMKt
PShMxDI8OefGntXrtsDCHJ7a5pDJ2gzXFDIV7LJQfx2b3OUyTTHLFx64zgdEmqYv
7ameVED9YJTcY+EkuASbZ7vgGIh0L43/NqXmmUtDTcM33uEr/HZkBpOfSuSefuOH
qxR1js/IbBiqZitOjsbtLYzDhTtdgbDhE4PSGaw/tNWj//TkwRFvxJvZKcsnZ4pv
kmrywSeOKIlimgbPcaDp
=rZZA
-----END PGP SIGNATURE-----

--=-BPHa456mAo1W7749tFjl--

