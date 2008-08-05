From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [patch 2.6.26-omap-git] beagle LED fixes
Date: Tue, 5 Aug 2008 10:13:34 +0200
Message-ID: <EAD57A58-81F7-45A9-95CB-69FC5068885F@student.utwente.nl>
References: <200808042356.16674.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14--901353633"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45026 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165AbYHEION (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Aug 2008 04:14:13 -0400
In-Reply-To: <200808042356.16674.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-14--901353633
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 5 aug 2008, om 08:56 heeft David Brownell het volgende geschreven:

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
> Update and fix Beagle LED declarations:  gpios for USR0 and USR1
> were swapped, and their names don't match docs or silksreen.

I just heard that from TI and wanted to fix that today :) I didn't  
notice it because revA board have the leds shorted together so they  
both light up at the same time.

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Koen Kooi <koen@openembedded.org>

>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> --- a/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04  
> 22:08:16.000000000 -0700
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04  
> 22:08:36.000000000 -0700
>
> @@ -75,14 +76,14 @@ static struct omap_lcd_config omap3_beag
>
> struct gpio_led gpio_leds[] = {
> 	{
> -		.name			= "beagleboard::led0",
> +		.name			= "beagleboard::usr0",
> 		.default_trigger	= "none",
> -		.gpio			= 149,
> +		.gpio			= 150,
> 	},
> 	{
> -		.name			= "beagleboard::led1",
> +		.name			= "beagleboard::usr1",
> 		.default_trigger	= "none",
> -		.gpio			= 150,
> +		.gpio			= 149,
> 	},
> };
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-14--901353633
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFImAuwMkyGM64RGpERAqXJAJ9O531ZdQg/B0dppkJyKpeiLVtMRwCgjB05
CDJqQvIJ03nBNHYEt4trvv8=
=cbrT
-----END PGP SIGNATURE-----

--Apple-Mail-14--901353633--
