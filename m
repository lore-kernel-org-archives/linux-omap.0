From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCHv2 0/3] OMAP_LDP support in linux-git tree
Date: Thu, 27 Nov 2008 23:40:06 +0800
Message-ID: <1227800406.14497.123.camel@localhost>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
	 <20081126231240.GM11997@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64483 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbYK0Pdq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2008 10:33:46 -0500
In-Reply-To: <20081126231240.GM11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2008-11-26 at 15:12 -0800, Tony Lindgren wrote:
> * Stanley.Miao <stanley.miao@windriver.com> [081120 23:45]:
> > Changes from v1:
> > 
> > 1, change omap_request_gpio() to gpio_request() in gpio.patch.
> 
> One request: Since the LDP is in the mainline kernel, can you please
> provide whatever applies as patches against the mainline board-ldp.c?
> 
> Then if some driver is not yet in mainline, provide that in an extra
> patch.
> 
> That way I don't have to rewrite your patches for mainline ;)

Did I understand you right ? 

The nand patch modified arch/arm/mach-omap2/Makefile. This Makefile
changed a lot against mainline. I don't know how to provide the patch
against mainline.

Stanley.


> Tony
