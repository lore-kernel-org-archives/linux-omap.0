From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 16:35:26 +0300
Message-ID: <1340890526.5037.93.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CFdQH7YnktJYEFwV3cRB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40008 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336Ab2F1Nfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 09:35:31 -0400
Received: by eaaa12 with SMTP id a12so1043000eaa.30
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 06:35:28 -0700 (PDT)
In-Reply-To: <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-CFdQH7YnktJYEFwV3cRB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:

> > I think among the first things, while enabling HDMI, should be to see
> > if there is really some display connected on the port i.e, HPD
> > asserted. Only if ti_hdmi_4_detect() returned true, should we
> > proceed otherwise wait for HPQ irq.
> >
> > Unconditionally invalidating edid really seems like a regression - we
> > impose atleast 50ms (edid read) as extra cost on
> > hdmi_check_hpd_state(), which kills half the purpose of this patch.
> >
> Sorry a correction. Reading detect() won't work. I suggest we keep HPD
> IRQ enabled for the lifetime of the driver.

By the way, when the device is in system suspend, we surely won't detect
the HPD even if we kept the HPD always enabled. So there we'll miss the
HPD interrupt anyway, and the EDID cache would be invalid.

 Tomi


--=-CFdQH7YnktJYEFwV3cRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7F2eAAoJEPo9qoy8lh71SzoP/0JUYkeOQONjJrX/ZvhRcMN6
xsKgLaP49olRU9eH0ANdH3/rc3p/uq8IVF7rdEJtrWWtrXRRURZr15U+X++6B2yL
Wqblacns9ZhDd9JJaTUVDxRAqlB2NxlZqfAU4ahJQljFKZfDIYFDBF2NEt70IqgB
YIqlyJA+h19WuxU0gHfAVglUEWoclW2Kv8e+YoEopqd01PG5ubZUm/2M+M5kzEBk
r11vUNbo/PlWdNozRC9mC5O0EmOFB9brwxLG6T+HVTwQ/2cqMGrysZwx7nmGyIjE
sgoGHU6J1W8fXRSn5tzaaTlvF2eIL5zOOmGbJs5tzMjsNt6Y2qoI044pR92nS8P6
H9wozAc2y6cX91JibXEWG7VJ9Xvnu7QEmGwWW39lfIrRhUWZ2f0QB+Zh/WFoltHn
eueJdXQYC0VzlbLANm8csw2NiOF+PFx3ajx6pseWX57mlQx85IF81BlahSV8BGEO
o3nUuGpfnY9Qb2Ih+nxgG+HAJFTMPkTtW9gcXkmlkumqYSqkGTiKm7VEs7mFB/6h
IlPyLp9JXP8aL/iVhQD/W4XPMMTg/x4+wIEuLfQ9reokNwcbJ0MpIZjnMsxeBV9/
z6St5YrnMKfi+ngUR4mgfjoVwnNy3fW/ZDVCfSkdjD02a2noUxahAjuKqtPqoSdA
M06205cpC834G+4oO8Va
=81Wx
-----END PGP SIGNATURE-----

--=-CFdQH7YnktJYEFwV3cRB--

