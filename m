From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] OMAPDSS: Misc improvements
Date: Tue, 04 Sep 2012 10:22:48 +0300
Message-ID: <1346743368.2586.1.camel@deskari>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WN5ARJ+ab9dIYZpgDEPv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40198 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557Ab2IDHW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 03:22:58 -0400
Received: by lbbgj3 with SMTP id gj3so2900411lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 00:22:55 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-WN5ARJ+ab9dIYZpgDEPv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Can you check the arch/arm patches below, and suggest how you'd like to
go forward with them?

 Tomi

On Thu, 2012-08-23 at 16:45 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> This series contains miscellaneous improvements for omapdss, which I've m=
ade
> while implementing device tree support for omapdss. This includes some ch=
anges
> to arch/arm/:
>=20
> * remove OMAP4 HDMI gpio handling from board files
> * add vdda_hdmi_dac supply for HDMI to twl-common.c
> * remove DSS clock dividers from 4430sdp board file
>=20
> Tony, omapdss has dependencies to those changes, and the first change als=
o has
> a dependency to omapdss header file. Is it ok to merge them with other om=
apdss
> changes?
>=20
> Chances for conflict are probably pretty small, 1st and 3rd change are
> pure display stuff, and the 2nd adds the supply to a regulator not used b=
y
> anyone else than DSS.
>=20
>  Tomi
>=20
> Tomi Valkeinen (8):
>   OMAPDSS: HDMI: Move GPIO handling to HDMI driver
>   OMAPDSS: HDMI: Add delay to wait for 5V power
>   OMAP4: TWL: add vdda_hdmi_dac regulator supply
>   OMAPDSS: HDMI: use vdda_hdmi_dac
>   OMAPDSS: Add DSI fclk maximum to dss_features
>   OMAPDSS: DSI: calculate dsi clock
>   OMAP: 4430SDP: remove DSI clock config from board file
>   OMAPDSS: fix use of dssdev->caps
>=20
>  arch/arm/mach-omap2/board-4430sdp.c       |   73 +---------------
>  arch/arm/mach-omap2/board-omap4panda.c    |   27 +-----
>  arch/arm/mach-omap2/twl-common.c          |    6 ++
>  drivers/video/omap2/displays/panel-n8x0.c |    1 +
>  drivers/video/omap2/displays/panel-taal.c |    8 ++
>  drivers/video/omap2/dss/dsi.c             |  131 +++++++++++++++++++++++=
++++--
>  drivers/video/omap2/dss/dss_features.c    |    2 +
>  drivers/video/omap2/dss/dss_features.h    |    1 +
>  drivers/video/omap2/dss/hdmi.c            |  101 +++++++++++++++++-----
>  drivers/video/omap2/dss/rfbi.c            |    1 -
>  include/video/omapdss.h                   |    4 +
>  11 files changed, 233 insertions(+), 122 deletions(-)
>=20


--=-WN5ARJ+ab9dIYZpgDEPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQRaxIAAoJEPo9qoy8lh71UBAQAIwnUH9Cn0tvyIjXBJ83MWPj
sDmp3Yd4nvlvO279/WFjSC7ecbgbBZ7lSAYRwesIqrNDKepHwLKwCgO+J4nbfCNL
nbuWn6xkXhcOVJgxS4yyRrpUD95ujlybAs21BH+LRq/hKr6e8RjPMFD/qYiSGVn7
RtlJ39z6bUHQ4Q1MS+gqZmMSaSyU2cSj9enTTzsTtIbqVpSTU5jadYNKJ70xC+n/
hiLWumK9qyq+TJNQB+v9mhkjfKhqpr0d+1w7E6rLOr4d3Ql1LssPFbQyyNER61GP
Ljz2Fekqv0UNwIlpXcLfG/WWQ6b2NwprMosFULN/bmk2bpBTfnVF2D5vy8Adu3s1
13FskC3z9X9JIjpifT4RLQQFrFAHoNVt0WE5dbhKkkAMOv1zsRClQfaf5ab1rP18
YXSunVdHO7YlFlgEX/zYSPVoq6MTj8FVunKOYTCrBTpRPL4sYxaBBhH84iKIMc4F
MbeqNTgw9spUIPWpFEKG6lWBQuKEcR+QuMkC5x5A0PDI2IYKeW8rlDanqSoSxgIR
NYIWJK2F0YsG1ms7l1KTA3xCHgMPkmVpHgzcZpPMLIYv7klkJ9eqpHrxE39D0Gst
p9bIb8ut1gRmmYkVKsC0WD9Ip+7OqZbjV01lbM71T/APs0/pcUGu6nErFNuhXlAa
dQ7dR3IYHNSgsbNPmqQb
=M5D9
-----END PGP SIGNATURE-----

--=-WN5ARJ+ab9dIYZpgDEPv--

