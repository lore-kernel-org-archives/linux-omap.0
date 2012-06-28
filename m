From: Tero Kristo <t-kristo@ti.com>
Subject: Re: New compiler warnings with v3.5-rc
Date: Thu, 28 Jun 2012 12:05:31 +0300
Message-ID: <1340874331.2059.86.camel@sokoban>
References: <alpine.DEB.2.00.1206280244270.2338@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229Ab2F1JFg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:05:36 -0400
In-Reply-To: <alpine.DEB.2.00.1206280244270.2338@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org

On Thu, 2012-06-28 at 02:47 -0600, Paul Walmsley wrote:
> Hi Tero,
> 
> there are some new compiler warnings added in the v3.5-rc kernels:
> 
> arch/arm/mach-omap2/twl-common.c:51:12: warning: 'twl_set_voltage' defined but not used
> arch/arm/mach-omap2/twl-common.c:57:12: warning: 'twl_get_voltage' defined but not used
> 
> They only seem to appear on my N800 builds:
> 
> http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/build/build_20120628011813_log.txt
> 
> but it looks like I somehow am not doing a 2430-specific build yet, so 
> they may be 24xx-common.
> 
> Anyway they were probably added by:
> 
> commit 49c008ecce1f9a549c12e8957668d60008ab0d79
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Mon Feb 20 12:26:08 2012 +0200
> 
>     arm: omap3: twl: add external controllers for core voltage regulators
>     
> 
> Maybe you can put together a quick patch to fix these?

Yea, I can do that. Can you provide your .config as reference?

-Tero


