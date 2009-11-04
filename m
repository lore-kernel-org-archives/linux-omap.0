From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
 34xx
Date: Wed, 04 Nov 2009 09:14:22 +0200
Message-ID: <4AF129CE.9080508@compulab.co.il>
References: <20091029203124.11843.89983.stgit@localhost> <20091029203631.11843.1364.stgit@localhost> <4AED6330.8020007@compulab.co.il> <20091102191018.GD6692@atomide.com> <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com> <20091103164324.GE8981@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50488 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZKDHOU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Nov 2009 02:14:20 -0500
In-Reply-To: <20091103164324.GE8981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, linux-omap@vger.kernel.org



Tony Lindgren wrote:
> * Mike Rapoport <mike.rapoport@gmail.com> [091102 23:10]:
>> On Mon, Nov 2, 2009 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
>>>>
>>>> Tony Lindgren wrote:
>>>>> Add new style mux data for 34xx. This should also
>>>>> work with 3630 easily by adding the processor subset
>>>>> and ball data.
>>>>>
>>>>> Note that this data is __initdata, and gets optimized
>>>>> out if CONFIG_OMAP_MUX is not set. Also, the debug data
>>>>> gets optimized out if CONFIG_DEBUG_FS is not set.
>>>>>
>>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>>> ---
>>>>>  arch/arm/mach-omap2/Makefile  |    4
>>>>>  arch/arm/mach-omap2/mux.h     |    2
>>>>>  arch/arm/mach-omap2/mux34xx.c | 1552 +++++++++++++++++++++++++++++++++++++++++
>>>>>  arch/arm/mach-omap2/mux34xx.h |  352 +++++++++
>>>>>  4 files changed, 1910 insertions(+), 0 deletions(-)
>>>>>  create mode 100644 arch/arm/mach-omap2/mux34xx.c
>>>>>  create mode 100644 arch/arm/mach-omap2/mux34xx.h
>>>>>
>> [ snip ]
>>
>>>>> +
>>>>> +#define OMAP3_CONTROL_PADCONF_MUX_SIZE                             \
>>>>> +           (OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
>>>> What about adding defines for each possible mode configuration, except, perhaps,
>>>> GPIO?
>>> Yeah it would be nice to make it easy. How about someting like:
>>>
>>> int __init omap_mux_init_by_name(char *name, int flags);
>>> ...
>>>
>>> omap_mux_init_by_name("i2c1_scl", OMAP_PIN_INPUT_PULLUP);
>>>
>>>> #define OMAP3_PIN_CAM_D0 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE0 | OMAP_PIN_INPUT, 0)
>>>> #define OMAP3_PIN_CAM_D0_CSI2_DX2 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE2 | \
>>>>                                           OMAP_PIN_INPUT, 0)
>>>>
>>>> And, I'm for adding OMAP_MUX_GPIO_{OUT,IN,IN_PU,IN_PD}(x) as well.
>>> And we could have also:
>>>
>>> int __init omap_mux_init_by_gpio(int gpio, int flags);
>>> ...
>>>
>>> omap_mux_init_by_gpio(99, OMAP_PIN_INPUT);
>>>
>>> As the only thing we currently have for flags is the OMAP_MUX_DYNAMIC,
>>> we could mask that too into flags and make it int instead of u16.
>> It seems we are thinking in really different directions :) You propose
>> imporved and easy to use replacements of omap_cfg_reg while I'm aming
>> nice tables descibing board pin configuration like, e.g,
>> cm_x300_mfp_cfg in arch/arm/mach-pxa/cm-x300.c. Probably it's just too
>> hard to me to break my PXA habbits, but I think such tables make the
>> board code easier to write/maintain/understand.
>> Besides, having both simple aliases for OMAP3_MUX(mode0, mux_value,
>> mux_flags) for dedicated pins does not contadict having
>> omap_mux_init_by_{name,gpio} helpers.
> 
> Agreed, we should make the pin muxing as easy as possible as it's
> probably the biggest hurdle to anybody to start making changes to a
> development board. And we should have easy to to read board specific
> pin configuration tables like you're suggesting.
> 
> In the long run, we should probably start using the real signal names
> as they seem to be more future proof across omaps than the register
> names.
> 
> We can easily do something like this if we add char *muxname to
> struct omap_board_mux (untested):
> 
> #define OMAP_MUX_SIGNAL(signal, mux_flags)				\
> {									\
> 	.muxname	= #signal,					\
> 	.flags		= (mux_flags),					\
> }
> 
> #define OMAP_MUX_GPIO(gpio, mux_flags)					\
> {									\
> 	.muxname	= gpio_##signal,				\
> 	.flags		= (mux_flags),					\
> }
> 
> #ifdef CONFIG_OMAP_MUX
> static struct omap_board_mux board_mux[] __initdata = {
> 	OMAP_MUX_SIGNAL(i2c1_scl, OMAP_PIN_INPUT),
> 	OMAP_MUX_GPIO(98, OMAP_PIN_INPUT_PULLUP),
> 	OMAP_MUX_GPIO(99, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_DYNAMIC),
> 	{ .reg_offset = OMAP_MUX_TERMINATOR },
> };
> #endif
> 
> Of course then we have to warn on potential duplicate signal names,
> but those can be specified using the register offset + mode as
> needed.
> 
> Is the above close enough to what you have in mind regarding the
> board specific mux tables, or do you have still something else
> in mind?

It's closer :)
What I have in mind is a simple wrapper macro defining mux configuration for
straightforward cases, just like a bunch of defines in
arch/arm/mach-omap2/include/mach/mux34xx.h in my earlier patch [1].
And just use OMAP_MUX_SIGNAL, or OMAP3_MUX for more complicated cases where
flags and/or OFF mode settings are required.
For instance, for making i2c1_scl to be actually routed to its pin you would have

static struct omap_board_mux board_mux[] __initdata = {
 	OMAP_MUX_I2C1_SCL,
        ...
}

and for dss_pclk to became hw_dbg12 you have

static struct omap_board_mux board_mux[] __initdata = {
	OMAP_MUX_PCLK_HW_DBG12,
        ...
}

Another my point was, that each board-* file will have all the mux settings in
one consolidated place. Indeed, currently there are no many uses of omap_cfg_reg
in the board files, but think of crappy bootloaders that fail to configure half
of the pins or cases when you delibarately want to setup mux configuration in
kernel.

I agree, that having the macros I'm talking about is more or less "syntactic
sugar" and I'm Ok to live without them :)
The most important that we don't need to add enumerated mux setting to
arch/arm/*omap*/mux.[ch] for each pin that was not there and mux setup can
completely defined by the board-* files.


[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/25681

> Regards,
> 
> Tony
> 
> 

-- 
Sincerely yours,
Mike.

