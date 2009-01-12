From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Mon, 12 Jan 2009 16:39:39 +0100
Message-ID: <B5CEECBB-9939-46B9-BEDB-D8D9879DB63E@student.utwente.nl>
References: <20090112145051.GL9373@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-64508957"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:60616 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZALPjt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 10:39:49 -0500
Received: from [172.20.1.5] (vpn006129.vpn.utwente.nl [130.89.6.129])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0CFdKKL018644
          for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 16:39:40 +0100
In-Reply-To: <20090112145051.GL9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-64508957
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 jan 2009, om 15:50 heeft Tony Lindgren het volgende geschreven:

> Hi all,
>
> I've just tagged v2.6.28-omap1, and looks like we might want to also
> do v2.6.28-omap2 as there are few annoying bugs remaining:
>
> - According to Jarkko Nikula, ASoC does not currently work because of
>  some recent clock changes.

Confirmed on omap3evm.

regards,

Koen

>
>
> - MMC seems to be broken for omap1, Ladislav Michl  might have a patch
>  coming up for that.
>
> - I2C is broken for 2430 according to Kainan Cha.
>
> Also looks like source.mvista.com is down, so please use the  
> kernel.org
> tree.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-6-64508957
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJa2Q7MkyGM64RGpERAhRKAJ9Mfa1CftvNb38iNPg8QUKENPFF2wCfRecf
9soQrJhBFVN+AYIYqX3ft8c=
=HJP7
-----END PGP SIGNATURE-----

--Apple-Mail-6-64508957--
