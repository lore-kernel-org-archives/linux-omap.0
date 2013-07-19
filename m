From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Fri, 19 Jul 2013 13:29:42 +0300
Message-ID: <51E91516.2040301@ti.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost> <51E70B5D.6030802@wwwdotorg.org>
 <20130718073638.GP7656@atomide.com> <51E84180.6080902@wwwdotorg.org>
 <20130719073957.GZ7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130719073957.GZ7656@atomide.com>
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
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony, Stephen

On 07/19/2013 10:39 AM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [130718 12:33]:
>> On 07/18/2013 01:36 AM, Tony Lindgren wrote:
>>> * Stephen Warren <swarren@wwwdotorg.org> [130717 14:30]:
>>>> On 07/16/2013 03:05 AM, Tony Lindgren wrote:
>> ...
>>>> Why shouldn't e.g. a pinctrl-based I2C mux also be able to do runtime
>>>> PM? Does the mux setting select which states are used for runtime PM, or
>>>> does runtime PM override the basic mux setting, or must the pincrl-I2C
>>>> mux manually implement custom runtime-PM/pinctrl interaction since
>>>> there's no generic answer to those questions? How many more custom
>>>> exceptions will there be?
>>>
>>> The idea is that runtime PM will never touch the basic mux settings
>>> at all. The "default" state should be considered a static state
>>> that is claimed during driver probe, and released when the driver
>>> is unloaded. This is typically let's say 90% of the pins for any
>>> device.
>>>
>>> For runtime PM, we can just toggle the PM related pinctrl states as
>>> they have been verified to match the active state during init.
>>>
>>> So I don't see why pinctrl-I2C would have to do anything specific.
>>> All that is required is that the pins are grouped for the consumer
>>> driver, and we can provide some automated checks on the states for
>>> runtime PM.
>>
>> So, consider a pinctrl-based I2C mux. It has 2 states to cover two I2C
>> buses:
>>
>> a) bus 1: I2C controller is muxed out onto one set of pins.
>>
>> b) bus 2: I2C controller is muxed out onto another set of pins.
>>
>> Now, the system could go idle in either of those 2 states, and then
>> later need to return to one of those states. I just don't see how that
>> would work, since the runtime PM code in this series switches to *an*
>> active state when the device becomes non-idle. If the definition of the
>> idle state switches the mux function for both sets of pins to some
>> idle/quiescent value, then you'd need to do different reprogramming when
>> going back to "the" active state; I guess the system would need to
>> remember which state was active before switching to idle, then switch
>> back to that same state rather than hard-coding the active state name as
>> "active"...
>
> I think the only sane way to deal with this is to make the I2C controller
> to show up as two separate I2C controller instances. Then use runtime
> PM to save and restore the state for each instance, and locking between
> the two driver instances.
>
> For the pin muxing part, I'd do this:
>
> 			i2c1 instance	i2c2 instance	notes
> default_state		0 pins		0 pins		(or dedicated pins only)
> active_state		all pins	alls pins
> idle_state		safe mode	safe mode
>
> Then when i2c1 instance is done, it's runtime PM suspend muxes the pins
> to safe mode, or some nop state. Then when i2c2 instance is woken, it's
> runtime PM resume muxes pins to i2c2.

First of all, I'd like to mention that these patches do *not* connect
pinctrl to PM runtime, so until driver will call pinctrl_select_state()
or pinctrl_pm_select_*() there will be no pins state changes.
(As result, i2c-mux is not good example, seems:))

And I think, some sort of summary need to be done to explain how system 
will behave after these patches in comparison to how it was before:

1) Device has pins states defined and driver uses pinctrl_select_state
(lets say legacy mode):
- "default" - no changes
- "default"+"idle"/"sleep" - no changes
- "default" + any other states - no chages
- "default"+"active" + "idle"/"sleep" - behavior will be *changed*
   pinctrl_bind_pins() will do:
   a) pinctrl_select_state("default")
   b) pinctrl_select_dynamic("active")
   but, driver uses pinctrl_select_state() to change pins state during
its work -- Is it ok?

2) Device has pins states defined and driver uses pinctrl_pm_select_*() 
API only:
- if no "active" defined - behavior will be the same as for legacy mode
- "default"+"active" + "idle"/"sleep" - will behave as explained in doc

3)  Device has pins states defined and driver uses
pinctrl_pm_select_*() API and pinctrl_select_state() simultaneously:
- if no "active" defined - behavior will be the same as for legacy mode
- "default"+"active" + "idle"/"sleep" + "stateX"
   How it will work if during suspend driver will do:??
   if (conditionY)
         pinctrl_select_state(stateX);
   pinctrl_pm_select_sleep_state("sleep")
Is it valid?

   How it will work if during runtime resuming driver will do:??
   if (conditionY)
         pinctrl_select_state(stateX);
   pinctrl_pm_select_active_state("active");
Is it valid?

Any way, if driver don't want support introduced default/common behavior 
- all it need is to not define "active" state.

Uh, hope it will be useful and I have correct understandings here :)

>
> Regards,
>
> Tony

Regards,
- grygorii
