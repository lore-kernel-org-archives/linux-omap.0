From: Paul Walmsley <paul@pwsan.com>
Subject: Re: drivers that require headers in mach-omap
Date: Fri, 31 Jul 2009 02:49:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907310245250.9998@utopia.booyaka.com>
References: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46252 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZGaItJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 04:49:09 -0400
In-Reply-To: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Tue, 28 Jul 2009, Mike Chan wrote:

> Omap folks, how are drivers that require access to prm and cm
> registers via cm_read_mod_reg() etc... suppose to access these?
> 
> For example if drivers/usb/host/ohci-omap.c wanted to call:
> cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);
> 
> It seems some of the headers in mach-omap2 should be in
> plat-omap/include/mach, or is there a more elegant way? The other
> alternatives are to register calls in all the board files, or #include
> ../../.. both do not seem very elegant to me.

Generally, if a device driver requires platform-specific functions, those 
functions should go into a separate file in plat-omap/ or mach-omap*/, and 
should be called via platform_data function pointers.  

For the specific case you mention, no device driver should need direct 
PRCM access.  These details change frequently between chip versions and 
are generally chip integration-specific rather than device IP-specific.


- Paul
