From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source selection
 runtime
Date: Thu, 10 May 2012 16:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205101603350.32719@utopia.booyaka.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com> <2430095.tlzScq1o2g@acer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34794 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761786Ab2EJWEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 18:04:21 -0400
In-Reply-To: <2430095.tlzScq1o2g@acer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi Janusz,

On Thu, 10 May 2012, Janusz Krzysztofik wrote:

> Tried to test this branch, merged into 3.4-rc6, and with my Amstrad 
> Delta fixes applied, using my custom Amstrad Delta config, but initially 
> failed because an unrelated issue rised to the surface:
> 
> |   LD      .tmp_vmlinux1
> | arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
> | lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
> | make: *** [.tmp_vmlinux1] Error 1
> 
> Apparently introduced with commit 
> d3645d39ad0ed9f09535065676ea0ba114f93cdf, "ARM: OMAP1: OHCI: use 
> platform_data fn ptr to enable OCPI bus", looks like one or more symbols 
> exported by the not linked in arch/arm/mach-omap1/ocpi.o may be missing 
> for non-OMAP16xx configs.

Thanks for the report, I'll send a fix.


- Paul
