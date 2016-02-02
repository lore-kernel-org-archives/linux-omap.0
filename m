From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Tue, 2 Feb 2016 21:47:20 +0100
Message-ID: <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
	<Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
	<20160202030533.GT19432@atomide.com>
	<CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
	<CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
	<20160202163536.GU19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202163536.GU19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 2 February 2016 at 17:35, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [160202 02:43]:
>>
>> For the omap_hsmmc and likely also other omap drivers, which needs more
>> than one attempt to ->probe() (returning -EPROBE_DEFER), this commit
>> causes a regression at the PM domain level (omap hwmod).
>>
>> The reason is that the drivers don't put back the device into low power
>> state while bailing out in ->probe to return -EPROBE_DEFER. This leads to
>> that pm_runtime_reinit() in driver core, is re-initializing the runtime PM
>> status from RPM_ACTIVE to RPM_SUSPENDED.
>
> Yup, that's the bug here. It seems that we never call the runtime_suspend
> callback at the end of a first failed device driver probe if the driver
> has set pm_runtime_use_autosuspend. Only rpm_idle runtime_idle callback
> gets called. So the device stays on.
>
> This does not happen if pm_runtime_dont_use_autosuspend() is added to
> the end of the device driver probe before pm_runtime_put_sync().

Thanks! It then confirms the second option I proposed.

>
>> The next ->probe() attempt then triggers the ->runtime_resume() callback
>> to be invoked, which means this happens two times in a row. At the PM
>> domain level (omap hwmod) this is being treated as an error and thus the
>> runtime PM status of the device isn't correctly synchronized with the
>> runtime PM core.
>
> That's a valid error though, let's not remove it. The reason why we
> call runtime_resume() twice is because runtime_suspend callback never
> gets called like I explain above.

This isn't an error, it's just a hickup in the synchronization of the
runtime PM status.

Very similar what happens at the first probe, when the driver core has
initialized the runtime PM status to RPM_SUSPENDED at the device
registration.

To me, it's the responsible of the PM domain to *help* with the
synchronization, not prevent it as it currently does.

>
>> In the end, ->probe() anyway succeeds (as the driver don't checks the
>> error code from the runtime PM APIs), but results in that the PM domain
>> always stays powered on. This because of the runtime PM core believes the
>> device is RPM_SUSPENDED.
>
> FYI, the following allows runtime_suspend callback to get called at the
> end of a failed driver probe so the hardware state matches the PM runtime
> state. Need to debug more.
>
> Regards,
>
> Tony
>
> 8< ------------
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2232,6 +2232,7 @@ err_irq:
>                 dma_release_channel(host->tx_chan);
>         if (host->rx_chan)
>                 dma_release_channel(host->rx_chan);
> +       pm_runtime_dont_use_autosuspend(host->dev);

It's good know this works, although do you intend to fix this sequence
for all omap drivers/devices that's part of the hwmod PM domain?

I haven't checked the number of drivers this would affect, but I
imagine there could be quite many with similar behaviour and thus may
suffer from the same issue.

Of course the regression is only noticed for those returning
-EPROBE_DEFER, which might not be that many, but it seems fragile to
rely on this when going forward. All related drivers then needs to be
fixed.

>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         if (host->dbclk)

Could you please test my version 2 of the patch I attached earlier. I
still believe it's the best way to solve the regression, if it works
of course. :-)

Kind regards
Uffe
