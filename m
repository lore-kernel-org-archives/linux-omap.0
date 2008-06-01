From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/3] OMAP3 Beagle: Enable nand support
Date: Sun, 1 Jun 2008 10:07:50 +0200
Message-ID: <191A72BD-39D5-4D63-96A7-B9C28252EFE6@student.utwente.nl>
References: <5e088bd90805312338j540aef97s4735eba05c736448@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:14491 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbYFAIII (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Jun 2008 04:08:08 -0400
Received: from [172.20.1.5] (vpn006023.vpn.utwente.nl [130.89.6.23])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m5187sGI022936
          for <linux-omap@vger.kernel.org>; Sun, 1 Jun 2008 10:07:54 +0200
In-Reply-To: <5e088bd90805312338j540aef97s4735eba05c736448@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 1 jun 2008, om 08:38 heeft Steve Sakoman het volgende geschreven:

> This series of patches adds nand support to the beagle board.
>
> The first patch in the series builds on work by Teerth Reddy
> <teerth@ti.com> to extend the omap2 nand driver to work with both
> omap2 and omap3 architectures (as well as adding/clarifying comments).
>
> The second patch adds the beagle nand support, and the final patch
> enables the nand driver and jffs2 support in the beagle defconfig.
>
> The patch set was reviewed by Khasim Syed Mohammed <khasim@ti.com>
> prior to this submission.  It was tested on a Rev B beagle board.

It also works on my rev A5 beagle board :)

regards,

Koen



> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIQljZMkyGM64RGpERAuLUAJ4iGlCUBu2LBDQpurvcQCN3QShGDgCgoBeH
6TEsgu94ezlcrAKBA/J1lDE=
=8WMR
-----END PGP SIGNATURE-----
