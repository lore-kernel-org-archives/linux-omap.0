From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/5 v2] Serial HWMOD updation and uart4  support for 3630
Date: Thu, 17 Jun 2010 17:05:21 -0700
Message-ID: <87d3vpciim.fsf@deeprootsystems.com>
References: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47003 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0FRAFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 20:05:24 -0400
Received: by pxi12 with SMTP id 12so200671pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 17:05:23 -0700 (PDT)
In-Reply-To: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Wed\, 16 Jun 2010 19\:43\:38 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Changes from v1:
> * Incorporated : OMAP clock: Add uart4_ick/fck definitions for 3630
> * using omap_mux_request_signal to retreive padconf offset
>   as per Tony's comments.
>   http://marc.info/?l=linux-omap&m=127609369220618&w=2
>   This patch series as a dependecy on the patch
>   for "omap_mux_request_signal" posted earlier
>   https://patchwork.kernel.org/patch/105962/
> * Clean up certain comments.
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30348.html
>
> Patch series is based on remotes/origin/pm-wip/uart
> branch from Kevin's PM tree.
>
> 1.) Add support for UART4 for 3630.
> 2.) Modify Serial hwmod to avoid hwmod lookup using name string.
>
> Govindraj.R (5):
>   OMAP clock: Add uart4_ick/fck definitions for 3630
>   OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>   OMAP3: serial: Fix uart4 handling for 3630
>   OMAP3: PM: Add prepare idle and resume idle call for uart4
>   Serial: Avoid using hwmod lookup using name string.

Govindraj,

Can you add this one to your series and test it on your boards?

Kevin

>From f63426a68cd4048e6a09e5aed2b101b7cb2ef141 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Thu, 17 Jun 2010 16:59:10 -0700
Subject: [PATCH] OMAP: UART: separate list of detected UARTs from registered UARTs

Use separate lists to track detected UARTs (available hwmods) and
registered UARTs (ones activated via board code.)

The hwmod_list is populated as soon as the UART hwmods are detected,
but the uart_list is only populated when a UART is registered via
board code.  This ensures that the various PM operaions are done only
on UARTs registered via board code.

This is particularily useful for boards where no OMAP UARTs are
registered (Zoom3).  Since all the PM operations only need to be done
on registered UARTs, when none are registered, these functions do
nothing as the list iteratates on an empty list.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2ab8f25..37cc28e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -98,7 +98,9 @@ struct omap_uart_state {
 #endif
 };
 
-static LIST_HEAD(uart_list);
+static LIST_HEAD(hwmod_list); /* list of detected UART hwmods */
+static LIST_HEAD(uart_list);  /* list of initialized UARTs */
+
 static u8 num_uarts;
 
 static struct omap_device_pm_latency omap_uart_latency[] = {
@@ -612,7 +614,7 @@ static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
 
 	uart->oh = oh;
 	uart->num = i++;
-	list_add_tail(&uart->node, &uart_list);
+	list_add_tail(&uart->node, &hwmod_list);
 	num_uarts++;
 
 	/*
@@ -676,7 +678,7 @@ void __init omap_serial_init_port(int port)
 	if (WARN_ON(port >= num_uarts))
 		return;
 
-	list_for_each_entry(uart, &uart_list, node)
+	list_for_each_entry(uart, &hwmod_list, node)
 		if (port == uart->num)
 			break;
 
@@ -789,6 +791,8 @@ void __init omap_serial_init_port(int port)
 		device_init_wakeup(&od->pdev.dev, true);
 		DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
 	}
+
+	list_add_tail(&uart->node, &uart_list);
 }
 
 /**
-- 
1.7.0.2

