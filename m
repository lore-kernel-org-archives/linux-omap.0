From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Mon, 2 Nov 2009 10:54:53 -0800
Message-ID: <20091102185453.GB6692@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <20091029203619.11843.76412.stgit@localhost>
 <4AED6329.6030302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55063 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbZKBSyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 13:54:54 -0500
Content-Disposition: inline
In-Reply-To: <4AED6329.6030302@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, mike.rapoport@gmail.com

* Mike Rapoport <mike@compulab.co.il> [091101 02:29]:
> 
> 
> Tony Lindgren wrote:
> > Initially only for 34xx. Keep the old code working
> > until the data has been converted to the new style
> > format.
> > 
> > REVISIT: Add support for cmdline parsing
> > REVISIT: Add a function to get mux register by GPIO pin
> > REVISIT: Add a function to set an array of mux entries
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/mux.c |  237 +++++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/mux.h |  125 ++++++++++++++++++++++++
> >  2 files changed, 362 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/mux.h
> > 
> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > index 9841423..45e6d4d 100644
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -27,12 +27,15 @@
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/list.h>
> >  
> >  #include <asm/system.h>
> >  
> >  #include <plat/control.h>
> >  #include <plat/mux.h>
> >  
> > +#include "mux.h"
> 
> Wouldn't <mach/mux.h> be better?

Well I've been thinking that we should limit pin muxing to the board-*.c
and platform_data init files under mach-omap2. Keeping the mux.h header
file under mach-omap2/mux.h would certainly flag any attempts to use it
under drivers/* for example.

The reasons being that if we limit muxing to the files under mach-omap2,
we can safely assume that the mux data and code is mostly __initdata
and __init.

And then we can safely do things like multiplex the pins with the real
signal names without having to keep all the mux data wasting memory
later on.

Comments? I'm OK doing keeping it under mach/mux.h, but I'd like to
establish a policy of doing the muxing only in platform init code
under mach-omap2.

> 
> >  #ifdef CONFIG_OMAP_MUX
> >  
> >  #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
> > @@ -626,6 +629,11 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
> >  #endif
> >  
> >  #ifdef CONFIG_ARCH_OMAP34XX
> > +
> > +/*
> > + * NOTE: This function will disappear soon, please use the new
> > + * omap_mux_set() instead
> > + */
> 
> I think it's worth adding more visible notice, e.g. marking the function
> deprecated or adding a WARN statement to its body.

Agreed. I was thinking about writing a little script to convert the
old mux entries to the new ones, and drop all the old code and data
for omap3 hopefully this week..
 
