From: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: [PATCHv9 05/43] CLK: TI: add DT alias clock registration mechanism
Date: Tue, 29 Oct 2013 12:50:43 -0500
Message-ID: <CAHCPf3uPhkVhdn3Db06YZfrwQuA7khdZEXiZ+pqJ06J9YdBoLg@mail.gmail.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
	<1382716658-6964-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55610 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407Ab3J2Run (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 13:50:43 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so186570pbc.16
        for <linux-omap@vger.kernel.org>; Tue, 29 Oct 2013 10:50:43 -0700 (PDT)
In-Reply-To: <1382716658-6964-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Tony Lindgren <tony@atomide.com>, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, Mike Turquette <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 25, 2013 at 10:56 AM, Tero Kristo <t-kristo@ti.com> wrote:
> Some devices require their clocks to be available with a specific
> dev-id con-id mapping. With DT, the clocks can be found by default
> only with their name, or alternatively through the device node of
> the consumer. With drivers, that don't support DT fully yet, add
> mechanism to register specific clock names.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

You guys are wonderful, by the way ;)

> +void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
> +{
> +       struct ti_dt_clk *c;
> +       struct device_node *node;
> +       struct clk *clk;
> +       struct of_phandle_args clkspec;
> +
> +       for (c = oclks; c->node_name != NULL; c++) {
> +               node = of_find_node_by_name(NULL, c->node_name);
> +               clkspec.np = node;
> +               clk = of_clk_get_from_provider(&clkspec);
> +
> +               if (!IS_ERR(clk)) {
> +                       c->lk.clk = clk;
> +                       clkdev_add(&c->lk);
> +               } else {
> +                       pr_warn("%s: failed to lookup clock node %s\n",
> +                               __func__, c->node_name);
> +               }
> +       }
> +}

I have one question here, what makes this part of the patch
TI-specific at all except the definition of the structure ti_dt_clk?
Mapping DT clocks to generic clkdev legacy namings seems like it would
be a necessary evil across *all* SoC platforms.

I would say there is a good case for this being generic and used by
all platforms waiting for con->id/dev->id to be moved to DT-awareness,
the structure itself is very generic within clkdev as long as the
drivers conformed anyway (and if they didn't, none of this helps) and
I don't think it really needs to be a TI-only thing. The next thing
that's going to happen when another platform arrives that wants to do
the same thing is duplication or consolidation - so it would probably
be a good idea to make this generic to start.

While there the names could be a bit more descriptive -
dt_clk_name_lookup_map_register(), struct dt_clk_name_lookup_map,
DT_CLK_LOOKUP_MAP() ..? The current namespace makes it look like this
is the absolute correct thing to do under all circumstances, but in
fact this is purely for mapping the old way to the new, better way..
in the event a brand new platform arrives, with all new drivers (or
only compliant drivers), none of this code should be implemented for
it and it should be presented this way.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
