From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [RFC PATCH 0/3] mux framework rework
Date: Thu, 29 Oct 2009 11:46:02 +0200
Message-ID: <4AE9645A.2090809@compulab.co.il>
References: <cover.1256734115.git.mike@compulab.co.il> <20091028165332.GD7180@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:34417 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208AbZJ2JqD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 05:46:03 -0400
In-Reply-To: <20091028165332.GD7180@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org



Tony Lindgren wrote:
> * Mike Rapoport <mike@compulab.co.il> [091028 06:17]:
>> This is an attempt to start rework of the mux framework keeping as
>> much backward compatibility as possible.
>> The patch serie introduces a new mux configuration interface that
>> follows the ideas of PXA MFP implementation ([1] and [2]).
>> The mux configuration interface is implemented for OMAP3 and partially
>> for OMAP2 processors.
>> The OMAP2 implementation is far from being complete. Unfortunately I
>> do not have OMAP2 docs, so I've added only configration for pins
>> defined in omap24xx_pins table.
>>
>> The older opam_cfg_reg interface is still present and can be used to
>> avoid too many broken things in steps 2 & 3 as of Tony's plans ([3]).
> 
> Cool! I too have been working on this for past several days, but luckily
> I've been working on the new mux data layout instead so far with some
> help from Paul and Benoit.
> 
> So this should all come together quite nicely. I'll try to post some
> patches as soon as the new mux data is working. I'll also take a close
> look at your patches, it seems like they already separate the
> mach-omap2 mux code nicely from what's needed for mach-omap1
> (well, at least for 15xx).

I'd be glad to get those patches even before the new mux data is working :)

> The reason I think we need to redo all the mux data is because the new
> setup has several shortcomings:
> 
> - All the mux registers on the newer omaps are in a single register
>   for each signal instead of being scattered across multiple registers
>   like on 15xx. So the enumeration is not needed, and we don't need
>   to specify each signal.
> 
> - We badly need mux register to GPIO mapping for runtime muxing of GPIO
>   pins for the idle modes
> 
> - For debugging, we need to see the pin status if CONFIG_DEBUG_FS
>   is set
> 
> - For adding custom hardware on boards such as Beagle, we need to
>   be able to override pins via /debugfs or via cmdline
> 
> - Grepping the code for the signal + ball + mux register combination
>   is currently impossible

Is it really necessary to have ball information? OMAP35x packages differ, so
having ball information may be misleading.

> So I suggest we get rid of defining each mux mode separately, and
> just define the register offsets from the mux base.
> 
> Then for the new omap_set_mux(), we should pass the register offset,
> the desired value, and optional flags.
> 
> For the new mux data, I currently have something like the below just
> to give an idea what I was thinking, maybe take a quick look at
> that and see how that fits into what you had in mind?
> 
> arch/arm/mach-omap2/mux.h:
> 
> /**
>  * struct omap_mux - data for omap mux register offset and it's value
>  * @reg_offset:	mux register offset from the mux base
>  * @gpio:	GPIO number
>  * @muxnames:	available signal modes for a ball
>  */
> struct omap_mux {
> 	u16	reg_offset;
> 	u16	gpio;
> #ifdef CONFIG_DEBUG_FS
> 	char	*muxnames[8];
> 	char	*balls[2];

Again, I do not quite understand what do we need the ball names for?

> #endif
> };
> ...
> 
> arch/arm/mach-omap2/mux34xx.h:
> 
> #ifdef CONFIG_DEBUG_FS
> 
> #define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> {									\
> 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> 	.gpio		= (g),						\
> 	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
> }
> 
> #else
> 
> #define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> {									\
> 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> 	.gpio		= (g),						\
> }
> 
> #endif
> 
> /* 
>  * OMAP3 CONTROL_PADCONF* register offsets for pin-muxing
>  *
>  * Extracted from the TRM.  Add 0x48002030 to these values to get the
>  * absolute addresses.  The name in the macro is the mode-0 name of
>  * the pin.  NOTE: These registers are 16-bits wide.
>  */ 
> #define OMAP3_CONTROL_PADCONF_SDRC_D0_OFFSET			0x000
> #define OMAP3_CONTROL_PADCONF_SDRC_D1_OFFSET			0x002
> #define OMAP3_CONTROL_PADCONF_SDRC_D2_OFFSET			0x004
> #define OMAP3_CONTROL_PADCONF_SDRC_D3_OFFSET			0x006
> #define OMAP3_CONTROL_PADCONF_SDRC_D4_OFFSET			0x008
> ...
> 
> /*
>  * Superset of all mux modes, same as the CBC package
>  */
> struct omap_mux omap3_muxmodes[] = {
> 	_OMAP3_MUXENTRY(CAM_D0, 99,
> 		"cam_d0", NULL, NULL, NULL,
> 		"gpio_99", NULL, NULL, "safe_mode"),
[ snip ]
> ...
> 	{ .reg_offset = OMAP_MUX_TERMINATOR },
> };
> ...
>
> 
> And this is what I was thinking for the new mux function:
> 
> int omap_set_mux(u16 val, u16 offset, int flags);

