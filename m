From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
Date: Fri, 21 Mar 2014 17:01:36 +0100
Message-ID: <201403211701.36846.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de> <20140319200100.GB4271@saruman.home> <20140319203431.GA8333@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:60552 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaCUQBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Mar 2014 12:01:41 -0400
In-Reply-To: <20140319203431.GA8333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wednesday 19 March 2014, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140319 13:06]:
> > On Wed, Mar 19, 2014 at 02:59:13PM -0500, Felipe Balbi wrote:
> > > I had sent a fix for months and months ago, what happened to it ?
> > 
> > Here
> > 
> > http://marc.info/?l=linux-omap&m=138963632408031&w=2
> > 
> > Tony, did you forget to send a pull request ?
> 
> Hmm yes weird, can't see it in my omap-for-v3.14/fixes branch.
> 
> I must have gotten interrupted while applying and then probably
> ran git reset --hard before committing.
> 
> Arnd, maybe pick up Felipe's earlier patch instead?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, using this version now, thanks!

	Arnd

>From 64cdcf550319a37d1419aa6a87903e67b9d3d031 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Sun, 16 Mar 2014 17:57:55 +0100
Subject: [PATCH] ARM: omap1: fix build when !CONFIG_OMAP_32K_TIMER

If CONFIG_OMAP_32K_TIMER isn't enabled, we will
try to use enable_dyn_sleep which wasn't defined
anywhere.

In order to fix the problem, we always define
enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 40a1ae3..dbee729 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,7 +71,11 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
-#ifdef CONFIG_OMAP_32K_TIMER
+#ifndef CONFIG_OMAP_32K_TIMER
+
+static unsigned short enable_dyn_sleep = 0;
+
+#else
 
 static unsigned short enable_dyn_sleep = 1;
 
