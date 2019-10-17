From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: OMAP2+: Initialize voltage controller for omap4
Date: Wed, 16 Oct 2019 18:19:36 -0700
Message-ID: <20191017011936.GL5610@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-9-tony@atomide.com>
 <20191016145324.GE5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191016145324.GE5610@atomide.com>
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
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191016 14:54]:
> * Tony Lindgren <tony@atomide.com> [191010 00:13]:
> > diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> > --- a/arch/arm/mach-omap2/vc.c
> > +++ b/arch/arm/mach-omap2/vc.c
> > @@ -26,6 +26,16 @@
> >  #include "scrm44xx.h"
> >  #include "control.h"
> >  
> > +#define OMAP4430_AUTO_CTRL_VDD_IVA(x)		((x) << 4)
> > +#define OMAP4430_AUTO_CTRL_VDD_MPU(x)		((x) << 2)
> > +#define OMAP4430_AUTO_CTRL_VDD_CORE(x)		((x) << 0)
> > +#define OMAP4430_AUTO_CTRL_VDD_RET		2
> > +
> > +#define OMAP4_VDD_DEFAULT_VAL	\
> > +	(OMAP4430_AUTO_CTRL_VDD_IVA(OMAP4430_AUTO_CTRL_VDD_RET) | \
> > +	 OMAP4430_AUTO_CTRL_VDD_MPU(OMAP4430_AUTO_CTRL_VDD_RET) | \
> > +	 OMAP4430_AUTO_CTRL_VDD_CORE(OMAP4430_AUTO_CTRL_VDD_RET))
> > +
> 
> I noticed I had left out OMAP4430_VDD_IVA_PRESENCE and
> OMAP4430_VDD_MPU_PRESENCE that should be enabled.

And looks like we also need to set the I2C disable bits here
by default to avoid instant reboots after adding the missing
PRESENCE bits and entering idle.

I also confirmed that the the scaling is happening for idle
by comparing the power consumption against the values measured
after clearing the OMAP4430_AUTO_CTRL bits when scaling is
not happening.

Updated patch again below.

Regards,

Tony

8< ------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 16 Oct 2019 07:37:07 -0700
Subject: [PATCHv3] ARM: OMAP2+: Initialize voltage controller for omap4

We're missing initializing the PRM_VOLTCTRL register for voltage
controller. Let's add omap4_vc_init_pmic_signaling() similar to what we
have for omap3 and enable voltage control for retention.

This brings down droid4 power consumption with mainline kernel to somewhere
between 40 and 50mW from about 70 to 80 mW for the whole device when
running idle with LCD and backlight off, WLAN connected, and USB and modem
modules unloaded.

Mostly just rmmod of omap2430, ohci-platform and phy-mapphone-mdm6600 are
needed to idle USB and shut down the modem. And after that measuring idle
power consumption can be done with reading sysfs entry periodically
for /sys/class/power_supply/battery/power_avg. Then rmmod of phy-cpcap-usb
will save few more mW, but will disable the debug UART.

Note that sometimes CM_L4PER_UART1_CLKCTRL at 0x4a009540 does not idle
properly after unloading of phy-mapphone-mdm6600.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/vc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -26,6 +26,25 @@
 #include "scrm44xx.h"
 #include "control.h"
 
+#define OMAP4430_VDD_IVA_I2C_DISABLE		BIT(14)
+#define OMAP4430_VDD_MPU_I2C_DISABLE		BIT(13)
+#define OMAP4430_VDD_CORE_I2C_DISABLE		BIT(12)
+#define OMAP4430_VDD_IVA_PRESENCE		BIT(9)
+#define OMAP4430_VDD_MPU_PRESENCE		BIT(8)
+#define OMAP4430_AUTO_CTRL_VDD_IVA(x)		((x) << 4)
+#define OMAP4430_AUTO_CTRL_VDD_MPU(x)		((x) << 2)
+#define OMAP4430_AUTO_CTRL_VDD_CORE(x)		((x) << 0)
+#define OMAP4430_AUTO_CTRL_VDD_RET		2
+
+#define OMAP4_VDD_DEFAULT_VAL	\
+	(OMAP4430_VDD_IVA_I2C_DISABLE | \
+	 OMAP4430_VDD_MPU_I2C_DISABLE |	 \
+	 OMAP4430_VDD_CORE_I2C_DISABLE | \
+	 OMAP4430_VDD_IVA_PRESENCE | OMAP4430_VDD_MPU_PRESENCE | \
+	 OMAP4430_AUTO_CTRL_VDD_IVA(OMAP4430_AUTO_CTRL_VDD_RET) | \
+	 OMAP4430_AUTO_CTRL_VDD_MPU(OMAP4430_AUTO_CTRL_VDD_RET) | \
+	 OMAP4430_AUTO_CTRL_VDD_CORE(OMAP4430_AUTO_CTRL_VDD_RET))
+
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
  * @sa: bit for slave address
@@ -542,9 +561,19 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	writel_relaxed(val, OMAP4_SCRM_CLKSETUPTIME);
 }
 
+static void __init omap4_vc_init_pmic_signaling(struct voltagedomain *voltdm)
+{
+	if (vc.vd)
+		return;
+
+	vc.vd = voltdm;
+	voltdm->write(OMAP4_VDD_DEFAULT_VAL, OMAP4_PRM_VOLTCTRL_OFFSET);
+}
+
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
+	omap4_vc_init_pmic_signaling(voltdm);
 	omap4_set_timings(voltdm, true);
 	omap4_set_timings(voltdm, false);
 }
-- 
2.23.0
