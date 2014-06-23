From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] regulator: palmas: Fix SMPS enable/disable/is_enabled
Date: Mon, 23 Jun 2014 14:54:27 -0600
Message-ID: <53A89403.2000206@wwwdotorg.org>
References: <1403285183-15926-1-git-send-email-nm@ti.com>	<53A884EF.100@wwwdotorg.org> <CAGo_u6oMqKBu0PdY915+GHBekbPkSHODwoKafdY-6YcmkLGanA@mail.gmail.com> <53A88BF5.9010603@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A88BF5.9010603@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, acourbot@nvidia.com, gnurou@gmail.com, Keerthy <j-keerthy@ti.com>, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/23/2014 02:20 PM, Stephen Warren wrote:
> On 06/23/2014 02:11 PM, Nishanth Menon wrote:
>> On Mon, Jun 23, 2014 at 2:50 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 06/20/2014 11:26 AM, Nishanth Menon wrote:
>>>> We use regmap regulator ops to enable/disable and check if regulator
>>>> is enabled for various SMPS. However, these depend on valid
>>>> enable_reg, enable_mask and enable_value in regulator descriptor.
>>>>
>>>> Currently we do not populate these for SMPS other than SMPS10, this
>>>> results in spurious results as regmap assumes that the values are
>>>> valid and ends up reading register 0x0 RTC:SECONDS_REG on Palmas
>>>> variants that do have RTC! To fix this, we update proper parameters
>>>> for the descriptor fields.
>>>>
>>>> Further, we want to ensure the behavior consistent with logic
>>>> prior to commit dbabd624d4eec50b6, where, once you do a set_mode,
>>>> enable/disable ensure the logic remains consistent and configures
>>>> Palmas to the configuration that we set with set_mode (since the
>>>> configuration register is common). To do this, we can rely on the
>>>> regulator core's regulator_register behavior where the regulator
>>>> descriptor pointer provided by the regulator driver is stored. (no
>>>> reallocation and copy is done). This lets us update the enable_value
>>>> post registration, to remain consistent with the mode we configure as
>>>> part of set_mode.
>>>>
>>>> Fixes: dbabd624d4eec50b6 ("regulator: palmas: Reemove open coded functions with helper functions")
>>>> Reported-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>
>>> Unfortunately, there is still some lingering problem in the original
>>> commit. In next-20130623 (and indeed since at least next-20140611),
>>> neither the LCD panel or HDMI work on the NVIDIA Dalmore board.
>>> Reverting this commit (just for conflicts) and the original problematic
>>> commit "regulator: palmas: Reemove open coded functions with helper
>>> functions" solves this. I see the following on boot:
>>>
>>>> [    3.558776] tegra-dsi 54300000.dsi: cannot get VDD supply
>>>> [    3.564272] platform 54300000.dsi: Driver tegra-dsi requests probe deferral
>>>> [    3.571990] tegra-hdmi 54280000.hdmi: failed to get PLL regulator
>>>> [    3.578377] platform 54280000.hdmi: Driver tegra-hdmi requests probe deferral
>>>
>>> ... but probe deferral never completes, yet with your "remove open coded
>>> ..." patch reverted, it all works fine.
>>>
>>> Can you please take another look at the original patch?
>>
>> Will let keerthy (original patch author) comment on it.
>>
>> arch/arm/boot/dts/tegra114-dalmore.dts tps65090, avdd_lcd_reg I
>> suppose is the path in question?
>>
>> Seems to use drivers/mfd/tps65090.c and
>> drivers/regulator/tps65090-regulator.c and not palmas?
>>
>> Am I looking at the right dts?
> 
> Yes, that's the right DTS.
> 
> There's both a 65090 and a Palmas on the board. It's probably simpler to
> look at the HDMI PLL regulator, since the path to the Palmas is more
> obvious:
...

I think I found the problem; I sent "[PATCH] regulator: palmas: fix typo
in enable_reg calculation" with what's probably the fix.
