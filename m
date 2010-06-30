From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/16] omap: mux: Allow compiling in new mux code on all
	mach-omap2 systems
Date: Wed, 30 Jun 2010 15:06:39 +0300
Message-ID: <20100630120639.2637.54819.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51263 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0F3MG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:27 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Allow compiling in new mux code on all mach-omap2 systems

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 arch/arm/mach-omap2/mux.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 76b5bf7..197e295 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -372,7 +372,7 @@ int __init omap2_mux_init(void)
 
 /*----------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP3
+#ifdef CONFIG_ARCH_OMAP2PLUS
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 46315f2..937a8ca 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -104,7 +104,7 @@ struct omap_board_mux {
 	u16	value;
 };
 
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_OMAP_MUX)
 
 /**
  * omap_mux_init_gpio - initialize a signal based on the GPIO number

