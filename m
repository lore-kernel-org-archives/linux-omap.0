From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: remove duplicate 'const' annotations'
Date: Thu, 11 May 2017 13:50:16 +0200
Message-ID: <20170511115059.2997141-1-arnd@arndb.de>
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
To: arm@kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Florian Fainelli <f.fainelli@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, Scott Branden <sbranden@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Viresh Kumar <vireshk@kernel.org>, Olof Johansson <olof@lixom.net>, bcm-kernel-feedback-list@broadcom.com, Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

gcc-7 warns about some declarations that are more 'const' than necessary:

arch/arm/mach-at91/pm.c:338:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct of_device_id const ramc_ids[] __initconst = {
arch/arm/mach-bcm/bcm_kona_smc.c:36:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
arch/arm/mach-spear/time.c:207:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct of_device_id const timer_of_match[] __initconst = {
arch/arm/mach-omap2/prm_common.c:714:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
arch/arm/mach-omap2/vc.c:562:35: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const struct i2c_init_data const omap4_i2c_timing_data[] __initconst = {

The ones in arch/arm were apparently all introduced accidentally by one
commit that correctly marked a lot of variables as __initconst.

Cc: Nicolas Pitre <nico@linaro.org>
Fixes: 19c233b79d1a ("ARM: appropriate __init annotation for const data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/pm.c          | 2 +-
 arch/arm/mach-bcm/bcm_kona_smc.c | 2 +-
 arch/arm/mach-cns3xxx/core.c     | 2 +-
 arch/arm/mach-omap2/prm_common.c | 2 +-
 arch/arm/mach-omap2/vc.c         | 2 +-
 arch/arm/mach-spear/time.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 2cd27c830ab6..283e79ab587d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -335,7 +335,7 @@ static const struct ramc_info ramc_infos[] __initconst = {
 	{ .idle = sama5d3_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
 };
 
-static const struct of_device_id const ramc_ids[] __initconst = {
+static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = &ramc_infos[0] },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 5157faa502eb..3937bd5d452f 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -33,7 +33,7 @@ struct bcm_kona_smc_data {
 	unsigned result;
 };
 
-static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
+static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
 	{.compatible = "brcm,kona-smc"},
 	{.compatible = "bcm,kona-smc"}, /* deprecated name */
 	{},
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 03da3813f1ab..7d5a44a06648 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -346,7 +346,7 @@ static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
 	.power_off	= csn3xxx_usb_power_off,
 };
 
-static const struct of_dev_auxdata const cns3xxx_auxdata[] __initconst = {
+static const struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
 	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
 	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
 	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 2b138b65129a..dc11841ca334 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -711,7 +711,7 @@ static struct omap_prcm_init_data scrm_data __initdata = {
 };
 #endif
 
-static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
+static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
 #ifdef CONFIG_SOC_AM33XX
 	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
 #endif
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 2028167fff31..d76b1e5eb8ba 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -559,7 +559,7 @@ struct i2c_init_data {
 	u8 hsscll_12;
 };
 
-static const struct i2c_init_data const omap4_i2c_timing_data[] __initconst = {
+static const struct i2c_init_data omap4_i2c_timing_data[] __initconst = {
 	{
 		.load = 50,
 		.loadbits = 0x3,
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 4878ba90026d..289e036c9c30 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -204,7 +204,7 @@ static void __init spear_clockevent_init(int irq)
 	setup_irq(irq, &spear_timer_irq);
 }
 
-static const struct of_device_id const timer_of_match[] __initconst = {
+static const struct of_device_id timer_of_match[] __initconst = {
 	{ .compatible = "st,spear-timer", },
 	{ },
 };
-- 
2.9.0
