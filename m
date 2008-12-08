From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCHv2 0/3] OMAP_LDP support in linux-git tree
Date: Mon, 08 Dec 2008 18:44:04 +0800
Message-ID: <1228733044.22433.13.camel@localhost>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
	 <20081126231240.GM11997@atomide.com> <1227800406.14497.123.camel@localhost>
	 <20081205185816.GG9714@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:40761 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYLHKhZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 05:37:25 -0500
In-Reply-To: <20081205185816.GG9714@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


> Sorry for the delay. If you want to use the same patch for the mainline
> kernel and linux-omap kernel, you may need to edit the Makefile and Kconfig
> manually.
> 
> But since you have the ldp board already in the mainline kernel, all you
> need to do is to send me patches against the mainline kernel to add
> various support bits still missing from the mainline board file. Exactly
> what you did with for smc support (Well I had to cut out the smc driver
> bits):
> 
> ARM: OMAP3: LDP: Add Ethernet device support to make ldp boot succeess
> 
> in the current omap3-upstream series:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=omap3-upstream
> 
> So just send patches to add the rest of the devices, OK? Make sure it
> compiles with the mainline kernel, so exclude the drivers that are not
> there yet.
> 

LCD_LDP driver patch has been integrated into l-o tree. Do I need to
re-send it against mainline kernel ?

Stanley.

> Cheers,
> 
> Tony
