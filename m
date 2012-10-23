From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources pdata function pointer
Date: Tue, 23 Oct 2012 10:02:43 +0200
Message-ID: <20121023080243.GY16482@spo001.leaseweb.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013213.21844.20016.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:37318 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756745Ab2JWICu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 04:02:50 -0400
Content-Disposition: inline
In-Reply-To: <20121016013213.21844.20016.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org

Hi Paul,

> The OMAP watchdog timer driver directly calls a function exported by
> code in arch/arm/mach-omap2.  This is not good; it tightly couples
> this driver to the mach-omap2 integration code.  Instead, add a
> temporary platform_data function pointer to abstract this function
> call.  A subsequent patch will convert the watchdog driver to use this
> function pointer.
> 
> This patch also moves the device creation code out of
> arch/arm/mach-omap2/devices.c and into arch/arm/mach-omap2/wd_timer.c.
> This is another step towards the removal of
> arch/arm/mach-omap2/devices.c.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

