From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Tue, 2 Feb 2016 21:24:41 +0100
Message-ID: <CAPDyKFokWcLSCAh_TX-j-df_M1hN8Qw1gbQt--SyWccGCPiN5Q@mail.gmail.com>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
	<Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

[...]

>>
>> Your observations is correct. The hardware will be kept active
>> in-between the probe attempts (and thus also if probing fails).
>> Although, that's not a regression as that's the behaviour you get from
>> runtime PM, when drivers are implemented like omap_hsmmc.
>
> Perhaps this is what we should do.  If probing gets deferred a few
> times, doing runtime suspends and resumes in between will be a waste of
> time.

Then you will have to distinguish between -EPROBE_DEFER and other
errors, as I think leaving the device fully powered from a permanent
failed probe isn't very good.

Anyway, for sure it's doable by the driver, but let's try to focus on
the regression here for now.

>
>> Instead of the suggested approaches, I think the regression should be
>> fixed at the PM domain level (omap hwmod). I have attached a patch
>> below, please give it try as it's untested.
>>
>> To solve the other problem (allowing devices to become inactive
>> in-between at probe failures), I see two options (not treated as
>> regressions).
>> 1)
>> Change the behaviour of pm_runtime_put_sync(), to *not* respect the
>> autosuspend mode.
>> I think I prefer this option, as it seems like autosuspend should be
>> respected only via the asynchronous runtime PM APIs.
>
> ?  pm_runtime_put_sync() _already_ does not respect the autosuspend
> mode.  If you want to respect it, you have to call
> pm_runtime_put_sync_autosuspend() instead.

Then there's a bug in the runtime PM core.

>From Tony's regression report and from mine own local runtime PM test
driver, I can see that the device doesn't get RPM_SUSPENDED (the
->runtime_suspend() callback isn't called), even when the usage count
is zero - when pm_runtime_put_sync() is called.

To find the sequence of runtime PM commands, go ahead an have look in
the omap_hsmmc driver. The problem occurs when the driver bails out in
probe, when it receives -EPROBE_DEFER when fetching regulators.

I have some more data to share on this problem from my runtime PM test
driver. I will try my best to share it tomorrow.

>
>> 2)
>> Change the failing drivers, to before calling pm_runtime_put_sync()
>> also invoke pm_runtime_dont_use_autosusend(). Or other similar
>> approach.
>
> Given the above, this seems unnecessary.

Okay, so you are saying that the pm_runtime_put_sync() should idle the
device even if autosuspend is in use. That seems reasonable, I will
look into this problem.

Kind regards
Uffe
