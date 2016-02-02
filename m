From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 15:41:45 -0800
Message-ID: <20160202234145.GC19432@atomide.com>
References: <20160201232833.GR19432@atomide.com>
 <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
 <20160202030533.GT19432@atomide.com>
 <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
 <20160202163536.GU19432@atomide.com>
 <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160202 12:48]:
> On 2 February 2016 at 17:35, Tony Lindgren <tony@atomide.com> wrote:
> > That's a valid error though, let's not remove it. The reason why we
> > call runtime_resume() twice is because runtime_suspend callback never
> > gets called like I explain above.
> 
> This isn't an error, it's just a hickup in the synchronization of the
> runtime PM status.

I'd rather not get the hardware state out of sync with PM runtime..

> Very similar what happens at the first probe, when the driver core has
> initialized the runtime PM status to RPM_SUSPENDED at the device
> registration.

Well we actually pretty much have devices in that state to start
with.

> To me, it's the responsible of the PM domain to *help* with the
> synchronization, not prevent it as it currently does.

The problem is that the hardware state gets out of sync with
PM runtime. And that's going to be a pain to debug later on.

> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2232,6 +2232,7 @@ err_irq:
> >                 dma_release_channel(host->tx_chan);
> >         if (host->rx_chan)
> >                 dma_release_channel(host->rx_chan);
> > +       pm_runtime_dont_use_autosuspend(host->dev);
> 
> It's good know this works, although do you intend to fix this sequence
> for all omap drivers/devices that's part of the hwmod PM domain?
> 
> I haven't checked the number of drivers this would affect, but I
> imagine there could be quite many with similar behaviour and thus may
> suffer from the same issue.

Yeah not sure what the right fix is. But I'd rather patch the
few drivers using autosuspend if we come to the conclusion
that there is no bug in PM runtime.

> Could you please test my version 2 of the patch I attached earlier. I
> still believe it's the best way to solve the regression, if it works
> of course. :-)

And I don't like it because of the reasons above :) But yeah
gave it a quick try and that too works as expected.

Regards,

Tony
