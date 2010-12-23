From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Status of CONFIG_OMAP_DM_TIMER
Date: Thu, 23 Dec 2010 13:07:10 -0500
Message-ID: <1293127631-764-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34843 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0LWSHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 13:07:20 -0500
Received: by qyj19 with SMTP id 19so7942201qyj.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 10:07:19 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, manjugk@ti.com, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, tony@atomide.com


While compiling a kernel today I found the build was failing with a fair number
of errors while linking vmlinux,

  arch/arm/mach-omap2/built-in.o: In function `omap2_gp_timer_set_mode':
  /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:84: undefined reference to `omap_dm_timer_stop'
  /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:88: undefined reference to `omap_dm_timer_get_fclk'
  /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:90: undefined reference to `omap_dm_timer_set_load_start'
  ...

After investigating a bit more deeply, I found that I had neglected to enable
OMAP_DM_TIMER. Looking further, I found that ARCH_OMAP2PLUS builds timer_gp.o,
which itself has symbol dependencies on the dm_timer framework. Given this
face, it seems that the easiest solution would be to do as I have done in this
patch and make ARCH_OMAP2PLUS depend on OMAP_DM_TIMER, since it will not build
without it. That being said, is it necessary to keep OMAP_DM_TIMER
configurable? What is this option actually buying us?

Cheers,

- Ben

