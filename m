From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] ARM: OMAP2+: Disable GPIO softreset for dm81xx
Date: Tue,  1 Dec 2015 15:38:18 -0800
Message-ID: <1449013103-23238-6-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Looks like GPIO softreset status bit on both dm8168 and dm8148
is broken and only goes high initially. After writing to sysc
softreset bit, the resetdone bit never goes high again.

I noticed this as GPIOs are enabled from u-boot at least on t410.
And this can be tested easliy with the following commands in u-boot:

# mw.l 0x4818155c 0x2
# md.l 0x48032114 1
48032114: 00000001    ....
# mw.l 0x48032010 0x2
# md.l 0x48032114 1
48032114: 00000000    ....

Looks like the GPIO module is functional even with the resetdone
bit down.

Let's just tag the GPIOs for dm81xx with HWMOD_INIT_NO_RESET.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 1b96cdf..440fd6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -432,6 +432,7 @@ static struct omap_hwmod_ocp_if dm81xx_l4_ls__elm = {
 	.user		= OCP_USER_MPU,
 };
 
+/* On dm81xx RESETDONE bit seems to never goes high again after SOFTRESET */
 static struct omap_hwmod_class_sysconfig dm81xx_gpio_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
@@ -463,6 +464,7 @@ static struct omap_hwmod dm81xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.class		= &dm81xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.main_clk	= "sysclk6_ck",
 	.prcm = {
 		.omap4 = {
@@ -490,6 +492,7 @@ static struct omap_hwmod dm81xx_gpio2_hwmod = {
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.class		= &dm81xx_gpio_hwmod_class,
 	.main_clk	= "sysclk6_ck",
+	.flags		= HWMOD_INIT_NO_RESET,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DM81XX_CM_ALWON_GPIO_1_CLKCTRL,
-- 
2.6.2
