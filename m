From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Thu, 18 Jul 2013 14:22:02 +0300
Message-ID: <51E7CFDA.6070600@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-3-git-send-email-grygorii.strashko@ti.com>
 <20130717153838.GJ7656@atomide.com> <51E6CCB6.2000907@ti.com>
 <20130718081405.GS7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130718081405.GS7656@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/18/2013 11:14 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [130717 10:11]:
>> On 07/17/2013 06:38 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [130717 04:49]:
>>>> Before switching to DT pinctrl states of OMAP IPs have been handled by hwmod
>>>> framework. After switching to DT-boot the pinctrl handling was dropped from
>>>> hwmod framework and, as it was recommended, OMAP IP's drivers have to be updated
>>>> to handle pinctrl states by itself using pinctrl_pm_select_xx() helpers
>>>> (see http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html)
>>>>
>>>> But this is not right for OMAP2+ SoC where real IPs state is controlled
>>>> by omap_device core which enables/disables modules & clocks actually.
>>>
>>> I'm not convinced we should try to handle this in a generic way
>>> as only some devices need dynamic remuxing of some pins.
>>>
>>>> For example, if OMAP I2C driver will handle pinctrl state during system wide
>>>> suspend the following issue may occure:
>>>> - suspend_noirq - I2C device can be still active because of PM auto-suspend
>>>>    |-_od_suspend_noirq
>>>>       |- omap_i2c_suspend_noirq
>>>>          |- PINs state set to SLEEP
>>>>    |- pm_generic_runtime_suspend
>>>>       |- omap_i2c_runtime_suspend()
>>>>          |- PINs state set to IDLE  <--- *oops* PINs state is IDLE and not SLEEP
>>>>    |- omap_device_idle()
>>>>       |- omap_hwmod_idle()
>>>>          |- _idle()
>>>>             |- disbale module (sysc&clocks)

Above call sequence explains what's going on when .suspend_noirq() is 
called - .suspend_noirq() handler ==> _od_suspend_noirq() and it's set 
for all OMAP2+ devices.


>>>
>>> And in this example you are assuming that you need separate idle and
>>> sleep states, which is not true at least for most cases I've seen.
>>
>> I don't need both states (at least right now) :), but
>> - if any OMAP2+ driver will have two states defined: "idle" and "sleep"
>> - and if it will try to manage them from drivers callbacks only using
>>    pure calls to pinctrl_pm_select_xx() helpers
>>
>> the "idle" state will be selected during suspend and *not* "sleep".
>
> But the drivers have separate calls for runtime PM and suspend/resume?

Yes, but for OMAP2+ everything is handled by OMAP device framework :)

>
>>> It is possible that am33xx needs separate idle and sleep states, but
>>> most likely only for some pins. For omap[345] we can get away with
>>> just the default state for most cases.
>>>
>>
>>
>> In case, if only "default" state is defined for device - nothing will
>>   be done by OMAP device framework for it (I mean any call to
>> pinctrl_pm_select_xx() will do nothing - it just checks that there is
>> no state and returns 0).
>
> If we want to automate something, it should be done at Linux generic
> level rather than at omap "bus" level. That sort of relates to drivers
> needing to know when they've lost context too, which should be
> implemented in Linux generic way.
>
> Regards,
>
> Tony
>
