From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: omap_device: handle first time activation of
 console device
Date: Thu, 17 Nov 2011 10:52:44 +0100
Message-ID: <4EC4D96C.9050804@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com> <1321441346-19591-2-git-send-email-rnayak@ti.com> <4EC3D037.6020901@ti.com> <4EC4B56F.2040504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4EC4B56F.2040504@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

Hi Rajendra,

On 11/17/2011 8:19 AM, Rajendra Nayak wrote:
> [...]
>>> +static int omap_console_hwmod_enable(struct omap_device *od)
>>> +{
>>> + console_lock();
>>> + /*
>>> + * For early console we prevented hwmod reset and idle
>>
>> A period is missing. Or maybe it should a comma with not capital letter.
>>
>>> + * So before we enable the uart clocks idle the console
>>> + * uart clocks, then enable back the console uart hwmod.
>>> + */
>>> + omap_hwmod_idle(od->hwmods[0]);
>>> + omap_hwmod_enable(od->hwmods[0]);
>>
>> Why do we have to idle -> enable? The module is already enabled, isn't
>> it?
>> The comment is not super clear for me :-)
>> Is the goal is to reset the IP?
>
> Yes, now that I read it, it does sound confusing. I should have at-least
> read it once before I picked it from serial.c
>
> But anyway, here's what the problem is.
>
> I feel its partly to do with the inability of hwmod to handle some
> modules which are left enabled post a setup, due to the
> 'HWMOD_INIT_NO_IDLE' flag set.
> Such modules end up with a hwmod state as '_HWMOD_STATE_ENABLED' post
> a setup. Now when a driver for such devices/modules tries to enable the
> module the first time, hwmod throws up a big WARN stating the hwmod is
> already in an enabled state.

OK, now, that makes sense :-)
We have hwmod in ENABLE state whereas the omap_device is still in IDLE 
or even DISABLE.

> [uart used as console is one such module, which cannot be idled post a
> setup by hwmod]
>
> If hwmod could be made in some way intelligent enough to know that the
> module is in enabled state because of the 'HWMOD_INIT_NO_IDLE' itself,
> a lot of this hackery might not be needed at all.

Fully agree, the fmwk should handle that.

> Simplest way to do it could be to just add another intermediate state,
> something like '_HWMOD_STATE_ENABLED_AT_INIT'.
> I will post a patch for this, see if you like it being handled that way.

That seems to be good. I'm just wondering if we need to introduce a new 
state for that or use a dedicated flag.
My concern is just that we will have two flavors of HWMOD_STATE_ENABLED 
that we will have to check in various places in the hwmod core code.

Maybe that's not such a big deal. Go ahead, and we will see how it looks 
like.

> The other part of the problem is also with the inability to hook up
> 'custom' omap_device_pm_latency for omap devices created from DT.
> Maybe a lot of such cases which need custom activate/deactivate
> functions might have to be handled in some way in the framework
> itself like the one above.

For the moment, it looks like only the serial is requiring such custom 
stuff, but anyway, we should have a mechanism to allow that...

Thanks,
Benoit

