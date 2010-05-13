From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap3 nand: cleanup exiting platform related code
Date: Thu, 13 May 2010 08:44:23 -0700
Message-ID: <20100513154423.GK29368@atomide.com>
References: <s-ghorai@ti.com>
 <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52596 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758777Ab0EMPo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 11:44:29 -0400
Content-Disposition: inline
In-Reply-To: <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com

* Sukumar Ghorai <s-ghorai@ti.com> [100512 02:43]:
>    The following set of patches applies on top of master branch.
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

Thanks for working on this. I've made some comments to you patches
to do what's listed above.

Instead of exporting the GPMC registers, you should create new
functions into gpmc.c for the nand platform init code to use.

Regards,

Tony
