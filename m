From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5 1/6] clk: OMAP: introduce device tree binding to
 kernel clock data
Date: Thu, 16 May 2013 10:43:56 -0700
Message-ID: <20130516174355.GB5600@atomide.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
 <1368039976-29648-2-git-send-email-nm@ti.com>
 <20130513235119.10068.47040@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130513235119.10068.47040@quantum>
Sender: linux-doc-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Mike Turquette <mturquette@linaro.org> [130513 16:56]:
> Quoting Nishanth Menon (2013-05-08 12:06:11)
> <snip>
> > Overall strategy introduced here is simple: a clock node described in
> > device tree blob is used to identify the exact clock provided in the
> > SoC specific data. This is then linked back using of_clk_add_provider
> > to the device node to be accessible by of_clk_get.
> > 
> 
> FYI, I'm working on moving the OMAP clocks over to DT which is a better
> alternative than this patch.  I'll share what I have on the list,
> hopefully next week.

That's good news! What's your plan on using the indexing the clocks?

I'd rather avoid indexing as that's basically same as the old IRQ
numbering and GPIO numbering schemes that don't work well in the long
term.

We already have quite a few sets of clocks for omaps, so the indexing
is already an issue. My thinking is that indexing should only be used
if the same physical clock has multiple outputs.

Regards,

Tony
