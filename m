From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Fri, 24 Sep 2010 20:42:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD46A104@dbde02.ent.ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
	<87r5goq7ro.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD3C16FE@dbde02.ent.ti.com>
	<87zkvbj7yc.fsf@deeprootsystems.com>	<87k4mefz70.fsf@deeprootsystems.com>
 <87bp7qfx6g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab0IXPMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:12:13 -0400
In-Reply-To: <87bp7qfx6g.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> 
> >> "Varadarajan, Charulatha" <charu@ti.com> writes:

<<snip>>

> >>>> Hi Charu,
> >>>>
> >>>> I haven't been fully through the series, but here's some quick
> feedback
> >>>> based on what I tried today.
> >>>>
> >>>> Basically, I got stuck because the first board I tried it on was the
> >>>> 35xx-based OMAP3EVM platform, which uses a GPIO-based interrupt for
> the
> >>>> network.  My setup uses DHCP + nfsroot, so the GPIO IRQ must be
> working
> >>>> during boot.
> >>>>
> >>>> The first thing I noticed, is that GPIO interrupts are not firing
> during
> >>>> boot, so neither the DHCP or the nfsroot works during boot.  I
> haven't
> >>>> been able to fully debug this, but the 3430SDP should have the same
> >>>> issue for its smc91x if you set it up for DHCP + nfsroot.  This is
> >>>> working fine on my pm-wip/idle-reorg branch which has the
> prerequisites
> >>>> you mentioned, but didn't work when I applied the clk_alias patch
> plus
> >>>> this series.
> >>>
> >>> I tested this GPIO series in pm-wip/idle-reorg branch with clock
> >>> add alias patch and I did not see any issues. I tested with DHCP +
> nfsroot
> >>> on SDP3430. Please provide me some more info on this.
> >>
> >> Hmm, I don't have many more details yet.  All I can see is that the
> GPIO
> >> bank that has the smc91x interrupt (GPIO6) is loosing interrupts, and
> >> thus preventing DHCP and nfsroot from working.
> >>

The root cause of this issue is that during OMAP3EVM board init, the
Ethernet controller (smsc911x) is not reset and it relies on the uboot configurations for it's operations. The reset GPIO pin used for this
purpose is not even reserved.

With GPIO hwmod series, gpio module reset happens during init and hence
the uboot settings are modified which makes the Ethernet controller to fail.

Patch [1] below if applied on top of gpio hwmod series would make the
evm board work with DHCP and nfsroot.

Rather, patch [2] below would be a better fix for this. I am not getting deeper into the minor details of Ethernet controller initialization for
OMAP3 EVM board. This patch would suffice for now. But my observation
is that omap3evm_init_smsc911x() needs to be fixed including CS
configuration and other required settings for Ethernet controller.

[1]

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 43ed2ab..b137e0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -373,6 +373,7 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
        .class          = &omap3xxx_gpio_hwmod_class,
        .dev_attr       = &gpio_dev_attr,
        .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+       .flags          = HWMOD_INIT_NO_RESET,
 };


[2]

>From b191662eca02450bbeaf29370916bca8811bb752 Mon Sep 17 00:00:00 2001
From: Varadarajan, Charulatha <charu@ti.com>
Date: Fri, 24 Sep 2010 20:00:06 +0530
Subject: [PATCH] Fix: OMAP3EVM: Ethernet controller smsc911x reset

Do reset of Ethernet controller smsc911x using OMAP gpio7
while initializing the Ethernet controller.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d9c0..3ee87d0 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -55,6 +55,7 @@
 #define OMAP3EVM_ETHR_SIZE	1024
 #define OMAP3EVM_ETHR_ID_REV	0x50
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
+#define OMAP3EVM_ETHR_GPIO_RST  7
 #define OMAP3EVM_SMSC911X_CS	5
 
 static u8 omap3_evm_version;
@@ -134,6 +135,14 @@ static inline void __init omap3evm_init_smsc911x(void)
 	else
 		rate = clk_get_rate(l3ck);
 
+	gpio_direction_output(OMAP3EVM_ETHR_GPIO_RST, 1);
+
+	/* reset pulse to ethernet controller*/
+	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 0);
+	usleep_range(150, 220);
+	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 1);
+	usleep_range(1, 2);
+
 	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
@@ -141,6 +150,13 @@ static inline void __init omap3evm_init_smsc911x(void)
 	}
 
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
+
+	/* Configure ethernet controller reset gpio */
+	if (gpio_request(OMAP3EVM_ETHR_GPIO_RST, "SMSC911x gpio") < 0) {
+		pr_err(KERN_ERR "Failed to request GPIO8 for smsc911x gpio\n");
+		return;
+	}
+
 	platform_device_register(&omap3evm_smsc911x_device);
 }
 
-- 
1.7.0.4

