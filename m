From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Fri, 23 Jan 2009 09:00:01 +0100
Message-ID: <A11F15D6-F171-4D62-ADB9-1508B57037E4@beagleboard.org>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-987331304"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:15219 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZAWIAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 03:00:10 -0500
Received: by ey-out-2122.google.com with SMTP id 22so917777eye.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 00:00:08 -0800 (PST)
In-Reply-To: <1232047837-23052-1-git-send-email-koen@openembedded.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Beagle Board <beagleboard@googlegroups.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-987331304
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 15 jan 2009, om 20:30 heeft Koen Kooi het volgende geschreven:

> From: Koen Kooi <koen@beagleboard.org>
>
> Changing it to 100kHz is needed to make more devices works properly.  
> Controlling the TI DLP Pico projector[1] doesn't work properly at  
> 400kHz, 100kHz and lower work fine. EDID readout is unaffected by  
> this change.
>
> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
>
> Signed-off-by: Koen Kooi <koen@beagleboard.org>

Any comments on this patch?

regards,

Koen




>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index fe97bab..f279404 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -227,7 +227,7 @@ static int __init omap3_beagle_i2c_init(void)
> #ifdef CONFIG_I2C2_OMAP_BEAGLE
> 	omap_register_i2c_bus(2, 400, NULL, 0);
> #endif
> -	omap_register_i2c_bus(3, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 100, NULL, 0);
> 	return 0;
> }
>
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1-987331304
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJeXkDMkyGM64RGpERAqWHAKCGjsg2TcRWwQ8KWx2i59sUvRWPAwCffslZ
+hKGvFAZgFfvHzGJcT0GFSg=
=KbPo
-----END PGP SIGNATURE-----

--Apple-Mail-1-987331304--
