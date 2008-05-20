From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Tue, 20 May 2008 20:27:59 +0200
Message-ID: <0FF0DEE1-9FA6-49ED-9BF3-B9B4AC8627F5@student.utwente.nl>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:45511 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670AbYETS3G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2008 14:29:06 -0400
In-Reply-To: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 5 mei 2008, om 23:23 heeft Eduardo Valentin het volgende geschreven:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>
> Hi Tony,
>
> Here is the updated version of my previous patches.
> DMA and IRQ definitions were left as they are. Chandra is going
> to send his work on top of this series.
>
> This patch series updates mcbsp driver by transforming it into
> a platform driver. This is a very initial implementation.
> Basically it moves machine specific code to their correct place
> and creates the platform driver necessary structures.
>
> It must be working for previous boards. For omap34xx it should
> work for mcbsp 1 and 2.
>
> In order to do not break other places, I tryied to do not change
> previous API. But future improvements are needed.
>
> Clock definitions for  mcbsp 1 and 2 were also modified to add
> correct support for omap34xx.
>
> Comments are wellcome.

These patches seem to be working fine on my OMAP3 beagleboard with  
2.6.26rc3 from linux-omap git.

regards,

Koen


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIMxgxMkyGM64RGpERAriKAKCQdklfDCnr4JGDkS4crbsaqpigSgCdGcn8
7PPzc3KzWyXXV0sMOU6/Bnk=
=3tNi
-----END PGP SIGNATURE-----
