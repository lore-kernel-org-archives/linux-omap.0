From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] omap2/3/4: serial: remove initialization sparse warnings
Date: Thu, 08 Jul 2010 13:08:19 +0300
Message-ID: <20100708100818.19285.44966.stgit@baageli.muru.com>
References: <20100708100715.19285.30066.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab0GHKIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:08:21 -0400
In-Reply-To: <20100708100715.19285.30066.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Initialization of pointer should be done with NULL. Removes sparse
warnings:
arch/arm/mach-omap2/serial.c:566:17: warning: Using plain integer as NULL pointer
arch/arm/mach-omap2/serial.c:567:17: warning: Using plain integer as NULL pointer

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 804dbb2..9476c1c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -495,8 +495,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		}
 		uart->wk_mask = wk_mask;
 	} else {
-		uart->wk_en = 0;
-		uart->wk_st = 0;
+		uart->wk_en = NULL;
+		uart->wk_st = NULL;
 		uart->wk_mask = 0;
 		uart->padconf = 0;
 	}

