From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/3] omap3 nand: cleanup exiting platform related
 code
Date: Fri, 9 Jul 2010 11:32:56 +0300
Message-ID: <20100709083256.GI24913@atomide.com>
References: <1278660308-8689-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58394 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GIIdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 04:33:01 -0400
Content-Disposition: inline
In-Reply-To: <1278660308-8689-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [100709 10:19]:
>    The following set of patches applies on top of for-next branch.
> 	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
>    Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and beagle board
> 
>    And these are the patches required to address the following input -
>      1. The NAND driver needs to stop tinkering with the GPMC registers
> 	The omap General Purpose Memory Controller (GPMC) registers are omap
>         specific, and not driver specific. Tinkering with these registers can
>         cause issues with the other devices on the GPMC.
> 
>      2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
> 	Passing hardcoded GPMC virtual addressess is sure way to mess up things.
>         This should all become unnecessary once the NAND drivers stops messing
>         with the GPMC registers directly.

Looks good to me, thanks for doing this.

One more request: Please repost this series one more time with linux-arm-kernel
mailing list Cc'd. Then if no comments, I'll merge this series during the next
merge window.

Regards,

Tony
