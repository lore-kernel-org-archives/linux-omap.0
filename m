From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Fri, 3 Oct 2008 12:19:33 +0200
Message-ID: <132EE04E-D594-4F84-9C2B-D907D3D4CD5E@student.utwente.nl>
References: <200810030136.33838.david-b@pacbell.net> <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8--91162626"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:21233 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbYJCKTy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2008 06:19:54 -0400
In-Reply-To: <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8--91162626
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 3 okt 2008, om 11:45 heeft Felipe Balbi het volgende geschreven:

> without it, otg_get/set_transceiver won't be useful and
> twl4030-usb transceiver won't get to musb code.

Is the 'fix-something' patch still needed, and if yes, why isn't it in  
l-o git yet?

regards,

Koen


>
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> drivers/i2c/chips/twl4030-usb.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/ 
> twl4030-usb.c
> index 133cc0f..922d7d6 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
> {
> 	return platform_driver_register(&twl4030_driver);
> }
> -module_init(twl4030_usb_init);
> +subsys_init(twl4030_usb_init);
>
> static void __exit twl4030_usb_exit(void)
> {
> -- 
> 1.6.0.2.307.gc427
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-8--91162626
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI5fG3MkyGM64RGpERAjFsAJ9yv+1K2kXhyxkzKB5u8mwtKsGf2QCgl2uS
oQ+FA/bMa4H+rU9wQtCiXBM=
=Tym/
-----END PGP SIGNATURE-----

--Apple-Mail-8--91162626--
