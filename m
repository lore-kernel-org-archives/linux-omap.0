From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Use srst_udelay for USB on dm814x
Date: Tue,  1 Mar 2016 17:55:02 -0800
Message-ID: <1456883702-32377-1-git-send-email-tony@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Without this booting t410 can fail randomly with no output
depending on the .config options chosen. Enabling debug_ll
causes the problem to go away. I narrowed this down to USB
by disabling one module at a time.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 39736ad..df83277 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -582,9 +582,11 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
 	.user		= OCP_USER_MPU,
 };
 
+/* USB needs udelay 1 after reset at least on hp t410, use 2 for margin */
 static struct omap_hwmod_class_sysconfig dm81xx_usbhsotg_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x10,
+	.srst_udelay	= 2,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
 				SYSC_HAS_SOFTRESET,
 	.idlemodes	= SIDLE_SMART | MSTANDBY_FORCE | MSTANDBY_SMART,
-- 
2.7.0
