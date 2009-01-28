From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] ARM: Do early I/O mapping if spinlock debugging is enabled
Date: Wed, 28 Jan 2009 10:23:05 -0800
Message-ID: <20090128182305.21007.62781.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53377 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZA1SXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:23:08 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

From: Juha Yrjola <juha.yrjola@solidboot.com>

At least on OMAP, sched_clock() requires the I/O maps to be initialized.
Spinlock debugging invokes sched_clock() very early.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/kernel/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 21e17dc..1bc918c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -282,7 +282,7 @@ __create_page_tables:
 	.endif
 	str	r6, [r0]
 
-#ifdef CONFIG_DEBUG_LL
+#if defined(CONFIG_DEBUG_LL) || defined(CONFIG_DEBUG_SPINLOCK)
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	/*
 	 * Map in IO space for serial debugging.

