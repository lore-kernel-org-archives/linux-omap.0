From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3530 EVM latest sources uploaded on linux.omap.com
Date: Fri, 15 Aug 2008 16:54:45 +0300
Message-ID: <20080815135444.GP16231@frodo>
References: <0680EC522D0CC943BC586913CF3768C00208C16525@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47902 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbYHONyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 09:54:52 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208C16525@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 15, 2008 at 06:57:45PM +0530, Syed Mohammed, Khasim wrote:
> Hi all,
> 
> I have uploaded latest version of kernel, u-boot and x-loader for OMAP3530 EVM on linux.omap.com,
> 
> http://linux.omap.com/pub/kernel/3530evm/2.6_kernel-v2.tar.gz
> http://linux.omap.com/pub/bootloader/3530evm/u-boot-v2.tar.gz
> http://linux.omap.com/pub/xloader/3530evm/x-load-v2.tar.gz
> 
> The kernel source should contain support for following drivers:
> 
> - Audio
> - OneNAND Driver
> - NAND Driver
> - USB Driver
> - Display Driver with DVI support
> - Resizer Driver
> - Capture Driver
> - Ethernet Driver
> - MMC/SD Driver
> - Touch Screen Driver
> - Keypad driver
> - Power Management

No tv out ??

I see you have omap_dispc_enable_digit_out() but there's nothing using
it :-s

Is there an easy way to test it ?

-- 
balbi
