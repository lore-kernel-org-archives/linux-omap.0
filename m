From: Paul Walmsley <paul@pwsan.com>
Subject: New compiler warnings with v3.5-rc
Date: Thu, 28 Jun 2012 02:47:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206280244270.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38130 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab2F1Ir4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 04:47:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org


Hi Tero,

there are some new compiler warnings added in the v3.5-rc kernels:

arch/arm/mach-omap2/twl-common.c:51:12: warning: 'twl_set_voltage' defined but not used
arch/arm/mach-omap2/twl-common.c:57:12: warning: 'twl_get_voltage' defined but not used

They only seem to appear on my N800 builds:

http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/build/build_20120628011813_log.txt

but it looks like I somehow am not doing a 2430-specific build yet, so 
they may be 24xx-common.

Anyway they were probably added by:

commit 49c008ecce1f9a549c12e8957668d60008ab0d79
Author: Tero Kristo <t-kristo@ti.com>
Date:   Mon Feb 20 12:26:08 2012 +0200

    arm: omap3: twl: add external controllers for core voltage regulators
    

Maybe you can put together a quick patch to fix these?


- Paul
