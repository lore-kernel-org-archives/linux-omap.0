From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/3] OMAP3: Remove auto-selection of PMICs
Date: Mon, 22 Aug 2011 21:29:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930256DE2CDE@dbde02.ent.ti.com>
References: <1313754573-11498-1-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-2-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-3-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-4-git-send-email-abhilash.kv@ti.com>,<20110822150301.GY4607@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab1HVP71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 11:59:27 -0400
In-Reply-To: <20110822150301.GY4607@sortiz-mobl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "david.woodhouse@intel.com" <david.woodhouse@intel.com>

> From: Samuel Ortiz [sameo@linux.intel.com]
> Sent: Monday, August 22, 2011 8:33 PM
> To: Koyamangalath, Abhilash
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>  tony@atomide.com; linux@arm.linux.org.uk; Hilman, Kevin; Shilimkar, Santosh; Premi, Sanjeev;
>  david.woodhouse@intel.com
> Subject: Re: [PATCH 3/3] OMAP3: Remove auto-selection of PMICs
> 
> Hi Anhilash,
> 
> On Fri, Aug 19, 2011 at 05:19:33PM +0530, Abhilash K V wrote:
> > The current implementation almost assumes that only
> > TWL4030/TWL5030/TWl6030 are (or can be) used with the
> > OMAP processors. This is, however, not true.
> 
> I don't like the mfd/Kconfig change. Why would those drivers be only buildable
> on OMAP processors ?
> Unless there is a real reason for this, you should fix the drivers instead.

You are right. The change for config item TWL4030_CORE should be removed.
> -	depends on I2C=y && GENERIC_HARDIRQS
> +	depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP3 || ARCH_OMAP4)

In fact, change for TWL4030_POWER should be 
-	depends on TWL4030_CORE && ARM
+	depends on TWL4030_CORE

This would allow these PMICs to be used with other processors as well. There may
be issues run-time issues; but they would most likely surface only when there is
a combination without any of the OMAPs. (We would try a dummy build for another
processor with TWL4030 selected.)

The original idea was to ensure that nothing else breaks when the auto selection
of the PMICs is removed.

~sanjeev

> 
> Cheers,
> Samuel.
> 
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
