From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 01/13] ARM: OMAP2+: CM: reintroduce SW_SLEEP for OMAP4
Date: Fri, 2 Aug 2013 19:06:35 +0530
Message-ID: <cfcae1c52efc51786878c60b75cc3c182bcd50a5.1375443858.git.afzal@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, benoit.cousson@gmail.com, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

"65aa94b ARM: OMAP4: clockdomain/CM code: Update supported transition modes"
removed SW_SLEEP mode for clockdomains on OMAP4 class of devices. Not
having SW_SLEEP mode works fine for OMAP4/5 devices but it gets in the
way of reuse for other devices like AM43x which have the same hardware
but where most of clockdomains support only SW_SLEEP/SW_WKUP modes.

This also can help make AM335x (which has custom functions) reuse
OMAP4 PRM/CM functions.

While here also fixup a trivial typo in the comment.

[afzal@ti.com: Alter message to refer to AM43x instead of AM335x, this
 was pulled in from series that reuses OMAP4 PRM/CM for AM335x, which
 as of now is not being followed upon]
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index f0290f5..35051fd 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -237,7 +237,7 @@ void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
 }
 
 /**
- * omap4_cminst_clkdm_force_sleep - try to take a clockdomain out of idle
+ * omap4_cminst_clkdm_force_wakeup - try to take a clockdomain out of idle
  * @part: PRCM partition ID that the clockdomain registers exist in
  * @inst: CM instance register offset (*_INST macro)
  * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
@@ -250,6 +250,20 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, part, inst, cdoffs);
 }
 
+/**
+ * omap4_cminst_clkdm_force_sleep - try to put a clockdomain to idle
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Put a clockdomain referred to by (@part, @inst, @cdoffs) to idle,
+ * forcing it to sleep.  No return value.
+ */
+void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
+}
+
 /*
  *
  */
@@ -404,8 +418,8 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
-					clkdm->cm_inst, clkdm->clkdm_offs);
+	omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
+				       clkdm->cm_inst, clkdm->clkdm_offs);
 	return 0;
 }
 
-- 
1.7.9.5
