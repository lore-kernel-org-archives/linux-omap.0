From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Date: Thu, 21 Jun 2018 14:02:00 +0200
Message-ID: <CAJZ5v0iU5Qqbm6LDNmm=vj_H_sXRasdFN9+xBGto_-eZG6tXrQ@mail.gmail.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com> <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com> <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Samuel Morris <samorris@lexmark.com>, Tony Lindgren <tony@atomide.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Tejun Heo <tj@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Santosh Shilimkar <ssantosh@kernel.org>, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 21, 2018 at 9:58 AM, Roger Quadros <rogerq@ti.com> wrote:
> +Rafael
>
> On 20/06/18 18:30, Samuel Morris wrote:
>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>>> Tony,
>>>
>>> On 20/06/18 13:29, Tony Lindgren wrote:
>>>> Hi,
>>>>
>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>>>>
>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>>>> hotplug to save power").
>>>>
>>>> Reverting the patch makes things work again. Any ideas what
>>>> might be going wrong here? Things clearly idle but then there
>>>> seems to be some register access with clocks disabled.
>>>
>>> The commit is doing this in probe.
>>>
>>> +       pm_runtime_set_active(dev);
>>>         pm_runtime_enable(dev);
>>> -       pm_runtime_get_sync(dev);
>>> +       pm_runtime_forbid(dev);
>>>
>>> On OMAP, the device is not guaranteed to be active at probe and so we can't
>>> say pm_runtime_set_active() and get rid of pm_runtime_get_sync().
>>
>> Okay, by calling set_active(), I'm preventing the rpm_resume from
>> completing that would normally happen in pm_runtime_forbid(). I assume
>> you mean that there are parent devices that need to be resumed before
>
> Actually, in the OMAP case, the AHCI controller device isn't active when probe is called.
> For other platforms this might not be the case. So we need to be careful here.
>
>> this device may be assumed active. I'm going to try removing the
>> set_active(), then move that clause to the end of
>> ahci_platform_init_host(). The pm_runtime_forbid() is effectively the
>> same as get_sync(), it just also sets the runtime_auto flag to false.
>> I don't think we should be saying the device is active until the host
>> is initialized, so that seems like a better, common place for the
>> pm_runtime init callbacks anyway. How does that sound?
>
> Device active and initialized are different things. If the device is powered up
> and can be accessed it is active, even if it is not yet initialized.
> I don't think we should club the two.
>
> Why do you need to call pm_runtime_set_active() at all in the probe sequence?
>
> Documentation for pm_runtime_set_active() says,
> "(it is only valid to use this function if 'power.runtime_error' is set
> or 'power.disable_depth' is greater than zero);"

I guess on some platforms the AHCI controller actually is active
initially and that's a matter of setting the initial status to reflect
the real situation.

If different things can happen on different platforms, there needs to
be a way to discover the initial state instead of making assumptions
on it.

Thanks,
Rafael
