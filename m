From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v9 05/11] OMAP4: hwmod data: add dmtimer
Date: Mon, 14 Feb 2011 17:26:43 +0100
Message-ID: <4D5957C3.8060703@ti.com>
References: <1297423040-19917-1-git-send-email-tarun.kanti@ti.com> <1297423040-19917-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49005 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab1BNQ0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:26:53 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1EGQrOD007620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:26:53 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1EGQqLZ022970
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:26:52 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1EGQq4M001783
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:26:52 -0600 (CST)
In-Reply-To: <1297423040-19917-6-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tarun,

I just have two comments.

On 2/11/2011 12:17 PM, DebBarma, Tarun Kanti wrote:
> From: Cousson, Benoit<b-cousson@ti.com>
>
> Add dmtimer data.
>
> Signed-off-by: Cousson, Benoit<b-cousson@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  623 ++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/dmtimer.h  |    2 +
>   2 files changed, 625 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 873e976..6014a16 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -25,6 +25,7 @@
>   #include<plat/gpio.h>
>   #include<plat/dma.h>
>   #include<plat/mcspi.h>
> +#include<plat/dmtimer.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -1900,6 +1901,615 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
>   };
>
>   /*
> + * 'timer' class
> + * general purpose timer module with accurate 1ms tick
> + * This class contains several variants: ['timer_1ms', 'timer']
> + */
> +static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
> +       .rev_offs       = 0x0000,
> +       .sysc_offs      = 0x0010,

The 1ms timer still have the sysstatus register used for reset status.
+	.syss_offs	= 0x0014,

> +       .sysc_flags     = (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +                          SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +                          SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
> +                          SYSS_HAS_RESET_STATUS),
> +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +       .sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
> +       .name = "timer",
> +       .sysc =&omap44xx_timer_1ms_sysc,
> +       .rev = OMAP_TIMER_IP_VERSION_1,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
> +       .rev_offs       = 0x0000,
> +       .sysc_offs      = 0x0010,
> +       .sysc_flags     = (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
> +                          SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),

On the other hand, the regular timer does not have sysstatus register 
anymore so the reset status is in the sysconfig. The proper (re-ordered) 
flags are then:

+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),


> +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +                          SIDLE_SMART_WKUP),
> +       .sysc_fields    =&omap_hwmod_sysc_type2,

[...]

Please find below the updated patch. I took as well the original 
changelog I did for the timer some time ago. It is based on the spinlock 
+ mcspi series.

Regards,
Benoit

---
 From 586d273bd8aea6851356e073bf4ae9b20917ca9d Mon Sep 17 00:00:00 2001
From: Cousson, Benoit <b-cousson@ti.com>
Date: Fri, 11 Feb 2011 11:17:14 +0000
Subject: [PATCH] OMAP4: hwmod data: Add timer

Add the data for the 11 timers IPs.
OMAP4 contains two different IP variants for the timers:
- 8 x regular timer (3, 4, 5, 6, 7, 8, 9 & 11)
- 3 x 1ms timer (1, 2 & 10)

The regular timers registers programming model was changed due to the
adaptation to the new IP interface. Unfortunately the 1ms version
still use the previous programming model. The driver will have
to take care of theses differences.

Please note that the capability and the partitioning is also
different depending of the instance.
- timer 1 is inside the wakeup domain
- timers 5, 6, 7 & 8 are inside in the ABE (audio backend)
- timers 2, 3, 4, 9, 10 & 11 are inside the PER power domain

The timer was previously named gptimerX or dmtimerX, it is
now simply named timerX.

Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[b-cousson@ti.com: Fix alignement in class attribute and
re-order flags, update the changelog]
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  636 
+++++++++++++++++++++++++++-
  arch/arm/plat-omap/include/plat/dmtimer.h  |    2 +
  2 files changed, 627 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 36d86ba..37b6d9f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
  #include <plat/gpio.h>
  #include <plat/dma.h>
  #include <plat/mcspi.h>
+#include <plat/dmtimer.h>

  #include "omap_hwmod_common_data.h"

@@ -552,17 +553,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
   *  sl2if
   *  slimbus1
   *  slimbus2
- *  timer1
- *  timer10
- *  timer11
- *  timer2
- *  timer3
- *  timer4
- *  timer5
- *  timer6
- *  timer7
- *  timer8
- *  timer9
   *  usb_host_fs
   *  usb_host_hs
   *  usb_otg_hs
