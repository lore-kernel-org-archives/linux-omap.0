From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC 1/8] RFC: CLK: OMAP: Add basic infrastructure for OMAP clocks
Date: Thu, 21 Mar 2013 11:50:51 -0700
Message-ID: <20130321185051.834.97551@quantum>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
 <1363887347-4686-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49526 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab3CUSu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Mar 2013 14:50:57 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so2447881pbc.38
        for <linux-omap@vger.kernel.org>; Thu, 21 Mar 2013 11:50:57 -0700 (PDT)
In-Reply-To: <1363887347-4686-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2013-03-21 10:35:40)
> This patch adds basic infrastructure support for registering clocks
> under common clock framework. This patch is done in preparation for
> moving clock data from arch/arm/mach-omap2/ folder under /drivers/clk/omap.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Thanks for taking a crack at this Tero!  This is a great step towards
getting rid of clk-private.h.

Regarding the long-term roadmap of the omap clock code:

In general all of the changes to the omap clock code for using the
common struct clk have been very incremental.  We still have the old
legacy struct clk definition, the name of that struct was changed to
clk_hw_omap, but it is still a fairly large, monolithic structure.  Are
there plans to break the clock types up into smaller, more focused clock
types?  E.g. get rid of struct dpll_data and have a dedicated dpll clock
type.

The question above is not reason to block this patch since it is a
fairly large refactoring effort, but it is something to consider.

Some comments below.

<snip>

> +struct omap_clk {
> +       u16                             cpu;
> +       const char                      *dev_id;
> +       const char                      *con_id;
> +       struct omap_init_clk            *clk;
> +};
> +
> +#define CLK(dev, con, ck, cp)          \
> +       {                               \
> +               .cpu = cp,              \
> +               .dev_id = dev,          \
> +               .con_id = con,          \
> +               .clk = ck,              \
> +       }       
> +

IS omap_clk and CLK really necessary today?  I thought that the move to
separate clocks out by tables got rid of this macro/structure?

> +#define OMAP_CLK_FIXED_RATE(_name, _flags, _rate, _ignore)     \
> +       static struct omap_init_clk _name __initdata = {        \
> +               .name = #_name,                                 \
> +               .clk_flags = _flags,                            \
> +               .rate = _rate,                                  \
> +               .clk_register = omap_clk_register_fixed_rate,   \
> +       };
> +

These macros are unreadable.  They were originally born out of the nasty
clk-private.h stuff which included forward declarations of struct clk
and all sorts of ugliness.  I know it saves you LoC to use them now but
I really prefer to use designated initializers for the sake of
readability.  Do you plan to convert the OMAP clock code back to how it
was, pre-macros?

Regards,
Mike