I have slightly different approach in mind. My idea was to have a table that
provides some mapping between pin and it's PADCONF offset. That table
initialization is CPU variant specific, so mapping for OMAP24XX will be
different from the mapping for OMAP2430 and OMAP35x. The mapping table is
indexed with enumeration that lists all configurable pins for all processor and
package variants.
Next, there are macros that encode the index and PADCONF value for each possible
pin configuration into u32, e.g.

#define OMAP3_CAM_D0		OMAP3_PIN(CAM_D0, MODE0)
#define OMAP3_CAM_D0_CSI2_DX2	OMAP3_PIN(CAM_D0, MODE2)
#define OMAP3_CAM_D0_GPIO_99	OMAP3_PIN(CAM_D0, MODE4)

And omap_cfg_pin (my name for omap_cfg_mux) takes the encoded mux configuration,
extracts from there the index into the mapping table and PADCONF value and
updates the PADCONF register.

My approach allows reusing the same code for setting mux configuration for OMAP2
 and OMAP3 (and probably OMAP4), and , apparently would use less memory that
your proposal. Another advantage of using encoded mux configuration is a
simplification of board-specific code. You can use an array with all pins
configured there and pass this array to, say, omap_cfg_pins:

unsigned long board_pins[] = {
	OMAP3_CAM_D0_GPIO_99,
	OMAP3_GPMC_WAIT3_GPIO_65,

	OMAP3_MCBSP2_FSX,
	OMAP3_MCBSP2_CLKX,
	OMAP3_MCBSP2_DR,
	OMAP3_MCBSP2_DX,
...
};

static void __init some_board_init(void)
{
...
	omap_cfg_pins(board_pins, ARRAY_SIZE(board_pins));
...
}

The drawbacks of using encoded mux configuration are
- limit maximal number of configurable pins by bitfield size in the encoding
- absence of pin <-> gpio mapping
- absence of nice debug strings :)

So, if you think that large "struct omap_mux omap_xxx_muxmodes" tables are
acceptable, I'd propose to go with "struct omap_mux" as you described it and add
some macros to allow simple interface for board-* files like the one above.

> And then also have a function to initialize a whole struct omap_mux
> array from each board-*.c files.
> 
> Regards,
> 
> Tony
> 
> 
>  
>> [1] Documentation/arm/pxa/mfp.txt
>> [2] http://elinux.org/OMAP_wishlist#References
>> [3] http://elinux.org/OMAP_wishlist#Initial_plans_.28from_Tony.2C_for_next_merge_window.29
>>
>> Changes since commit 0bbf5337f2f2957775051a3caf60b66d3306c815
>>   Tony Lindgren
>>   	Fix compile for 1510 innovator
>>
>> Mike Rapoport (3):
>>   omap2: mux: intoduce omap_mux_{read,write}
>>   omap: mux: add interface for encoded mux configration
>>   omap2: mux: implement encoded mux configuration
>>
>>  arch/arm/mach-omap2/include/mach/mux.h     |  452 +++++++++++++++
>>  arch/arm/mach-omap2/include/mach/mux24xx.h |  128 ++++
>>  arch/arm/mach-omap2/include/mach/mux34xx.h |  862 ++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/mux.c                  |  158 +++++-
>>  arch/arm/plat-omap/include/plat/mux.h      |   62 +--
>>  arch/arm/plat-omap/mux.c                   |   17 +
>>  6 files changed, 1614 insertions(+), 65 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/include/mach/mux.h
>>  create mode 100644 arch/arm/mach-omap2/include/mach/mux24xx.h
>>  create mode 100644 arch/arm/mach-omap2/include/mach/mux34xx.h
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Sincerely yours,
Mike.

