From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] Add LCD support for the LogicPD OMAP3530 DevKits
Date: Wed, 09 May 2012 10:16:15 +0300
Message-ID: <1336547775.2724.7.camel@deskari>
References: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
	 <1336418480-32635-3-git-send-email-ashwin.bihari@logicpd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-QtBCOxVuOJ/VL8Eiwfpl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60731 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752353Ab2EIHQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:16:25 -0400
Received: by lban1 with SMTP id n1so4781691lba.24
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 00:16:23 -0700 (PDT)
In-Reply-To: <1336418480-32635-3-git-send-email-ashwin.bihari@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <ashwin.bihari@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


--=-QtBCOxVuOJ/VL8Eiwfpl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-07 at 15:21 -0400, Ashwin Bihari wrote:
> Use the generic DSS panel driver that provides support for
> the 4.3" Sharp LQ043T1DG01 that comes standard on the
> OMAP3530 SOM-LV and Torpedo DevKits.
>=20
> Signed-off-by: Ashwin Bihari <ashwin.bihari@logicpd.com>
> ---
>  arch/arm/mach-omap2/board-omap3logic.c |  147 ++++++++++++++++++++++++++=
++++++
>  1 files changed, 147 insertions(+), 0 deletions(-)

<snip>

> +static int omap3logic_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(LCD_PANEL_PWR, 1);
> +	if (machine_is_omap3530_lv_som())
> +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 1);
> +	else if (machine_is_omap3_torpedo()) {
> +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 1);
> +
> +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap3logic_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(LCD_PANEL_PWR, 0);
> +	if (machine_is_omap3530_lv_som())
> +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 0);
> +	else if (machine_is_omap3_torpedo()) {
> +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 0);
> +
> +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 0);
> +	}
> +
> +	return 0;
> +}

This doesn't play well with device-tree. We can't do such callbacks when
we move to DT.

I know we have similar code for other boards, and this can't be properly
fixed right now, but I'm still a bit hesitant to add more such code
because I'm the one that has to clean it up later for DT =3D).

I can handle the LCD_PANEL_PWR gpio, but the backlight is something that
should be removed from the panel enable callbacks. You could look at
drivers/video/backlight/ and see if there's something there that could
be used for your board. Or implement a new BL driver, if nothing fits.

 Tomi


--=-QtBCOxVuOJ/VL8Eiwfpl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqhm/AAoJEPo9qoy8lh71JcEP/RR+ntTONrp1exdaV3F2GNK+
NJwUVmMPljMyVZHj6Pb+tPjAj2FiYdWoCtPqscJZR22ru7ZRWPRrN4Smn2WQiYsN
CFTEZdLeNTTYOb416Dtog8kXlXsuBm4bnKhlHyMzXTZfmW1UrDwAt3bhUS60p+pK
w/Cnxx4KDMLp3pE8J068NZtr56dfcoE3yffQ+lGwj5IA4vQ6e4v4Qs75Q08XW98U
u47cAbeiZIYhZ3E3/mTL/+iNJ+8kM2121gU4eNQ0GKlE5k/EwwZxUcrMsWQwtnHs
iOTQxEYS3RzY0gXMXmi8PR5+FDzjL8E8LRY3iNoNUU93rm+oLGgrw/9Biz0bISay
hmbgH7nSQLLXnB7cOpDmozobIY1ZDjFtbTEWyutnFxAC5wvzTm2ONWEO4mvo8sff
stEo9B8cMZ7/6s20B6jIcSHnKOieFTJse/ImpinCOpp1tJe0TAcJS7tMAUEmuiCq
vnKf8raAFvlpKcHDqNFkaQzHs4hKvCXi306v3jLNci+N7UG3brOzuQBvKe6Ebiog
7OGsuiC4orOrmNH43vin4X9xS+uwe8Ew9x+0A/lC2A0ez/zcRF9fL6WVWzQhuCzB
RIynuO1gbgEe3Q0cSyye4vEqRjNhW76Mnv/rVmSUJEqMrFOLaTfNZfqaTJTpNXrp
cHmTSDxCFoFgXiZEdkCa
=cyw/
-----END PGP SIGNATURE-----

--=-QtBCOxVuOJ/VL8Eiwfpl--