@@ -1960,6 +1950,617 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
  };

  /*
+ * 'timer' class
+ * general purpose timer module with accurate 1ms tick
+ * This class contains several variants: ['timer_1ms', 'timer']
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
+	.name	= "timer",
+	.sysc	= &omap44xx_timer_1ms_sysc,
+	.rev	= OMAP_TIMER_IP_VERSION_1,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
+	.name	= "timer",
+	.sysc	= &omap44xx_timer_sysc,
+	.rev	= OMAP_TIMER_IP_VERSION_2,
+};
+
+/* timer1 */
+static struct omap_hwmod omap44xx_timer1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
+	{ .irq = 37 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer1_addrs[] = {
+	{
+		.pa_start	= 0x4a318000,
+		.pa_end		= 0x4a31807f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> timer1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_timer1_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_timer1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
+	&omap44xx_l4_wkup__timer1,
+};
+
+static struct omap_hwmod omap44xx_timer1_hwmod = {
+	.name		= "timer1",
+	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.mpu_irqs	= omap44xx_timer1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
+	.main_clk	= "timer1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer2 */
+static struct omap_hwmod omap44xx_timer2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer2_irqs[] = {
+	{ .irq = 38 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer2_addrs[] = {
+	{
+		.pa_start	= 0x48032000,
+		.pa_end		= 0x4803207f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer2_slaves[] = {
+	&omap44xx_l4_per__timer2,
+};
+
+static struct omap_hwmod omap44xx_timer2_hwmod = {
+	.name		= "timer2",
+	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.mpu_irqs	= omap44xx_timer2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer2_irqs),
+	.main_clk	= "timer2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer3 */
+static struct omap_hwmod omap44xx_timer3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer3_irqs[] = {
+	{ .irq = 39 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer3_addrs[] = {
+	{
+		.pa_start	= 0x48034000,
+		.pa_end		= 0x4803407f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer3_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer3_slaves[] = {
+	&omap44xx_l4_per__timer3,
+};
+
+static struct omap_hwmod omap44xx_timer3_hwmod = {
+	.name		= "timer3",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer3_irqs),
+	.main_clk	= "timer3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer4 */
+static struct omap_hwmod omap44xx_timer4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer4_irqs[] = {
+	{ .irq = 40 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer4_addrs[] = {
+	{
+		.pa_start	= 0x48036000,
+		.pa_end		= 0x4803607f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer4_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer4_slaves[] = {
+	&omap44xx_l4_per__timer4,
+};
+
+static struct omap_hwmod omap44xx_timer4_hwmod = {
+	.name		= "timer4",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer4_irqs),
+	.main_clk	= "timer4_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer5 */
+static struct omap_hwmod omap44xx_timer5_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer5_irqs[] = {
+	{ .irq = 41 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer5_addrs[] = {
+	{
+		.pa_start	= 0x40138000,
+		.pa_end		= 0x4013807f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer5 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer5_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer5_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer5_dma_addrs[] = {
+	{
+		.pa_start	= 0x49038000,
+		.pa_end		= 0x4903807f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer5 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer5_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer5_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer5_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* timer5 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer5_slaves[] = {
+	&omap44xx_l4_abe__timer5,
+	&omap44xx_l4_abe__timer5_dma,
+};
+
+static struct omap_hwmod omap44xx_timer5_hwmod = {
+	.name		= "timer5",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer5_irqs),
+	.main_clk	= "timer5_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer5_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer6 */
+static struct omap_hwmod omap44xx_timer6_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer6_irqs[] = {
+	{ .irq = 42 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer6_addrs[] = {
+	{
+		.pa_start	= 0x4013a000,
+		.pa_end		= 0x4013a07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer6 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer6_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer6_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer6_dma_addrs[] = {
+	{
+		.pa_start	= 0x4903a000,
+		.pa_end		= 0x4903a07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer6 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer6_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer6_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer6_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* timer6 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer6_slaves[] = {
+	&omap44xx_l4_abe__timer6,
+	&omap44xx_l4_abe__timer6_dma,
+};
+
+static struct omap_hwmod omap44xx_timer6_hwmod = {
+	.name		= "timer6",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer6_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer6_irqs),
+	.main_clk	= "timer6_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer6_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer7 */
+static struct omap_hwmod omap44xx_timer7_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer7_irqs[] = {
+	{ .irq = 43 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer7_addrs[] = {
+	{
+		.pa_start	= 0x4013c000,
+		.pa_end		= 0x4013c07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer7 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer7_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer7_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer7_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer7_dma_addrs[] = {
+	{
+		.pa_start	= 0x4903c000,
+		.pa_end		= 0x4903c07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer7 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer7_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer7_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer7_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* timer7 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer7_slaves[] = {
+	&omap44xx_l4_abe__timer7,
+	&omap44xx_l4_abe__timer7_dma,
+};
+
+static struct omap_hwmod omap44xx_timer7_hwmod = {
+	.name		= "timer7",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer7_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer7_irqs),
+	.main_clk	= "timer7_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer7_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer7_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer8 */
+static struct omap_hwmod omap44xx_timer8_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer8_irqs[] = {
+	{ .irq = 44 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer8_addrs[] = {
+	{
+		.pa_start	= 0x4013e000,
+		.pa_end		= 0x4013e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer8 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer8_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer8_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer8_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer8_dma_addrs[] = {
+	{
+		.pa_start	= 0x4903e000,
+		.pa_end		= 0x4903e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> timer8 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_timer8_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_timer8_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer8_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* timer8 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer8_slaves[] = {
+	&omap44xx_l4_abe__timer8,
+	&omap44xx_l4_abe__timer8_dma,
+};
+
+static struct omap_hwmod omap44xx_timer8_hwmod = {
+	.name		= "timer8",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer8_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer8_irqs),
+	.main_clk	= "timer8_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer8_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer8_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer9 */
+static struct omap_hwmod omap44xx_timer9_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer9_irqs[] = {
+	{ .irq = 45 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer9_addrs[] = {
+	{
+		.pa_start	= 0x4803e000,
+		.pa_end		= 0x4803e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer9 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer9 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer9_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer9_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer9_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer9 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer9_slaves[] = {
+	&omap44xx_l4_per__timer9,
+};
+
+static struct omap_hwmod omap44xx_timer9_hwmod = {
+	.name		= "timer9",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer9_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer9_irqs),
+	.main_clk	= "timer9_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer9_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer10 */
+static struct omap_hwmod omap44xx_timer10_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer10_irqs[] = {
+	{ .irq = 46 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer10_addrs[] = {
+	{
+		.pa_start	= 0x48086000,
+		.pa_end		= 0x4808607f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer10 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer10 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer10_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer10_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer10_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer10 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer10_slaves[] = {
+	&omap44xx_l4_per__timer10,
+};
+
+static struct omap_hwmod omap44xx_timer10_hwmod = {
+	.name		= "timer10",
+	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.mpu_irqs	= omap44xx_timer10_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer10_irqs),
+	.main_clk	= "timer10_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer10_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* timer11 */
+static struct omap_hwmod omap44xx_timer11_hwmod;
+static struct omap_hwmod_irq_info omap44xx_timer11_irqs[] = {
+	{ .irq = 47 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_timer11_addrs[] = {
+	{
+		.pa_start	= 0x48088000,
+		.pa_end		= 0x4808807f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer11 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__timer11 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_timer11_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_timer11_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_timer11_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer11 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_timer11_slaves[] = {
+	&omap44xx_l4_per__timer11,
+};
+
+static struct omap_hwmod omap44xx_timer11_hwmod = {
+	.name		= "timer11",
+	.class		= &omap44xx_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_timer11_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer11_irqs),
+	.main_clk	= "timer11_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_timer11_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
   * 'uart' class
   * universal asynchronous receiver/transmitter (uart)
   */
@@ -2388,6 +2989,19 @@ static __initdata struct omap_hwmod 
*omap44xx_hwmods[] = {
  	/* spinlock class */
  	&omap44xx_spinlock_hwmod,

+	/* timer class */
+	&omap44xx_timer1_hwmod,
+	&omap44xx_timer2_hwmod,
+	&omap44xx_timer3_hwmod,
+	&omap44xx_timer4_hwmod,
+	&omap44xx_timer5_hwmod,
+	&omap44xx_timer6_hwmod,
+	&omap44xx_timer7_hwmod,
+	&omap44xx_timer8_hwmod,
+	&omap44xx_timer9_hwmod,
+	&omap44xx_timer10_hwmod,
+	&omap44xx_timer11_hwmod,
+
  	/* uart class */
  	&omap44xx_uart1_hwmod,
  	&omap44xx_uart2_hwmod,
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h 
b/arch/arm/plat-omap/include/plat/dmtimer.h
index d6c70d2..05a967e 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -55,6 +55,8 @@
   * in OMAP4 can be distinguished.
   */
  #define OMAP_TIMER_IP_VERSION_1                        0x1
+#define OMAP_TIMER_IP_VERSION_2                        0x2
+
  struct omap_dm_timer;
  extern struct omap_dm_timer *gptimer_wakeup;
  extern struct sys_timer omap_timer;
-- 
1.7.0.4
