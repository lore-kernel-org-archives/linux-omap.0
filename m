From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: CONFIG_TOUCHSCREEN_ADS7846 XOR
 CONFIG_MTD_NAND_OMAP2 breaks build
Date: Tue, 31 May 2011 06:07:15 -0700
Message-ID: <20110531130715.GL11352@atomide.com>
References: <loom.20110506T210326-622@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58559 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752757Ab1EaNHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 09:07:17 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110506T210326-622@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Scheer <scheer@in.tum.de>
Cc: linux-omap@vger.kernel.org

* Matthias Scheer <scheer@in.tum.de> [110506 12:09]:
> #ifdef clauses in arch/arm/mach-omap2/common-board-devices.h header file broke
> kernel build when configured with CONFIG_TOUCHSCREEN_ADS7846 (XOR)
> CONFIG_MTD_NAND_OMAP2
> 
> quick and dirty fix by using #ifdef clauses in the code file, too

Care to check if this is still needed for v3.0-rc1? If so, please
add proper patch description and Signed-off-by.

Thanks,

Tony
