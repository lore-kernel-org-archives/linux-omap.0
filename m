From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 28/28] omap: delete unused bootloader tag variables
Date: Fri, 23 Apr 2010 16:12:10 -0700
Message-ID: <20100423231210.31953.2729.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57309 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab0DWXMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:12:09 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

They are not needed and add over 512 bytes to kernel data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/common.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 01cbb48..f12f0e3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -44,9 +44,6 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-unsigned char omap_bootloader_tag[512];
-int omap_bootloader_tag_len;
-
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 

