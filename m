From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH] arm-dt: Enable DT proc updates.
Date: Wed, 31 Oct 2012 17:57:49 +0200
Message-ID: <1351699069-4661-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Matt Porter <mporter@ti.com>, devicetree-discuss@lists.ozlabs.org, Pantelis Antoniou <panto@antoniou-consulting.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This simple patch enables dynamic changes of the DT tree on runtime
to be visible to the device-tree proc interface.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 arch/arm/include/asm/prom.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index aeae9c6..6d65ba2 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -11,6 +11,8 @@
 #ifndef __ASMARM_PROM_H
 #define __ASMARM_PROM_H
 
+#define HAVE_ARCH_DEVTREE_FIXUPS
+
 #ifdef CONFIG_OF
 
 extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
-- 
1.7.12
