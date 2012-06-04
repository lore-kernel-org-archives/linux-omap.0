From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 05/24] ARM: omap: clk: Nuke plat clock.c & clock.h if CONFIG_COMMON_CLK
Date: Mon, 4 Jun 2012 09:25:55 -0500
Message-ID: <4FCCC573.8060806@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com> <1338552485-31325-6-git-send-email-rnayak@ti.com> <4FCCBECA.6010905@ti.com> <4FCCC327.7070100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab2FDO0A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 10:26:00 -0400
In-Reply-To: <4FCCC327.7070100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 06/04/2012 09:16 AM, Rajendra Nayak wrote:
> 
>>> +/* struct clksel_rate.flags possibilities */
>>> +#define RATE_IN_242X        (1<<  0)
>>> +#define RATE_IN_243X        (1<<  1)
>>> +#define RATE_IN_3430ES1        (1<<  2)    /* 3430ES1 rates only */
>>> +#define RATE_IN_3430ES2PLUS    (1<<  3)    /* 3430 ES>= 2 rates only */
>>> +#define RATE_IN_36XX        (1<<  4)
>>> +#define RATE_IN_4430        (1<<  5)
>>> +#define RATE_IN_TI816X        (1<<  6)
>>> +#define RATE_IN_4460        (1<<  7)
>>> +#define RATE_IN_AM33XX        (1<<  8)
>>> +#define RATE_IN_TI814X        (1<<  9)
>>> +
>>> +#define RATE_IN_24XX        (RATE_IN_242X | RATE_IN_243X)
>>> +#define RATE_IN_34XX        (RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
>>> +#define RATE_IN_3XXX        (RATE_IN_34XX | RATE_IN_36XX)
>>> +#define RATE_IN_44XX        (RATE_IN_4430 | RATE_IN_4460)
>>> +
>>> +/* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES>=2, and all
>>> 36xx/37xx */
>>> +#define RATE_IN_3430ES2PLUS_36XX    (RATE_IN_3430ES2PLUS |
>>> RATE_IN_36XX)
>>> +
>>> +/* Platform flags for the clkdev-OMAP integration code */
>>> +#define CK_242X        (1<<  4)
>>> +#define CK_243X        (1<<  5)        /* 243x, 253x */
>>> +#define CK_3430ES1    (1<<  6)        /* 34xxES1 only */
>>> +#define CK_3430ES2PLUS    (1<<  7)        /* 34xxES2, ES3,
>>> non-Sitara 35xx only */
>>> +#define CK_3505        (1<<  8)
>>> +#define CK_3517        (1<<  9)
>>> +#define CK_36XX        (1<<  10)       /* 36xx/37xx-specific clocks */
>>> +#define CK_443X        (1<<  11)
>>> +#define CK_TI816X    (1<<  12)
>>> +#define CK_446X        (1<<  13)
>>> +
>>> +#define CK_34XX        (CK_3430ES1 | CK_3430ES2PLUS)
>>> +#define CK_AM35XX    (CK_3505 | CK_3517)     /* all Sitara AM35xx */
>>> +#define CK_3XXX        (CK_34XX | CK_AM35XX | CK_36XX)
>>
>> I am not sure why we should duplicate these defines in an OMAP2 specific
>> header. What not just leave in plat clock.h where we have all the
>> RATE_IN_xxx and CK_xxx for all OMAP devices?
> 
> These get removed from the file which is used for OMAP1 in a later
> patch. Like I said the idea was to separate out whats needed for OMAP1
> (using legacy struct clk) and OMAP2+ (using common struct clk) with
> both headers residing in respective mach-omap folders. (The RFC I posted
> still had the OMAP1 file in plat-omap)

But these definitions are unrelated to whether you use common clock or
legacy. So why move them?

>>
>>> +/**
>>> + * struct clksel_rate - register bitfield values corresponding to
>>> clk divisors
>>> + * @val: register bitfield value (shifted to bit 0)
>>> + * @div: clock divisor corresponding to @val
>>> + * @flags: (see "struct clksel_rate.flags possibilities" above)
>>> + *
>>> + * @val should match the value of a read from struct clk.clksel_reg
>>> + * AND'ed with struct clk.clksel_mask, shifted right to bit 0.
>>> + *
>>> + * @div is the divisor that should be applied to the parent clock's
>>> rate
>>> + * to produce the current clock's rate.
>>> + */
>>> +struct clksel_rate {
>>> +    u32    val;
>>> +    u8    div;
>>> +    u8    flags;
>>> +};
>>> +
>>> +/**
>>> + * struct clksel - available parent clocks, and a pointer to their
>>> divisors
>>> + * @parent: struct clk * to a possible parent clock
>>> + * @rates: available divisors for this parent clock
>>> + *
>>> + * A struct clksel is always associated with one or more struct clks
>>> + * and one or more struct clksel_rates.
>>> + */
>>> +struct clksel {
>>> +    struct clk            *parent;
>>> +    const struct clksel_rate    *rates;
>>> +};
>>
>> These above clksel structures would be need for omap1 devices so that we
>> could use the clock framework to set the parent clock. So why not keep
>> in plat clock.h?
> 
> We could, but that alone wouldn't be enough if we move OMAP2+ alone to
> common clk, it would mean we duplicate the clksel handling code too,
> and if we do that, maybe its not that bad to just duplicate a couple
> more struct definitions.

So I have tested the legacy clksel code on omap1 and it works. So I
would hope that the common clock version of clksel would work too for
omap1 (if we move omap1 to the common clock framework).

>>> +
>>> +struct clk_hw_omap_ops;
>>> +
>>> +struct clk_hw_omap {
>>> +    struct clk_hw        hw;
>>> +    struct list_head    node;
>>> +    unsigned long        fixed_rate;
>>> +    u8            fixed_div;
>>> +    void __iomem        *enable_reg;
>>> +    u8            enable_bit;
>>> +    u8            flags;
>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>> +    void __iomem        *clksel_reg;
>>> +    u32            clksel_mask;
>>> +    const struct clksel    *clksel;
>>> +    struct dpll_data    *dpll_data;
>>> +    const char        *clkdm_name;
>>> +    struct clockdomain    *clkdm;
>>> +#else
>>> +    u8            rate_offset;
>>> +    u8            src_offset;
>>> +#endif
>>> +    const struct clk_hw_omap_ops    *ops;
>>> +};
>>> +
>>> +struct clk_hw_omap_ops {
>>> +    void            (*find_idlest)(struct clk_hw_omap *oclk,
>>> +                    void __iomem **idlest_reg,
>>> +                    u8 *idlest_bit, u8 *idlest_val);
>>> +    void            (*find_companion)(struct clk_hw_omap *oclk,
>>> +                    void __iomem **other_reg,
>>> +                    u8 *other_bit);
>>> +    void            (*allow_idle)(struct clk_hw_omap *oclk);
>>> +    void            (*deny_idle)(struct clk_hw_omap *oclk);
>>> +};
>>
>> The above clk_hw_xxx would also be needed for omap1 too, right?
> 
> Yes, when OMAP1 moves to common clk *and* if we find enough
> commonalities in clk_hw_xxxx accross OMAP1 and OMAP2+.
> Else it would make sense to keep them in separate mach folders.

I guess I was hoping that these would be put somewhere in plat-omap, may
be cclock.h so that the intent would be so that omap1 could use them. By
putting them in mach-omap2, then if we find that omap1 can use them we
are going to need to move them.

Moving all this into mach-omap2, appears to be going the other direction
I was expecting. In other words, really separating omap1 and omap2 code.
I was hoping we could consolidate it more.

Cheers
Jon
