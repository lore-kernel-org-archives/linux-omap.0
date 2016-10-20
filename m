From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM-OMAP2+: Fine-tuning for five function
 implementations
Date: Thu, 20 Oct 2016 06:13:44 -0700
Message-ID: <20161020131344.ibixaniopemiumvm@atomide.com>
References: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* SF Markus Elfring <elfring@users.sourceforge.net> [161015 13:51]:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 15 Oct 2016 22:44:22 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (3):
>   mux: Replace three seq_printf() calls by seq_puts()
>   mux: Use seq_putc() in omap_mux_dbg_signal_show()
>   pm-debug: Use seq_putc() in two functions

Thanks will be applying for v4.10 merge window. FYI, chances
are that arch/arm/mach-map2/mux.c will get dropped for v4.10
unless we run into regressions.

Regards,

Tony
