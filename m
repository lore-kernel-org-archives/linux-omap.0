From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Fri, 8 Jun 2012 19:32:38 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA46087@DBDE01.ent.ti.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
 <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com>
 <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
 <4FD09EFA.20304@ti.com>
 <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com>
 <4FD1FA8C.1080600@ti.com>
 <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab2FHTcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 15:32:50 -0400
In-Reply-To: <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Fri, Jun 08, 2012 at 18:58:51, Paul Walmsley wrote:
> On Fri, 8 Jun 2012, Cousson, Benoit wrote:
> 
> > On 6/8/2012 3:11 AM, Paul Walmsley wrote:
> > > On Thu, 7 Jun 2012, Cousson, Benoit wrote:
> > > 
> > > > Indeed, what I did not mention is that potentially the whole device 
> > > > init should be done ondemand as well. Meaning the whole hwmod setup 
> > > > phase should be done only when the driver will probe the device.
> > > 
> > > That means if no driver exists for an IP block, or if the driver isn't
> > > using PM runtime, the IP block won't be reset.  And somehow we still are
> > > missing drivers in mainline.  We also still have drivers that aren't yet
> > > PM runtime converted.
> > 
> > No the point is still the same as before. You let the drivers do the job if
> > they are there, and then do a pass at very late time during the boot process
> > to handle the ones that were not probed by any driver.
> 
> Ah, I see what you mean.  Above you wrote that the the hwmod setup phase 
> would be done only when the driver will probe the device.  But you also 
> mean that it should also be done for the remaining devices before starting 
> userspace.
> 
> > At least you will avoid the enable -> reset -> idle -> enable sequence 
> > we are doing right now for most of the active drivers when it is not 
> > necessary.
> 
> It must not be widely known, but early reset was implemented 
> intentionally.  The goal was to keep any configuration damage from 
> out-of-date or broken bootloaders or previous OSes to a minimum length of 
> time during the boot process.
> 
> I don't really have a huge problem with switching to a late reset, 
> but there are disadvantages to it.
> 
> 

I was reading all these discussion and was holding myself back, so that I 
digest before adding another flavor to this discussion,

In case of AM33xx, recently I came across similar issue (rather more than this) with CPSW module.

The issue is,

We have observed that, in order to disable the CPSW module (MODULEMODE=0x0),
We have to assert OCP level reset, before disabling it; else module enters into unknown state, where register status shows, MODULEMODE turns 0x0, but idlests says module is busy.

This has to be done everytime you try to disable the module.

The worst part here is, CPSW has 4 submodules (SS, SL1, SL2, CPDMA),
We have to assert reset signal to each submodules.

So the approach I had taken is, I had implemented almost similar function specific to cpsw and introduced flag called HWMOD_SWSUP_RESET_BEFORE_IDLE.


Now the question here would be, should we consider this IP bug or 
integration bug? If it is integration bug, then isn't this device issue?

Thanks,
Vaibhav

