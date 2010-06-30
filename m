From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot fail on OMAP3430SDP
Date: Wed, 30 Jun 2010 09:06:53 +0300
Message-ID: <20100630060653.GP2822@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305A40F8A@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870305A40FBB@dbde02.ent.ti.com>
 <A24693684029E5489D1D202277BE8944562E8FB4@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03237636F1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58658 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0F3GGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 02:06:44 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03237636F1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [100629 19:07]:
> Aguirre, Sergio wrote:
> > Sripathy, Vishwanath wrote:
> > > Here is the log from Early printk.
> > > 
> > 
> > <snip>
> > 
> > > Could not get gpios_ick
> > > Could not get gpios_fck
> > 
> > Probably Tony will be the best to answer this, but... This 
> > code shouldn't get executed I think (the one producing above prints)..
> > 
> > Above clocks are declared for omap2 only (in arch/arm/mach-omap2/clock24[20,30]_data.c), and even this 
> > clk_get calls are inside of a supposedly omap2 only execution in arch/arm/plat-omap/gpio.c:
> > 
> > static int __init _omap_gpio_init(void)
> > {
> > ...
> > ...
> > #if defined(CONFIG_ARCH_OMAP2)
> > 	if (cpu_class_is_omap2()) {
> 
> 
> Isn't cpu_class_is_omap2() valid for OMAP3 as well?

Yeah. The above should be just if (cpu_is_omap24xx()) instead.
But that's just a warning and should not matter for the boot
issue.

To me it looks like the early_printk works, but the 8250 serial
console never gets initialized?

Tony
