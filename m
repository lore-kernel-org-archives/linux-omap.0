From: Tony Lindgren <tony@atomide.com>
Subject: Re: debugfs pinctrl crash on beagle-xm
Date: Fri, 13 Dec 2013 09:04:39 -0800
Message-ID: <20131213170438.GA28184@atomide.com>
References: <52A6EFE5.2040706@ti.com>
 <52AA4894.4040901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53649 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753122Ab3LMREl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 12:04:41 -0500
Content-Disposition: inline
In-Reply-To: <52AA4894.4040901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [131212 15:38]:
> On 12/10/2013 04:41 AM, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On beagle-xm, v3.13-rc3, I see the following crash if I use the pinctrl
> > debugfs:
> > 
> > # cat /debug/pinctrl/48002030.pinmux/pins
> > [   16.464233] Unhandled fault: external abort on non-linefetch (0x1028)
> > at 0xfa002268
> 
> in 3630 TRM, There is a hole in the memory map between
> 0x48002264(CONTROL_PADCONF_SDRC_CKE1) and
> 0x480025A0(CONTROL_PADCONF_SDRC_BA0) which obviously generates abort
> when read at 0x48002268
> 
> on 3430, we should also see a crash in the hole region
> 0x48002264(CONTROL_PADCONF_SDRC_CKE1) to
> 0x480025D8(CONTROL_PADCONF_ETK_CLK).
> 
> in dts, omap3_pmx_core: pinmux@48002030 describes the range as reg =
> <0x48002030 0x05cc> (which is the max range for the module)
> 
> wish pinctrl-single driver could support handle multiple address ranges?
> 
> [...]

There's an RFC patch from Laurent to split the pmx_core into two instances
that should take care of this issue:

[PATCH/RFC] ARM: omap3: Split the pinmux core device

Regards,

Tony
