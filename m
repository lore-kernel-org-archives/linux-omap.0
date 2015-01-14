From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
Date: Wed, 14 Jan 2015 11:04:19 -0800
Message-ID: <20150114190419.GO2419@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-7-git-send-email-tony@atomide.com>
 <20150114012447.GF18523@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19098 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbANTIC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 14:08:02 -0500
Content-Disposition: inline
In-Reply-To: <20150114012447.GF18523@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Felipe Balbi <balbi@ti.com> [150113 17:28]:
> On Tue, Jan 13, 2015 at 03:13:56PM -0800, Tony Lindgren wrote:
> > +
> > +#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
> > +#define TI81XX_GLOBAL_RST_COLD		BIT(1)
> > +
> > +/**
> > + * ti81xx_restart - trigger a software restart of the SoC
> > + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> > + * @cmd: passed from the userspace program rebooting the system (if provided)
> > + *
> > + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> > + * kernel/sys.c.  No return value.
> > + */
> > +void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> > +{
> > +	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
> > +				   TI81XX_PRM_DEVICE_RSTCTRL);
> 
> do you need to check that mode == REBOOT_COLD here ?

Looks like not, trying to use the warm reset bit does not seem to do
anything and probably requires manually resetting clocks into bypass
mode or something.

I'll just add a comment about that.

Regards,

Tony
