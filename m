From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Mon, 4 Apr 2016 08:12:01 -0700
Message-ID: <20160404151200.GA4652@atomide.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com>
 <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57026205.6020105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160404 05:47]:
> On 04/02/16 03:17, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [160401 02:34]:
> >> So what shall we do with the OMAP3 McBSP2/3 sidetone? It has been broken in DT
> >> boot since the first time we booted OMAP3 with DT... Only in legacy mode we
> >> can have properly working ST.
> > 
> > Grr.
> 
> Yes :(
> The reason for this is that in DT boot we can not provide the
> enable_st_clock() callback to the mcbsp driver stack. This is done for legacy
> boot in mach-omap2/mcbsp.c

Seems like the short term fix there is to pass enable_st_clock pointer
in pdata using pdata-quirks.c. Then for the long term solution using
PM runtime to block gating of the clock while sidetone is active is
the way to go it seems.

> The ST does not have clocks coming from PRCM level, it only uses the McBSP
> iclk when it is enabled (the McBSP block of the McBSP). As far as pm_runtime
> goes I think the ST module should not use it. We can not tell hwmod to
> enable/disable the McBSP2/3 iclk when we pm_runtime for the ST. It does not
> help at all. We can have nop action for the ST when pm_runtime is used, but
> then why would we have it?

Using PM runtime in the sidetone driver should just work as long as the
sidetone device driver depends on the McBSP driver before it gets probed.
The clock framework handles things for the mcbsp ick with the usecount.
And doing pm_runtime_get() in the sidetone driver will do what the legacy
enable_st_clock() does currently.

> > So having two separate drivers might make things a lot simpler.
> 
> Not really. It will make things way more complicated imho. How to handle
> legacy boot as we still have that supported?

Hey both the legacy driver and DT driver are really just platform devices
and drivers. And passing both dts and platform data can be done just
fine, no?

> When the McBSP driver is loaded we must know if it has sidetone or not so
> we can create the needed audio controls, sysfs entries. The sysfs and
> kcontrol registration could be moved out to the new ST driver, true.

Yeah during the probe, the sidetone driver must register with the McBSP
driver to tell it's there. I guess no need to pass anything in the
dts or platform_data for that.

> I actually started with two separate drivers approach first, but decided that
> it does not worth the effort (legacy boot support, pm_runtime/hwmod hassle,
> platform data, callback API design, etc).
> I know, it is not rocket science but it is king of shoot out of cannon into
> sparrows.
> I'll think about it for a little while ;)

Well what we've seen so far is that any kind of non-standard solution
will always be a pain to maintain in the long run :)

> > If you don't treat the McBSP and sidetone as separate modules, things can
> > easily fail. For example, doing a read-back to flush of posted write to
> > sidetone registers flushes nothing for McBSP and the other way around.
> 
> I don't see problem with the need of flushing if we would need it. I don't
> think we are doing anything proactively to flush writes in the driver today
> and we do have at least one product using the ST (n900).

Usually the problem is with an interrupt ack write not reaching the device
in time before something else happens. So I could see mysterious issues
happening with the McBSP and sidetone having separate interrupts. Maybe
not a real problem, but the chance for it is still there for sure.

> >> Other option would be to deprecate the ST support as such, but that would
> >> leave the n900 guys in trouble as they need ST to be functional...
> > 
> > That does not sound like a nice option at all :(
> 
> I know. This has been bugging me for a long time. I want to fix this one
> before my beagleboard-xm gives up and won't boot up anymore since after that I
> will have no omap3 board to work with :(

There are plenty of cheap omap3 devices available out there though :)

Regards,

Tony
