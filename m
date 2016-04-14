From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Thu, 14 Apr 2016 09:55:15 -0700
Message-ID: <20160414165514.GL5995@atomide.com>
References: <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com>
 <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com>
 <570F4804.4050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570F4804.4050006@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160414 00:35]:
> On 04/13/16 18:28, Tony Lindgren wrote:
> > 
> > You could just create the sidetone child device manually on probe in the
> > driver as needed. That way you'd have two devices to do the PM runtime
> > on. I think that was Paul's main concern as they are separate modules.
> 
> You mean that not to have separate compatible for the McBSP module's Sidetone
> core?
> If yes, then it is a valid thing to remove the hwmod data for the sidetone,
> like I did in this series.

No, I meant keep the sidetone hwmod, it really is there in the hardware.

I meant only probe the sidetone in the McBSP probe so you have two
struct dev and two hwmod entries in the McBSP driver. I don't know if
this actually makes things easier or not though.

> > It still leaves the chance of bugs with flush of posted writes. But might
> > make things easier to deal with in small steps?
> 
> The only 'benefit' I see with separated driver for McBSP core and Sidetone
> core is that the register writes will happen to the cores in separate drivers.
> 
> If the McBSP driver creates the device for the sidetone driver, then passing
> the needed callbacks and data to it is going to be cleaner. Registering back
> the callbacks to McBSP is what need to be figured out, so it is simple and
> clean. Either with a callback to McBSP to set the ST callbacks or have the
> callback struct used by ST via pdata to have places for the ST to McBSP
> callbacks and when the driver loads it is going to set up those.

OK yeah makes sense to me.

> If I remove the prcm section for the ST hwmod:
> [   87.784820] omap_hwmod: mcbsp2_sidetone: _wait_target_ready failed: -22
> [   87.784851] omap-mcbsp 49022000.mcbsp: use pm_runtime_put_sync_suspend() in
> driver?
> 
> When first try to use the audio.
> So the hwmod code at least was checking the idlest bit.

Yes the module is really there for sidetone, and it really has hardware
registers :)

> OK. I will go with the assumption that the sidetone hwmod can be removed (as
> it is not correct) and rework my current series to use pdata callback for the
> iclk autogate allow/deny. With this set the ST will be operational in legacy
> and DT boot.

Sorry, no I did not want to drop the sidetone hwmod, I was just trying to
come up with ideas on how to make the driver changes easier. It sounds like
you already figured out the driver changes part though with two drivers.

Regards,

Tony
