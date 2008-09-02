From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [Review Request] Adding csi2_fck declaration to clock34xx.h
Date: Tue, 2 Sep 2008 17:31:03 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A0781B@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808201650540.1636@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44093 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbYIBWbL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:31:11 -0400
In-Reply-To: <alpine.DEB.1.00.0808201650540.1636@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

I had regenerated the patch with your suggestions.

Resending it now for your review.

Regards,
Sergio

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Wednesday, August 20, 2008 6:08 PM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: Re: [Review Request] Adding csi2_fck declaration to clock34xx.h

Hello Sergio Alberto,

a few comments below.

On Wed, 20 Aug 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> Can you please review the attached patch to see if:
>
> -          Is the declaration done correctly?

Please include the patch text into the E-mail body, rather than attaching 
it.  This way, it's much easier to comment on specific sections.  It's 
been inserted below, and comments are inlined:

Index: omapkernel/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/clock34xx.h	2008-08-18 19:28:34.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/clock34xx.h	2008-08-18 19:30:51.000000000 -0500
@@ -2210,6 +2210,17 @@
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk csi2_fck = {
+        .name           = "csi2_fck",

Please use the clock name as it's listed in the TRM, e.g., "csi2_96m_fck" 
(but convert the "fclk" on the end to "fck", for legacy reasons).  Please 
use that for both the structure name and the clock name.

+        .parent         = &core_96m_fck,
+        .init           = &omap2_init_clk_clkdm,
+        .enable_reg     = _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+        .enable_bit     = 1,

Rather than using a number in the .enable_bit field, please use a symbolic 
constant.  In this case, use OMAP3430_EN_CSI2_SHIFT.  You'll also need to 
patch cm-regbits-34xx.h to add that macro.

+        .flags          = CLOCK_IN_OMAP343X,
+        .clkdm_name     = "cam_clkdm",
+        .recalc         = &followparent_recalc,
+};
+
 /* USBHOST - 3430ES2 only */
 
 static struct clk usbhost_120m_fck = {
@@ -3190,6 +3201,7 @@
 	&dss_ick,
 	&cam_mclk,
 	&cam_ick,
+	&csi2_fck,

(of course, this will need to be updated also with the new name)

 	&usbhost_120m_fck,
 	&usbhost_48m_fck,
 	&usbhost_ick,

> - Should that be enough for handling the CSI2 functional clock with the 
> clock API

Looks like it should work fine,


- Paul

