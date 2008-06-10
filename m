From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 00/02] OMAP3 CPUidle patches
Date: Tue, 10 Jun 2008 22:42:40 +0200
Message-ID: <DF3B0B28-9589-4210-8DF4-1CC2EE60B6D7@student.utwente.nl>
References: <0a2301c8cac8$d9352d70$68bf18ac@ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:37488 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbYFJUm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jun 2008 16:42:58 -0400
In-Reply-To: <0a2301c8cac8$d9352d70$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 10 jun 2008, om 09:08 heeft Rajendra Nayak het volgende geschreven:

> Hi,
>
> The next couple of patches which follow implement the Basic OMAP3  
> CPUidle driver.
>
> The following C states are defined
> C0 - System executing code
> C1 - MPU WFI + Core active
> C2 - MPU CSWR + Core active
> C3 - MPU OFF + Core active
> C4 - MPU CSWR + Core CSWR
> C5 - MPU OFF + Core CSWR
> C6 - MPU OFF + Core OFF
>
> Currently only C0/C1/C2/C4 are enabled as OFF support is missing.
> For now CPUidle is kept disabled by default.

Seems to work on my beagleboard.

regards,

Koen


>
>
> regards,
> Rajendra
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFITudCMkyGM64RGpERAnuDAKCv6C9SSiPxFiYaBJ48McdXD6pgvACcCe55
tP803wO51XzvFGdLjRgptJA=
=o2j3
-----END PGP SIGNATURE-----
