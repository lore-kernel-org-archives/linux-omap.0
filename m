From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: convert to
 module_platform_driver"
Date: Fri, 03 Aug 2012 11:05:27 +0300
Message-ID: <1343981127.2744.28.camel@deskari>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
	 <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2tR5pY3+x5KKaNGhKPC7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48533 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab2HCIG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 04:06:58 -0400
Received: by lahe6 with SMTP id e6so201737lah.24
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 01:05:30 -0700 (PDT)
In-Reply-To: <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, balbi@ti.com


--=-2tR5pY3+x5KKaNGhKPC7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-02 at 17:54 -0600, Grant Likely wrote:
> On Thu, Aug 2, 2012 at 5:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrot=
e:
> > This reverts commit 9fdca9dfe093c76fe1ac1a09888ba9679d46996a.
> >
> > Changing omap2_mcspi_init() from subsys_initcall to device_initcall bro=
ke
> > the display initialization on N900 when all the drivers are compiled
> > built-in. Display subsystem drivers need a certain initialization order
> > and having all of them initialize with device_initcall seems to be too
> > fragile. Without this revert the display init fails and the boot hangs
> > with the following messages:
> >
> > [    1.260955] acx565akm spi1.2: invalid display ID
> > [    1.265899] panel-acx565akm display0: acx_panel_probe panel detect e=
rror
> > [    1.273071] omapdss CORE error: driver probe failed: -19
>=20
> The dependencies are all messed up. The reverted commit is part of
> fixing that and I don't really want to go backwards on it. How many
> drivers are failing? Can you try modifying the failure path of those
> drivers to return -EPROBE_DEFER and see if that helps?

The description of 9fdca9dfe093c76fe1ac1a09888ba9679d46996a seems to be
overly positive: "this will delete a few lines of code, no functional
changes".

But yes, the probe dependencies with omap's display are quite fragile.
The probe order should be something like (from first to last):

- omapdss, i2c, spi, etc.
- panel drivers
- omapfb

I fear that if we'd use EPROBE_DEFER in a panel driver, it'll lead to
omapfb missing the panel. And we can't use EPROBE_DEFER in omapfb,
because there's no way to know if all the panel drivers are loaded or
not.

I think the only reliable way would be to manage the panels dynamically,
so that omapfb will handle them no matter when they are added/removed.
But that's not done by just changing a few lines...

So, it's broken. One option, although hacky, would be to move all the
spi probe stuff from acx565akm's probe to acx_panel_enable. That will be
called by omapfb during late_initcall, at which point spi should be
available.

Well, I'll see how difficult the dynamic panel add/remove would be to
implement. And probably even dynamic add would be enough for the start.

 Tomi


--=-2tR5pY3+x5KKaNGhKPC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQG4ZHAAoJEPo9qoy8lh71+5EQAJh9ZOcz5/dBnH4h1jtXP0YL
1ze11q1e+37QwA1xywfLaBMGtxQR082de++FXLhoxtyqaFoINqXTz9irF1lxkWKL
pqok20skcCoc19zVeLv61FWqBWXc1XIn6/gE6NfKnKqibOMiaB2rfTbszOiOUhof
3fDZJWrBPuhWYNBGqfUhYsD8c8dxkck/Km2rLAfhJewVK17I9rD6PqlIoCHbutxX
tGSe5Lq0sypAORGdhEqtu0tILukQJm/VaoWTryfVu9y3s/TbIGQtNO/T509RUIgv
fXxcHYumqy7IDXNA2e/MQzxc2tEv2c4sseEz2/ZWYS7u4BggN4nkzXJXEPmmeNek
FSadbAIIJzOMkYTjz47p9UaKoSwOiPlteEM86spw5s52fyQR46zTu+ZFpl+/Dd6E
jI1LOvqftZmlcRZLE4gLM5ljCm7BRLtH4i4QX6qN3oqgcf/vzgrJi5AtO+MKGNSm
vhZ7ElNHn+wUj3mI84sHd/H3zs1k5RR/Qt9RecLJMle0IvzBXgKISQOErP5y/69k
YNvD6bgQQohLsZK3GTvjE1jrrtKktPRWsY49LcyNOnGv/0qFAyevrgiBgYILYYO7
XkxJjjMz/NY0/dvksrAMkf8R9b8fYxE74Mi1vB3Y/Ci+Xq8QONV4zEFgElFrHruv
jWU//vBeupOcKFjoIilY
=svNU
-----END PGP SIGNATURE-----

--=-2tR5pY3+x5KKaNGhKPC7--

