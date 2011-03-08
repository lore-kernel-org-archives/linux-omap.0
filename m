From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested
 pads
Date: Tue, 8 Mar 2011 12:16:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081211170.10981@utopia.booyaka.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com> <87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com> <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com> <20110308172625.GE26463@atomide.com> <87k4g9qxa9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87k4g9qxa9.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Govindraj <govindraj.ti@gmail.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, 8 Mar 2011, Kevin Hilman wrote:

> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Govindraj <govindraj.ti@gmail.com> [110308 03:43]:
> >> 
> >> I am not sure whether now we can control read/writes to pad_mux from any driver
> >> interface and I think we have to go through mux framework for any
> >> read/writes to mux.
> >
> > Sure, the drivers should not mess with those registers directly.
> >
> >> with this I cant control pad wake up capabilities with sysfs as done
> >> earlier in serial.c
> >> now control to read/write to pad is outside scope of the driver
> >> interface as omap_hwmod_mux
> >> is the one that takes decision for driver with mux values provided
> >> during omap_hwmod_mux_init.
> >
> > The sysfs interface to control this should still be from the drivers.
> > Sounds like we need some way to set the wakeup flags before pm_runtime_put
> > is called.
> 
> Exactly.  Driver's can currently check device_may_wakeup(dev) to
> determine if they *should* set wakeup flags, but currently, we don't
> have a clean way to pass the info down to core code.
> 
> One possible option (albeit hacky) is for the omap_hwmod_mux code to
> check device_may_wakeup() itself, and set the bits accordingly.  This
> means drivers don't have to do anything, but drivers also loose control
> of enabling/disabling wakeups.
> 
> I think what we need are two omap_device-level APIs for wakeups.
> 
> One for enable/disable of wakeups (both module-level and IO-ring, the 
> driver should not care about the difference between the two):

Probably this should only control IO-ring/chain wakeups.  Enabling 
asynchronous wakeups will need to be handled differently...

> int omap_device_[enable|disable](struct platform_device *pdev);
> 
> bool omap_device_wakeup_occured(struct platform_device *pdev);
> 
> As OMAP-specific APIs, both of these should of course be called through
> pdata function pointers.

Looks good to me, modulo the obvious corrections, although the names of 
these functions should probably say "ioring_wakeup" rather than just 
"wakeup" to make it clear what exactly they are intended to do.

As we discussed in chat, we can drop the existing 
omap_hwmod_{enable,disable}_wakeup() functions, since these were 
effectively obsoleted by commit 9980ce53 ("OMAP: hwmod: Enable module 
wakeup if in smartidle").


- Paul
