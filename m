From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 05/19] ARM: OMAP4: PM: Add SAR backup support towards
 device OFF
Date: Wed, 25 Apr 2012 10:18:29 +0300
Message-ID: <1335338309.2149.96.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <1334914432-26456-6-git-send-email-t-kristo@ti.com>
	 <20120424163547.GL3739@atomide.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60592 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab2DYHSg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 03:18:36 -0400
In-Reply-To: <20120424163547.GL3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, 2012-04-24 at 09:35 -0700, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [120420 02:39]:
> > +
> > +static int omap4_sar_not_accessible(void)
> > +{
> > +	u32 usbhost_state, usbtll_state;
> > +
> > +	/*
> > +	 * Make sure that USB host and TLL modules are not
> > +	 * enabled before attempting to save the context
> > +	 * registers, otherwise this will trigger an exception.
> > +	 */
> > +	usbhost_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
> > +						   OMAP4430_CM2_L3INIT_INST,
> > +						   OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET)
> > +	    & (OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK);
> > +
> > +	usbtll_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
> > +						  OMAP4430_CM2_L3INIT_INST,
> > +						  OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET)
> > +	    & OMAP4430_IDLEST_MASK;
> 
> Formatting here looks bad, maybe just do it in separate steps:
> 
> 	usbhost_state = omap4_cminst...
> 	usbhost_state &= OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK;
> ...
> 
> 
> > +	/*
> > +	 * Not supported on ES1.0 silicon
> > +	 */
> > +	if (omap_rev() == OMAP4430_REV_ES1_0) {
> > +		WARN_ONCE(1, "omap4: SAR backup not supported on ES1.0 ..\n");
> > +		return -ENODEV;
> > +	}
> 
> Everytime there's SoC/hardware revision detection in a non __init function, 
> something is most likely wrong.
> 
> 
> > +void omap4_sar_overwrite(void)
> > +{
> > +	u32 val = 0;
> > +	u32 offset = 0;
> > +
> > +	if (cpu_is_omap446x())
> > +		offset = 0x04;
> 
> Here too.
> 
> 
> > +static int __init omap4_sar_ram_init(void)
> > +{
> > +	/*
> > +	 * To avoid code running on other OMAPs in
> > +	 * multi-omap builds
> > +	 */
> > +	if (!cpu_is_omap44xx())
> > +		return -ENODEV;
> 
> You should configure things here instead by setting function
> pointers or variables.
> 
> Regards,
> 
> Tony

Okay, I can drop rest of these from this patch, most of them do not
exist in the final code (removed by later patches for autogeneration), I
just left this here for historical reasons.

-Tero

