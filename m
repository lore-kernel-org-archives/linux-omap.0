From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: PM: Export omap_pm_set_min_bus_tput to modules
Date: Tue, 18 Jan 2011 14:51:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101181442030.13225@utopia.booyaka.com>
References: <1295386460-13960-1-git-send-email-martin@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41127 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1ARVvL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 16:51:11 -0500
In-Reply-To: <1295386460-13960-1-git-send-email-martin@neutronstar.dyndns.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Martin Hostettler <martin@neutronstar.dyndns.org>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Martin

On Tue, 18 Jan 2011, Martin Hostettler wrote:

> This patch exports omap_pm_set_min_bus_tput from omap-pm-noop.c to modules,
> to allow building omap3-isp as module without another pm implementation.
> 
> Signed-off-by: Martin Hostettler <martin@neutronstar.dyndns.org>

We would like device drivers to be buildable on any 
architecture/sub-architecture, not just ARM/OMAP, so we can't do this.

The right way for the omap3-isp code to handle this is to pass a function 
pointer through struct platform_data, and then for the ISP device 
driver(s) to use that.  For an example of how to do this, please see the 
OMAP I2C driver and its support code in arch/arm/plat-omap:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/i2c.c;h=a4f8003de664c1972c697070268108ee3cd95082;hb=a25cecce88194b2edf38b8c3b1665e9318eb2d22#l162

and

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/i2c/busses/i2c-omap.c;h=b605ff3a1fa05703d8fbbaf12df90aaa1c125813;hb=a25cecce88194b2edf38b8c3b1665e9318eb2d22#l1010

and 

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/i2c/busses/i2c-omap.c;h=b605ff3a1fa05703d8fbbaf12df90aaa1c125813;hb=a25cecce88194b2edf38b8c3b1665e9318eb2d22#l1068

and

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/linux/i2c-omap.h;h=7472449cbb7416b7a23f964e542af373fda2411e;hb=a25cecce88194b2edf38b8c3b1665e9318eb2d22#l8


- Paul
