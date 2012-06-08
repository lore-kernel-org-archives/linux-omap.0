From: Paul Walmsley <paul@pwsan.com>
Subject: AM335x CPSW reset (was "RE: [PATCH 04/11] ARM: OMAP2+: usb_host_fs:
 add custom reset for usb_host_fs (fsusb)")
Date: Fri, 8 Jun 2012 17:10:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206081659230.17523@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com> <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA46087@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33675 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761616Ab2FHXKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 19:10:04 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA46087@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi

On Fri, 8 Jun 2012, Hiremath, Vaibhav wrote:

> In case of AM33xx, recently I came across similar issue (rather more 
> than this) with CPSW module.
> 
> The issue is,
> 
> We have observed that, in order to disable the CPSW module 
> (MODULEMODE=0x0), We have to assert OCP level reset, before disabling 
> it; else module enters into unknown state, where register status shows, 
> MODULEMODE turns 0x0, but idlests says module is busy.
> 
> This has to be done everytime you try to disable the module.
> 
> The worst part here is, CPSW has 4 submodules (SS, SL1, SL2, CPDMA),
> We have to assert reset signal to each submodules.
> 
> So the approach I had taken is, I had implemented almost similar 
> function specific to cpsw and introduced flag called 
> HWMOD_SWSUP_RESET_BEFORE_IDLE.

Why "SWSUP" ? 

> Now the question here would be, should we consider this IP bug or 
> integration bug? If it is integration bug, then isn't this device issue?

I don't know if it's a bug in either place, but it sounds like something 
that needs to be handled in the _am335x_disable_module() code in 
mach-omap2/omap_hwmod.c.


- Paul