> >  static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
> >  {
> >  	static DEFINE_SPINLOCK(mux_spin_lock);
> > @@ -644,6 +652,235 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
> >  #define omap34xx_cfg_reg	NULL
> >  #endif
> >  
> > +/*----------------------------------------------------------------------------*/
> > +
> > +#ifdef CONFIG_ARCH_OMAP34XX
> > +
> > +static LIST_HEAD(muxmodes);
> > +static DEFINE_MUTEX(muxmode_mutex);
> > +
> > +/*
> > + * REVISIT: See if pin is set dynamic, and add it to the list
> > + */
> > +int omap_mux_set(u16 val, u16 mux_offset, int flags)
> > +{
> > +	omap_mux_write(val, mux_offset);
> > +
> > +	return 0;
> > +}
> > +
> > +struct omap_mux_entry {
> > +	struct omap_mux		mux;
> > +	struct list_head	node;
> > +};
> > +
> > +static struct omap_mux *omap_mux_list_add(struct omap_mux *src)
> > +{
> > +	struct omap_mux_entry *entry;
> > +	struct omap_mux *m;
> > +
> > +	int i;
> > +
> > +	entry = kzalloc(sizeof(struct omap_mux_entry), GFP_KERNEL);
> > +	if (!entry)
> > +		return NULL;
> > +
> > +	m = &entry->mux;
> > +	memcpy(m, src, sizeof(struct omap_mux_entry));
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
> > +		if (src->muxnames[i]) {
> > +			m->muxnames[i] =
> > +				kzalloc(strlen(src->muxnames[i]) + 1,
> > +					GFP_KERNEL);
> > +			if (!m->muxnames[i])
> > +				goto free_names;
> > +			strcpy(m->muxnames[i], src->muxnames[i]);
> > +		}
> > +	}
> > +	for (i = 0; i < OMAP_MUX_NR_SIDES; i++) {
> > +		if (src->balls[i]) {
> > +			m->balls[i] =
> > +				kzalloc(strlen(src->balls[i]) + 1,
> > +					GFP_KERNEL);
> > +			if (!m->balls[i])
> > +				goto free_balls;
> > +			strcpy(m->balls[i], src->balls[i]);
> > +		}
> > +	}
> > +#endif
> > +
> > +	mutex_lock(&muxmode_mutex);
> > +	list_add(&entry->node, &muxmodes);
> > +	mutex_unlock(&muxmode_mutex);
> > +
> > +	return m;
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +free_balls:
> > +	for (i = 0; i < OMAP_MUX_NR_SIDES; i++)
> > +		if (m->balls[i])
> > +			kfree(m->balls[i]);
> > +free_names:
> > +	for (i = 0; i < OMAP_MUX_NR_MODES; i++)
> > +		if (m->muxnames[i])
> > +			kfree(m->muxnames[i]);
> > +#endif
> > +
> > +	kfree(entry);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void __init omap_mux_apply_subset(struct omap_mux *p,
> > +					struct omap_mux *superset)
> > +{
> 
> I'm not sure it is required.
> 
> Is it for sure that CBC package will remain superset of all possible mux modes
> for all OMAP3 variants through entire OMAP3 lifespan? What about OMAP3630 and
> OMAP3517? Are their packages also subset of the CBC one?

Basically the mux registers are the same for all omap3, then the
packaging determines which signal options are available for the
package.

Looks like 3630 changes the mux name for few entries, and adds some
new registers, so that should be easily covered too.

The superset may not always be named CBC, but we should have one
omap3 superset still.
 
> I'd rather keep the entire tables for different packages/CPU variants. They are
> anyway __initdata, so they would be discarded later during boot. And, keeping
> the full tables rather than differences makes omap_mux_apply_subset and
> unnecessary and omap_mux_apply_pins much simpler.

I agree it would make it a bit simpler. But then we need to patch
multiple data tables if we found errors in the data.

And the signal data is mostly the same for all omap3.
 
> If we keep the full tables instead of diffs we could do something like:
> 
> static struct omap_mux *muxmodes;
> static void __init omap_mux_apply_subset(struct omap_mux *p)
> {
> 	muxmodes = p;
> }

Right, that's the way I had it originally, but the amount of data
duplicated three times so far looked ugly to me :)
 
> > +	while (p->reg_offset !=  OMAP_MUX_TERMINATOR) {
> > +		struct omap_mux *s = superset;
> > +		int found = 0;
> > +
> > +		while (s->reg_offset != OMAP_MUX_TERMINATOR) {
> > +			if (s->reg_offset == p->reg_offset) {
> > +				*s = *p;
> > +				found++;
> > +				break;
> > +			}
> > +			s++;
> > +		}
> > +		if (!found)
> > +			printk(KERN_ERR "mux: Unknown entry offset 0x%x\n",
> > +					p->reg_offset);
> > +		p++;
> > +	}
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +static void __init omap_mux_apply_pins(struct omap_ball *b,
> > +				struct omap_mux *superset)
> > +{
> > +	while (b->reg_offset != OMAP_MUX_TERMINATOR) {
> > +		struct omap_mux *s = superset;
> > +		int found = 0;
> > +
> > +		while (s->reg_offset != OMAP_MUX_TERMINATOR) {
> > +			if (s->reg_offset == b->reg_offset) {
> > +				s->balls[0] = b->balls[0];
> > +				s->balls[1] = b->balls[1];
> > +				found++;
> > +				break;
> > +			}
> 
> Again, if we keep the full tables instead of diffs we don't need the nested
> loop. Provided that balls table has pins in the same order as the mux table we
> could have only the assignments here.

The difference with the balls compared to signals is that they are different
for each package. (Just to recap, the naming is a matrix of the pins
where the coordinates are alphabets in one direction, and number
in the other direction).

So the pin data is really separate data from the mux register and
signal data.

Mux registers and signal names are mostly the same for each omap3,
while the ball names are renamed for each package option.
 
> > +			s++;
> > +		}
> > +		if (!found)
> > +			printk(KERN_ERR "mux: Unknown ball offset 0x%x\n",
> > +					b->reg_offset);
> > +		b++;
> > +	}
> > +}
> > +
> > +#else	/* CONFIG_DEBUG_FS */
> > +
> > +static inline void omap_mux_apply_pins(struct omap_ball *b,
> > +					struct omap_mux *superset)
> > +{
> > +}
> > +
> > +#endif	/* CONFIG_DEBUG_FS */
> > +
> > +static void __init omap_mux_set_board(struct omap_board_mux *board)
> > +{
> > +	while (board->reg_offset !=  OMAP_MUX_TERMINATOR) {
> > +		omap_mux_write(board->value, board->reg_offset);
> > +		board++;
> > +	}
> > +}
> > +
> > +static void __init omap_mux_init_dynamic(struct omap_board_mux *board_subset,
> > +					struct omap_mux *superset,
> > +					int flags)
> > +{
> > +	struct omap_mux *s = superset;
> > +	int always_dynamic = flags & OMAP_MUX_ALL_DYNAMIC;
> > +
> > +	while (s->reg_offset !=  OMAP_MUX_TERMINATOR) {
> > +		struct omap_mux *entry;
> > +
> > +		if (!always_dynamic) {
> > +			u16 mode;
> > +
> > +			/* GPIO pins must be always dynamic for PM */
> > +			mode = omap_mux_read(s->reg_offset) & 0x7;
> > +			if (mode != OMAP_MUX_MODE4)
> > +				continue;
> > +		}
> > +
> > +		entry = omap_mux_list_add(s);
> > +		if (!entry) {
> > +			printk(KERN_ERR "mux: Could not add entry\n");
> > +			return;
> > +		}
> > +		s++;
> > +	}
> > +
> > +	if (always_dynamic)
> > +		return;
> > +
> > +	/* Search for pins set as dynamic in the board-*.c file */
> > +	while (board_subset->reg_offset !=  OMAP_MUX_TERMINATOR) {
> > +
> > +		/* GPIO pins are always dynamic, and already handled */
> > +		if ((board_subset->value & 0x7) == OMAP_MUX_MODE4)
> > +			continue;
> > +
> > +		if (!(board_subset->flags & OMAP_MUX_DYNAMIC))
> > +			continue;
> > +
> > +		s = superset;
> > +		while (s->reg_offset !=  OMAP_MUX_TERMINATOR) {
> > +			if (s->reg_offset == board_subset->reg_offset) {
> > +				struct omap_mux *entry = omap_mux_list_add(s);
> > +				if (!entry) {
> > +					printk(KERN_ERR "mux: Could not add "
> > +						"board entry\n");
> > +					return;
> > +				}
> > +			}
> > +			s++;
> > +		}
> > +		board_subset++;
> > +	}
> > +}
> > +
> > +/*
> > + * Do not call this from board-*.c files, use omap3_mux_init() instead
> > + */
> > +int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
> > +				struct omap_mux *superset,
> > +				struct omap_mux *package_subset,
> > +				struct omap_board_mux *board_subset,
> > +				struct omap_ball *package_balls,
> > +				int flags)
> > +{
> > +	/*
> > +	 * REVISIT: Do the ioremap with mux_pbase here once after the old
> > +	 * code is gone
> > +	 * REVISIT: Do not initialize again if already called
> > +	 */
> > +
> > +	omap_mux_apply_subset(package_subset, superset);
> > +	omap_mux_apply_pins(package_balls, superset);
> > +	omap_mux_set_board(board_subset);
> > +	omap_mux_init_dynamic(board_subset, superset, flags);
> 
> With full tables for each package we won't need superset here.

Right, but the maintenance will be more of a pain because of
the duplicate data. And we still need to copy the __initdata to
the list for the configured entries.
 
> > +
> > +	return 0;
> > +}
> > +
> > +#endif
> > +
> > +/*----------------------------------------------------------------------------*/
> > +
> >  int __init omap2_mux_init(void)
> >  {
> >  	u32 mux_pbase;
> > diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> > new file mode 100644
> > index 0000000..a8453f5
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/mux.h
> 
> Wouldn't arch/arm/mach-omap2/include/mach/mux.h be better?

Unless we want to limit the usage of the code to board-*.c files,
and not allow using it elsewhere. But I'm OK either way.
 
> > @@ -0,0 +1,125 @@
> > +/*
> > + * Copyright (C) 2009 Nokia
> > + * Copyright (C) 2009 Texas Instruments
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define OMAP_MUX_TERMINATOR	0xffff
> > +
> > +/* 34xx mux mode options for each pin. See TRM for options */
> > +#define OMAP_MUX_MODE0      0
> > +#define OMAP_MUX_MODE1      1
> > +#define OMAP_MUX_MODE2      2
> > +#define OMAP_MUX_MODE3      3
> > +#define OMAP_MUX_MODE4      4
> > +#define OMAP_MUX_MODE5      5
> > +#define OMAP_MUX_MODE6      6
> > +#define OMAP_MUX_MODE7      7
> > +
> > +/* 24xx/34xx mux bit defines */
> > +#define OMAP_PULL_ENA			(1 << 3)
> > +#define OMAP_PULL_UP			(1 << 4)
> > +#define OMAP_ALTELECTRICALSEL		(1 << 5)
> > +
> > +/* 34xx specific mux bit defines */
> > +#define OMAP_INPUT_EN			(1 << 8)
> > +#define OMAP_OFF_EN			(1 << 9)
> > +#define OMAP_OFFOUT_EN			(1 << 10)
> > +#define OMAP_OFFOUT_VAL			(1 << 11)
> > +#define OMAP_OFF_PULL_EN		(1 << 12)
> > +#define OMAP_OFF_PULL_UP		(1 << 13)
> > +#define OMAP_WAKEUP_EN			(1 << 14)
> > +
> > +/* Active pin states */
> > +#define OMAP_PIN_OUTPUT			0
> > +#define OMAP_PIN_INPUT			OMAP_INPUT_EN
> > +#define OMAP_PIN_INPUT_PULLUP		(OMAP_PULL_ENA | OMAP_INPUT_EN \
> > +						| OMAP_PULL_UP)
> > +#define OMAP_PIN_INPUT_PULLDOWN		(OMAP_PULL_ENA | OMAP_INPUT_EN)
> > +
> > +/* Off mode states */
> > +#define OMAP_PIN_OFF_NONE		0
> > +#define OMAP_PIN_OFF_OUTPUT_HIGH	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
> > +						| OMAP_OFFOUT_VAL)
> > +#define OMAP_PIN_OFF_OUTPUT_LOW		(OMAP_OFF_EN | OMAP_OFFOUT_EN)
> > +#define OMAP_PIN_OFF_INPUT_PULLUP	(OMAP_OFF_EN | OMAP_OFF_PULL_EN \
> > +						| OMAP_OFF_PULL_UP)
> > +#define OMAP_PIN_OFF_INPUT_PULLDOWN	(OMAP_OFF_EN | OMAP_OFF_PULL_EN)
> > +#define OMAP_PIN_OFF_WAKEUPENABLE	OMAP_WAKEUP_EN
> > +
> > +/* Flags for struct omap_board_mux */
> > +#define OMAP_MUX_DYNAMIC		(1 << 0)	/* Keep mux in memory */
> > +
> > +/* Flags for omap_mux_init */
> > +#define OMAP_MUX_ALL_DYNAMIC		(1 << 16)	/* Always in memory */
> > +#define OMAP_PACKAGE_MASK		0xffff
> > +#define OMAP_PACKAGE_CUS		3		/* 423-pin 0.65 */
> > +#define OMAP_PACKAGE_CBB		2		/* 515-pin 0.40 0.50 */
> > +#define OMAP_PACKAGE_CBC		1		/* 515-pin 0.50 0.65 */
> > +
> > +
> > +#define OMAP_MUX_NR_MODES	8			/* Available modes */
> > +#define OMAP_MUX_NR_SIDES	2			/* Bottom & top */
> > +
> > +/**
> > + * struct omap_mux - data for omap mux register offset and it's value
> > + * @reg_offset:	mux register offset from the mux base
> > + * @gpio:	GPIO number
> > + * @muxnames:	available signal modes for a ball
> > + */
> > +struct omap_mux {
> > +	u16	reg_offset;
> > +	u16	gpio;
> > +#ifdef CONFIG_DEBUG_FS
> > +	char	*muxnames[OMAP_MUX_NR_MODES];
> > +	char	*balls[OMAP_MUX_NR_SIDES];
> > +#endif
> > +};
> > +
> > +/**
> > + * struct omap_ball - data for balls on omap package
> > + * @reg_offset:	mux register offset from the mux base
> > + * @balls:	available balls on the package
> > + */
> > +struct omap_ball {
> > +	u16	reg_offset;
> > +	char	*balls[OMAP_MUX_NR_SIDES];
> > +};
> > +
> > +/**
> > + * struct omap_board_mux - data for initializing mux registers
> > + * @reg_offset:	mux register offset from the mux base
> > + * @mux_value:	desired mux value to set
> > + * @flags:	extra flags
> > + */
> > +struct omap_board_mux {
> > +	u16	reg_offset;
> > +	u16	value;
> > +	u32	flags;
> > +};
> > +
> > +#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP34XX)
> > +
> > +int omap3_mux_init(struct omap_board_mux *board_mux_config, int flags);
> > +int omap_mux_init(u32 mux_pbase, u32 mux_size,
> > +				struct omap_mux *superset,
> > +				struct omap_mux *package_subset,
> > +				struct omap_board_mux *board_subset,
> > +				struct omap_ball *package_balls,
> > +				int flags);
> > +int omap_mux_set(u16 val, u16 mux_offset, int flags);
> > +
> > +#else
> > +
> > +static inline int omap3_mux_init(struct omap_board_mux *board_mux_config,
> > +	int flags)
> > +{
> > +}
> > +static inline int omap_mux_set(u16 val, u16 mux_offset, int flags)
> > +{
> > +}
> > +
> > +#endif
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
> 
> 
