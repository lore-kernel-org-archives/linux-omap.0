From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Tue, 5 Feb 2013 13:45:31 -0600
Message-ID: <5111615B.50708@ti.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab3BETpg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 14:45:36 -0500
In-Reply-To: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: t-kristo@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi Paul,

On 01/21/2013 08:42 PM, Paul Walmsley wrote:
> 
> Hi Tero, Rajendra, Santosh,
> 
> As we've discussed, there are known bootloader dependencies with the OMAP4 
> PM retention idle code, introduced in v3.8.  Boards booted with u-boot 
> versions even as recent as 2011 won't enter retention idle correctly; for 
> example:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/pm/4430es2panda/4430es2panda_log.txt
> 
> The right thing for you all to do is what was done for OMAP3: to add code 
> to correctly reset and initialize these on-chip devices.  However, since 
> it's already late in the v3.8-rc cycle, this seems unlikely to happen in 
> time for the v3.8 release -- and that's assuming that you guys are working 
> on this, which I'm unsure of.

I noticed on my OMAP4430 SDP that in suspend L3INIT was failing to enter 
retention state. I am not sure if this is the same problem that you are 
seeing or not. However, I found that the reason the L3INIT was not entering
retention on this board was because the USB DPLL was not locked by the
bootloader on this board. On my panda the USB DPLL is locked the L3INIT 
is entering suspend. 

I crafted the following which is working on my omap4430 panda, sdp and 
omap4460 panda. Let me know what you think ...

Cheers
Jon

>From 3bfe708af8e91564bc78c79111f9080a35fb5b88 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Tue, 5 Feb 2013 13:27:57 -0600
Subject: [PATCH] ARM: OMAP4: Fix low power in kernel suspend

Some versions of the u-boot bootloader do not lock the USB DPLL and
when the USB DPLL is not locked, then it is observed that the L3INIT
power domain does not transition to retention state during kernel
suspend on OMAP4 devices. Fix this by locking the USB DPLL at 960 MHz
on kernel boot.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index e71a19c..2c811d9 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -48,6 +48,13 @@
  */
 #define OMAP4_DPLL_ABE_DEFFREQ				98304000
 
+/*
+ * OMAP4 USB DPLL default frequency. In OMAP4430 TRM version V, section
+ * "3.6.3.9.5 DPLL_USB Preferred Settings" shows that the preferred
+ * locked frequency for the USB DPLL is 960MHz.
+ */
+#define OMAP4_DPLL_USB_DEFFREQ				960000000
+
 /* Root clocks */
 
 DEFINE_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
@@ -2045,5 +2052,13 @@ int __init omap4xxx_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
+	/*
+	 * Lock USB DPLL on OMAP4 devices so that the L3INIT power
+	 * domain can transition to retention state when not in use.
+	 */
+	rc = clk_set_rate(&dpll_usb_ck, OMAP4_DPLL_USB_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+
 	return 0;
 }
-- 
1.7.10.4
