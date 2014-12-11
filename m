From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
Date: Thu, 11 Dec 2014 09:11:45 -0800
Message-ID: <20141211171145.GA2990@atomide.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com>
 <20141210150049.GD4602@saruman>
 <20141211004627.GB5585@earth.universe>
 <20141211142159.GD20762@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44411 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752064AbaLKRO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2014 12:14:59 -0500
Content-Disposition: inline
In-Reply-To: <20141211142159.GD20762@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

Hi,

* Felipe Balbi <balbi@ti.com> [141211 06:24]:
> On Thu, Dec 11, 2014 at 01:46:28AM +0100, Sebastian Reichel wrote:
> > 
> > Each IP-Core connected to the bus of OMAP processors has
> > three registers, which specify the IP-Core's version, its
> > status and setup of PM features.
> > 
> > Required Properties:
> > - ti,prcm-type: must be one of the following:
> >    1 for OMAP2+ register style,
> >    2 for OMAP4+ register style,
> >    3 for AM33xx register style

This is the simple part and tells the type of the wiring of
the device :)

> > - reg: offset to revision, config and status registers
> >        relative to module base address

I don't think we should set up the sysconf registers as a child
of the device. These registers are not a child of the device on
the bus. They are sprinkled within the driver reg space. And some
of these sysc registers are way into the driver registers, it's
not always 0-0x10-0x14 layout for the sysconfig register offsets.

> > Optional Properties:
> > - ti,idlemodes:                bit field of flags (SIDLE)
> >    PRCM_IDLE_FORCE               (1 << 0)
> >    PRCM_IDLE_NO                  (1 << 1)
> >    PRCM_IDLE_SMART               (1 << 2)
> >    PRCM_IDLE_SMART_WKUP          (1 << 3)
> > - ti,standbymodes:             bit field of flags (MIDLE)
> >    PRCM_STANDBY_FORCE            (1 << 0)
> >    PRCM_STANDBY_NO               (1 << 1)
> >    PRCM_STANDBY_SMART            (1 << 2)
> >    PRCM_STANDBY_SMART_WKUP       (1 << 3)

These look OK to me. They describe the features available in the
sysconfig registers that map in a different way depending of the
sysconfig type 1, 2 or 3.

Too bad we cannot autoprobe this information from the hardware.

> > - ti,sysc-has-autoidle:        config register has AUTOIDLE bit
> > - ti,sysc-has-softreset:       config register has SOFTRESET bit
> > - ti,sysc-has-enawakeup:       config register has ENAWAKEUP bit
> > - ti,sysc-has-emufree:         config register has EMUFREE bit
> > - ti,sysc-has-clock-activity:  config register has CLOCKACTIVITY bit
> > - ti,sysc-has-dma-disable:     config register has DMADISABLE bit
> > - ti,sysc-has-reset-status:    config register has RESETDONE bit
> > - ti,syss-has-reset-status:    status register has RESETDONE bit
> 
> I thought about having boolean flags like this but after talking to Tony
> we agreed that it would just increase the amount of string parsing
> during early initialization. Besides, why have two properties using an
> integer bitfield and another huge number of boolean properties ?

Yeah setting up individual register bits as strings is just too
much java like.. Setting them up like this means we are doing
devices * nr_sysc_feature_bits of string parsing. So I'd like to
avoid that by using bits like Felipe has done now that we have the
dts preprocessing happening.

> > - ti,reset-delay-us:           reset delay in us
> > 
> > Example:
> > 
> > ocp {
> > 	gpio1: gpio@48310000 {
> > 		compatible = "ti,omap3-gpio";
> > 
> > 		... /* IP-Core specific properties */
> > 
> > 		ti,sysconfig {
> 
> this is what I'm still waiting for comments from Tony. I'm not convinced
> we need this extra indentation level. It really brings nothing of value.

Me neither. It's also wrong from the register mapping point of
view like I explained above.

Cheers,

Tony
