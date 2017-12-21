From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [GIT PULL] drop omap3 legacy clock data
Date: Thu, 21 Dec 2017 09:02:42 -0800
Message-ID: <CAEG3pNCJ_Qn-OUVhL8pzAgka9UJzFEqL9sQR1MvfveJ+ycOwTg@mail.gmail.com>
References: <20171221155015.GV3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171221155015.GV3875@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk <linux-clk@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thu, Dec 21, 2017 at 7:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit ffb009b24388b896d9ca8b54e39a879302142518:
>
>   clk: ti: convert retry_init param to use void data type (2017-12-01 15:16:24 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/clk-omap3-legacy-signed
>
> for you to fetch changes up to 7558562a70fbd6b3fa746fa33c76c9333aa0bb32:
>
>   clk: ti: Drop legacy clk-3xxx-legacy code (2017-12-14 08:32:06 -0800)

Pulled into clk-omap.

Regards,
Mike

>
> ----------------------------------------------------------------
> Drop unused omap3 clock data
>
> We have been booting omap3 in device tree only mode for a while now,
> so this is all unused now.
>
> ----------------------------------------------------------------
> Tony Lindgren (1):
>       clk: ti: Drop legacy clk-3xxx-legacy code
>
>  drivers/clk/ti/Makefile          |    4 -
>  drivers/clk/ti/clk-3xxx-legacy.c | 4656 --------------------------------------
>  drivers/clk/ti/clk.c             |  135 --
>  drivers/clk/ti/clock.h           |   68 -
>  drivers/clk/ti/composite.c       |   45 -
>  drivers/clk/ti/dpll.c            |   90 -
>  drivers/clk/ti/gate.c            |   48 -
>  drivers/clk/ti/interface.c       |   32 -
>  8 files changed, 5078 deletions(-)
>  delete mode 100644 drivers/clk/ti/clk-3xxx-legacy.c
