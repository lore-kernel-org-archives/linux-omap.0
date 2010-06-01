From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 00/14] Multiple fixes for Devkit8000
Date: Tue, 01 Jun 2010 07:36:44 +0200
Message-ID: <4C049C6C.7040303@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0FAFg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:36:56 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hello Tony,

can you please add these patches? Or is something to change?

Thomas

Am 18.05.2010 14:05, schrieb Thomas Weber:
> Some of these patches were submitted earlier but got no comments
> so I am sending them one more time. 
> 
> These patches correct errors that were done while using the board code
> from beagle board for Devkit8000. 
> 
> The Devkit8000 uses the TPS65930, an reduced version of the TWL4030. 
> So not all power supplies from the TWL4030 are available.
> There were also a wrong comment about the pins supported by the vmmc1. 
> The DSS2 do not need a VDVI any longer so it is removed. 
> The definition of the supplies are changed to use the new REGULATOR_SUPPLY macro.
> The pins for lcd and dvi powerdown are corrected.
> 
> 
> Kan-Ru Chen (1):
>   OMAP2: Devkit8000: Setup LCD reset
> 
> Thomas Weber (13):
>   OMAP2: Devkit8000: Cleanup for supplies
>   OMAP2: Devkit8000: change lcd panel to generic
>   OMAP2: Devkit8000: Enable DVI-D output
>   OMAP2: Devkit8000: Remove unneeded VDVI
>   OMAP2: Devkit8000: Remove nonexisting vsim
>   OMAP2: Devkit8000: Remove en-/disable for tv panel
>   OMAP2: Devkit8000: Use the REGULATOR_SUPPLY macro
>   OMAP2: Devkit8000: Fixing comment about pins used
>   OMAP2: Devkit8000: Fix whitespace with tab
>   OMAP2: Devkit8000: Fix comment
>   OMAP2: Devkit8000: Using gpio_is_valid
>   OMAP2: Devkit8000: Remove unused omap_board_config
>   OMAP2: Devkit8000: Correct regulator
> 
>  arch/arm/mach-omap2/board-devkit8000.c |  125 +++++++++++++++-----------------
>  1 files changed, 58 insertions(+), 67 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

