From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP2+: Fix board_mux section type conflict when
 OMAP_MUX is not set
Date: Thu, 23 Feb 2012 16:54:09 -0800
Message-ID: <20120224005408.16794.87972.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2BXAyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:10 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we can get:

arch/arm/mach-omap2/mux.h:249:31: error: board_mux causes a section type conflict

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 2132308..69fe060 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -246,7 +246,7 @@ static inline void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 }
 
-static struct omap_board_mux *board_mux __initdata __maybe_unused;
+static struct omap_board_mux *board_mux __maybe_unused;
 
 #endif
 

