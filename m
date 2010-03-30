From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] OMAP: HWMOD: Adding clockdomain check
Date: Tue, 30 Mar 2010 01:56:45 -0600
Message-ID: <20100330075638.11629.98717.stgit@localhost.localdomain>
References: <20100330074801.11629.61888.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41373 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0C3H64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 03:58:56 -0400
In-Reply-To: <20100330074801.11629.61888.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch adds check for presence of clockdomain structure in the API
omap_hwmod_get_pwrdm before trying to access the powerdomain structure.
This will prevent unnecessary crashing of the system in case of a
clock node with out an associated clockdomain.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c664947..e436dcb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1511,6 +1511,9 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oh->slaves[oh->_mpu_port_index]->_clk;
 	}
 
+	if (!c->clkdm)
+		return NULL;
+
 	return c->clkdm->pwrdm.ptr;
 
 }


