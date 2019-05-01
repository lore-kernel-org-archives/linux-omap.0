From: Tony Lindgren <tony@atomide.com>
Subject: Re: next/master boot bisection: next-20190430 on beagle-xm
Date: Wed, 1 May 2019 13:21:49 -0700
Message-ID: <20190501202149.GM8007@atomide.com>
References: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
 <20190501153711.pxmapo2k3n5ynqrc@linutronix.de>
 <20190501162944.GW8004@atomide.com>
 <20190501164444.iclxlzrxofqnj4bn@linutronix.de>
 <20190501165224.GK8007@atomide.com>
 <20190501170125.xjlwdyqtp5oxx2mb@linutronix.de>
 <20190501174431.GL8007@atomide.com>
 <20190501190303.pz2yxs3hnc2qpamu@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501190303.pz2yxs3hnc2qpamu@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "kernelci.org bot" <bot@kernelci.org>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com, mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>, broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com, Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [190501 19:03]:
> On 2019-05-01 10:44:31 [-0700], Tony Lindgren wrote:
> > Hmm so I tried without "earlycon" in command line thinking it might be
> > happening with just "earlyprintk" but still no luck.
> > 
> > BTW, in general you might want to update your kernel command line
> > options to:
> > 
> > debug earlyprintk earlycon
> 
> debug. Let me look if I manage to hide that `debug' from systemd…

Oh that.. I've been quite happy with openrc now for years :)

> > Looking at the oops 0xfa1cc000, so 0x481cc000 I guess which is d_can0?
> 
> That node around it I guess.

OK I found two issues. It seems that d_can also needs osc clock
on am335x. And there's no revision register for d_can.. We're now
reading the CTL register unnecessarily.

Below is what I hope fixes the boot issue for you, care to boot
test?

If this helps I'll send out proper patches for for both issues.

Regards,

Tony

8< ----------------------
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1762,8 +1762,9 @@
 			reg = <0xcc000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN0_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN0_CLKCTRL 0>,
+				 <&dcan0_fck>;
+			clock-names = "fck", "osc";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xcc000 0x2000>;
@@ -1785,8 +1786,9 @@
 			reg = <0xd0000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN1_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN1_CLKCTRL 0>,
+				 <&dcan1_fck>;
+			clock-names = "fck", "osc";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd0000 0x2000>;
