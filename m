From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
Date: Sat, 14 Jun 2008 10:48:01 +0200
Message-ID: <ECC99C9B-90E9-4D91-9E74-7999D3868D20@student.utwente.nl>
References: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:34176 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYFNMdX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Jun 2008 08:33:23 -0400
Received: from [172.20.1.5] (vpn006039.vpn.utwente.nl [130.89.6.39])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m5ECXCD7015886
          for <linux-omap@vger.kernel.org>; Sat, 14 Jun 2008 14:33:12 +0200
In-Reply-To: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 14 jun 2008, om 02:01 heeft Kanigeri, Hari het volgende geschreven:

>
> This patch adds the dspbridge driver functionality for OMAP3 platform
> to the OMAP GIT kernel. DSP Bridge driver provides features to control
> and communicate with DSP enabling parallel processing for multimedia
> acceleration. It enables the applications running on MCU to offload
> the processing to DSP.
>
> Some of the key features of DSP Bridge are listed below.
>
> - Messaging: Ability to exchange fixed size control messages with DSP.
> - Dynamic memory management: Ability to dynamically map files to DSP
> address
> space.
> - Dynamic loading: Ability to dynamically load new nodes on DSP at run
> time.
> - Power Management: Static and dynamic power management for DSP.
>
> The patch is available at
> http://www.omapzoom.org/pub/dspbridge/dspbridge_mpu_driver.patch
>
> The documents for reference can be accessed from
> http://www.omapzoom.org/pub/dspbridge/db_linux_pguide.pdf
> http://www.omapzoom.org/pub/dspbridge/db_linux_rguide.pdf
> http://www.omapzoom.org/pub/dspbridge/ 
> Linux_Bridge_Integration_3430.pdf
>
> Please let me know your comments on how we can work to include the
> Dspbridge driver source code in OMAP GIT tree.

That still seems to have the OSAL layer. I don't think the linux  
kernel needs code to support things like symbian and windows mobile.

regards,

Koen





>
> Please let me know if you need any additional information or questions
> on dspbridge.
>
> Thank you,
> Best regards,
> Hari
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIU4XDMkyGM64RGpERAp1cAKCl1amRWN9D0LbELsk0veON+TR6RwCfUPv8
TPiGLJ2+cjlf0tneY0UuPHE=
=GFHv
-----END PGP SIGNATURE-----
