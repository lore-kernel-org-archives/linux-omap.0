From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] omap: Fix compile for arch/arm/mach-omap2
Date: Thu, 24 Sep 2009 16:32:55 -0700
Message-ID: <20090924233255.6065.54684.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63892 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbZIXXcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:32:54 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Patch 941132606c7611246d2034cb7b01f9270c2d1ede split IO_ADDRESS
into OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS except for the omap4
code to avoid merge conflicts with the omap4 code that was queued
earlier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3a529c7..faada9f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -110,7 +110,7 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 #ifdef CONFIG_ARCH_OMAP4
-		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -126,7 +126,7 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 #ifdef CONFIG_ARCH_OMAP4
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
-		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,

