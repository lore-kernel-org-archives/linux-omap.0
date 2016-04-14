From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Thu, 14 Apr 2016 13:34:58 -0700
Message-ID: <20160414203457.GM5995@atomide.com>
References: <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com>
 <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com>
 <570FF163.1050603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570FF163.1050603@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160414 12:38]:
> 
> Yes it has registers, but it has no prcm level existence, it is part of McBSP
> module. I guess when the OMAP3 was designed the HW people did not wanted to
> create new version of the McBSP core for McBSP2/3 so they attached a new core
> to the McBSP cores with different targets, etc, but w/o external dependency.

Yeah well we do have a bunch of modules that don't need any separate
functional clock and are clocked only by the interface clock. So in this
case McBSP and sidetone are both consumers for the clock we just happen
to call McBSP interface clock. They should be able to share that no
problem.

> >> OK. I will go with the assumption that the sidetone hwmod can be removed (as
> >> it is not correct) and rework my current series to use pdata callback for the
> >> iclk autogate allow/deny. With this set the ST will be operational in legacy
> >> and DT boot.
> > 
> > Sorry, no I did not want to drop the sidetone hwmod, I was just trying to
> > come up with ideas on how to make the driver changes easier. It sounds like
> > you already figured out the driver changes part though with two drivers.
> 
> If I need to keep the sidetone hwmod around I don't see how it can be done in
> a safe and clean way. It is part of McBSP module, it is accessible only if the
> McBSP module is enabled, you can not enable the Sidetone alone you need to go
> and enable the McBSP module. I don't think it is a good idea to let two
> separate hwmods to poke around the same PRCM bits. Have not checked, but I
> don't think we have refcounting for the PRCM register bits.

Yeah there's no refcounting on the PRCM, but the clock framework has it
for the share McBSP interface clock. Then there are two separate sets of
sysconfig registers that PM runtime should manage. And then there's the
clock autogating issue.

Note that we do have an issue with the omap4 and later clkctrl registers
that don't have refcounting. Tero's clkctrl work will sort out that
issue. I don't think we have a similar issue with omap3.

So from that point of view the two separate hwmod modules should work
just fine sharing the clock.

> I have things working w/o the two drivers with pdata callback both in legacy
> and DT case and it is pretty neat looking, thanks for the suggestion! I'm
> still figuring out the needed amount of callbacks from McBSP to ST and from ST
> to McBSP. We for sure going to need enable_stage1,2 probably three as well.
> But this crossing driver boundaries needs a bit more time to figure out.

Yeah I still think we need to struct device instances, one to manage
McBSP and the other to manage sidetone :)

Regards,

Tony
