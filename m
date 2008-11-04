From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Tue, 4 Nov 2008 18:28:19 +0100
Message-ID: <D518F5F9-95AB-4881-BD63-8135263203AC@student.utwente.nl>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13-551880383"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:34097 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498AbYKDRlo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2008 12:41:44 -0500
In-Reply-To: <20081104161038.19071.98198.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13-551880383
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 4 nov 2008, om 17:10 heeft Tomi Valkeinen het volgende geschreven:

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>
> arch/arm/mach-omap2/board-omap3beagle.c |  121 ++++++++++++++++++++++ 
> ++++++---
> 1 files changed, 108 insertions(+), 13 deletions(-)
>
> +static struct omap_display_data beagle_display_data_dvi = {
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.name = "dvi",
> +	.panel_name = "panel-dvi",
> +	.u.dpi.data_lines = 24,
> +	.panel_reset_gpio = 170,
> +	.panel_enable = beagle_enable_dvi,
> +	.panel_disable = beagle_disable_dvi,

gpio 170 is the enable (or disable, I forget which) for the DVI framer  
(TFP410), not a reset gpio. It would be nice to have a way to enable/ 
disable the framer  from userspace since it burns 60-100mA.

regards,

Koen

--Apple-Mail-13-551880383
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJEIY2MkyGM64RGpERAjEDAKC7YKhdUigbFqKmpkpcLxnHbfHGPQCgsXqf
+NFhOcY/oGcwwhXLKz5fv2E=
=/upL
-----END PGP SIGNATURE-----

--Apple-Mail-13-551880383--
