From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/5] arch/arm/mach-omap2/smartreflex.c: add missing error-handling code
Date: Tue, 05 Jul 2011 10:51:13 -0700
Message-ID: <87tyb0sjji.fsf@ti.com>
References: <1309788705-22278-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309788705-22278-3-git-send-email-julia@diku.dk> (Julia Lawall's
	message of "Mon, 4 Jul 2011 16:11:43 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Tony Lindgren <tony@atomide.com>, kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Julia Lawall <julia@diku.dk> writes:

> From: Julia Lawall <julia@diku.dk>
>
> At this point, the ioremap has taken place, so the error handling code at
> the label err_iounmap should be used rather than returning directly.
>
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r@
> identifier x;
> @@
>
> kfree(x)
>
> @@
> identifier r.x;
> expression E1!=0,E2,E3,E4;
> statement S;
> @@
>
> (
> if (<+...x...+>) S
> |
> if (...) { ... when != kfree(x)
>                when != if (...) { ... kfree(x); ... }
>                when != x = E3
> * return E1;
> }
> ... when != x = E2
> if (...) { ... when != x = E4
>  kfree(x); ... return ...; }
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, can you add this to devel-fixes?

Kevin
