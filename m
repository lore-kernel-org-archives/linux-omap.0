From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 16/17] OMAP850: PM: Add an ARCH_OMAP850 check
Date: Wed, 14 Oct 2009 20:51:52 +0100
Message-ID: <3d374d00910141251j64a44d54xacf9adfd492abca9@mail.gmail.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This just makes the same warning be printed on omap850 and omap730.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
---
 arch/arm/mach-omap1/pm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
index 0f20aed..56a6479 100644
--- a/arch/arm/mach-omap1/pm.h
+++ b/arch/arm/mach-omap1/pm.h
@@ -105,6 +105,7 @@
 #define OMAP7XX_IDLE_LOOP_REQUEST	0x0C00

 #if     !defined(CONFIG_ARCH_OMAP730) && \
+	!defined(CONFIG_ARCH_OMAP850) && \
 	!defined(CONFIG_ARCH_OMAP15XX) && \
 	!defined(CONFIG_ARCH_OMAP16XX)
 #warning "Power management for this processor not implemented yet"
-- 
1.6.5
