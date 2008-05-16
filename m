From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH] This patch adds the driver to turn on the TFP410
	framer to get DVI output working on the beagleboard
Date: Fri, 16 May 2008 13:11:55 +0300
Message-ID: <20080516101155.GB10078@intune.research.nokia.com>
References: <1210929155-30541-1-git-send-email-koen@openembedded.org> <1210929155-30541-2-git-send-email-koen@openembedded.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51710 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYEPKKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:10:41 -0400
Content-Disposition: inline
In-Reply-To: <1210929155-30541-2-git-send-email-koen@openembedded.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <koen@openembedded.org>
Cc: linux-omap@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2008 at 11:12:35AM +0200, ext Koen Kooi wrote:
> +static int omap3beagle_panel_init(struct lcd_panel *panel,
> +				struct omapfb_device *fbdev)
> +{
> +	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
> +        X

... ?

> +
> +	return 0;
> +}

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILV3r68xJuWtYYdURAk7zAJ0bFpmpifLHBOnivXcr7uVxnHjdQACgo9CH
gbMIdG1di5Nct7xWKRpfqfc=
=7Kde
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
