From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/4] ARM: OMAP4+: Have _omap4_wait_target_* check for valid
 clkctrl_offs
Date: Tue, 12 Jul 2016 12:50:33 -0500
Message-ID: <20160712175034.743-4-d-gerlach@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160712175034.743-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Olof Johansson <olof@lixom.net>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Previously the low-level CM call internal to the
_omap4_wait_target_ready/disable calls was responsible for checking for
a valid clkctrl_offs. Now we must also consider the value of the
prcm.omap4.flags because if HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET is set in
the flags then clkctrl_offs of 0 is valid.

Let's move this check into the _omap4_wait_target_ready/disable where we
have access to both the clkctrl_offs and the flags values and simply
return 0 without calling the low level CM call at all, which would have
returned 0 anyway if the clktrl_offs was zero.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5b709383381c..1052b29697b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1053,6 +1053,10 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
+	if (!oh->prcm.omap4.clkctrl_offs &&
+	    !(oh->prcm.omap4.flags & HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET))
+		return 0;
+
 	return omap_cm_wait_module_idle(oh->clkdm->prcm_partition,
 					oh->clkdm->cm_inst,
 					oh->prcm.omap4.clkctrl_offs, 0);
@@ -2971,6 +2975,10 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 	if (!_find_mpu_rt_port(oh))
 		return 0;
 
+	if (!oh->prcm.omap4.clkctrl_offs &&
+	    !(oh->prcm.omap4.flags & HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET))
+		return 0;
+
 	/* XXX check module SIDLEMODE, hardreset status */
 
 	return omap_cm_wait_module_ready(oh->clkdm->prcm_partition,
-- 
2.9.0
