From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [patch twl 1/2] remove <linux/i2c/twl4030-rtc.h>
Date: Mon, 06 Oct 2008 17:57:14 +0300
Message-ID: <87hc7pvkj9.fsf@deeprootsystems.com>
References: <200810012342.50866.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:36316 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYJFO5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 10:57:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2312125fkq.5
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 07:57:21 -0700 (PDT)
In-Reply-To: <200810012342.50866.david-b@pacbell.net> (David Brownell's message of "Wed\, 1 Oct 2008 23\:42\:50 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> From: David Brownell <dbrownell@users.sourceforge.net>
>
> Remove <linux/i2c/twl4030-rtc.h> by moving all the relevant contents
> into the driver itself, and removing the rest.  Stuff removed included
> many useless bitmasks, and remnants of the platform data hook.
>
> Add markers inside the rtc driver to split sections apart:  first
> data structure declarations, then the RTC driver, then platform bus
> glue for it all.
>
> There's still an issue with the twl4030-pwrirq.h registers ... this
> driver has no business touching them!  This patch at least switches
> away from having private versions of those register definitions, and
> removes some unnecessary accesses to them.
>
> No functional changes, just shrinkage.
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

In addition, remove the #include of twl4030-rtc.h from board-3430sdp.c

Kevin


>From aa394ce81d3c63f64ae27e89c2588950aaee2995 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Mon, 6 Oct 2008 17:52:43 +0300
Subject: [PATCH] ARM: OMAP3: Remove include of removed twl4030-rtc.h

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4264b68..56f28ae 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -40,7 +40,6 @@
 #include <mach/keypad.h>
 #include <mach/dma.h>
 #include <mach/gpmc.h>
-#include <linux/i2c/twl4030-rtc.h>
 
 #include <asm/io.h>
 #include <asm/delay.h>
-- 
1.6.0

