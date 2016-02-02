From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 11:23:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602021116510.1653-100000@iolanthe.rowland.org>
References: <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Ulf Hansson wrote:

> That's not what we want. So I moved the checks to the actual
> ->runtime_resume() callback in the PM domain, instead of in the
> omap_device_enable() function. A version 2 is attached. Please give it
> at try.
> 
> [...]
> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Tue, 2 Feb 2016 10:05:39 +0100
> Subject: [PATCH V2] ARM: OMAP2+: omap-device: Allow devices to be pre-enabled
> 
> Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind") may re-initialize the runtime PM status of the
> device to RPM_SUSPENDED at driver probe failures.
> 
> For the omap_hsmmc and likely also other omap drivers, which needs more
> than one attempt to ->probe() (returning -EPROBE_DEFER), this commit
> causes a regression at the PM domain level (omap hwmod).
> 
> The reason is that the drivers don't put back the device into low power
> state while bailing out in ->probe to return -EPROBE_DEFER. This leads to
> that pm_runtime_reinit() in driver core, is re-initializing the runtime PM
> status from RPM_ACTIVE to RPM_SUSPENDED.

But isn't that okay?  When the system starts up, the PM core doesn't 
know the actual state of any device.  It just marks each device as 
RPM_SUSPENDED and disabled as it is registered.  It's the job of 
subsystems and drivers to make sure the stored state agrees with the 
actual physical state.

So why shouldn't pm_runtime_reinit() leave the structure the same as it 
would be if the device had just been registered?

> The next ->probe() attempt then triggers the ->runtime_resume() callback
> to be invoked, which means this happens two times in a row. At the PM
> domain level (omap hwmod) this is being treated as an error and thus the
> runtime PM status of the device isn't correctly synchronized with the
> runtime PM core.

Why doesn't the same problem arise the first time the device is probed?  
Or to put it another, why should a re-probe be any different from the 
initial probe?

> In the end, ->probe() anyway succeeds (as the driver don't checks the
> error code from the runtime PM APIs), but results in that the PM domain
> always stays powered on. This because of the runtime PM core believes the
> device is RPM_SUSPENDED.
> 
> Fix this regression by allowing devices to be pre-enabled when the PM
> domain's (omap hwmod) ->runtime_resume() callback is requested to enable
> the device. In such cases, return zero to synchronize the runtime PM
> status with the runtime PM core.

Is this really the right way to fix the problem?

Alan Stern

