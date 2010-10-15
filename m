From: Nishanth Menon <nm@ti.com>
Subject: Re: [Added craneboard support 0/1]
Date: Fri, 15 Oct 2010 08:15:02 -0500
Message-ID: <4CB853D6.5030201@ti.com>
References: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53588 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911Ab0JONPF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Oct 2010 09:15:05 -0400
In-Reply-To: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Kridner, Jason" <jdk@ti.com>, "nagendra@mistralsolutions.com" <nagendra@mistralsolutions.com>, "umeshk@mistralsolutions.com" <umeshk@mistralsolutions.com>

srinath@mistralsolutions.com had written, on 10/15/2010 05:27 AM, the 
following:
> From: Srinath <srinath@mistralsolutions.com>
> 
> This series adds support for the AM3517/05 based craneboard. We are a team of
> engineers working at Mistral Solutions and will be sending patches to support 
> this board. Request you to review and accept these patches.
> 
> Added board file for AM3517/05 craneboard
> 
> Srinath (1):
>   Added-craneboard-basic-support
> 
>  arch/arm/configs/omap2plus_defconfig    |    1 +
>  arch/arm/mach-omap2/Kconfig             |    6 +++
>  arch/arm/mach-omap2/Makefile            |    2 +
>  arch/arm/mach-omap2/board-am3517crane.c |   68 +++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517crane.c

Few suggestions:

Please read:
http://omapedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails
http://elinux.org/Git_usage
on how to generate patches and post them
for example this covering letter is completely unnecessary,
the patch1 $subject should have been:
OMAP: AM3517/05: board: Add craneboard support

All this info that you put in covering letter should have been part of 
the patch - remember to add a link to craneboard - most of us might not 
be aware of this board at all. this is the information that will be 
stored in git commit log for ever+ it has to also flow down from 
linux-omap down to linux-arm, lkml etc.. imagine yourself being a 
developer for ppc/intel processor and looking at this patch - the commit 
message and $subject should explain to them as well..

more as part of patch 1 review comments.

-- 
Regards,
Nishanth Menon
