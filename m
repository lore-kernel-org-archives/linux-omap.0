From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hsmmc.c: Remove dead code
Date: Mon, 17 Jul 2017 15:08:54 +0200
Message-ID: <CAPDyKFpwb3T4PhQSyUwWDwpEnOwVDxLeK7hAMS0Q4P3tzPXXrQ@mail.gmail.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com> <1500036404-5556-2-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500036404-5556-2-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 14 July 2017 at 14:46, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Most platforms using OMAP hsmmc driver have switched to device tree
> for passing platform data to omap_hsmmc.c driver.
>
> The hsmmc.c file in mach-omap2 exists only to support pandora board
> which uses wl1251 driver in legacy platform data mode.
>
> Hence, remove the dead code not used by the pandora board.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

I just got an ack from Tony to pick this up. So I did that (including
the mmc change in patch 2) and intend to send this for 4.13 rcs, via
my fixes branch in my mmc tree.

However the below comment for testing puzzles me. Either it's dead
code or not, so then what is there to test? :-)

Anyway, it's available on my fixes and next branch, so let's see if
zero build reports some issues.

> ---
> This is only compile tested. Someone with a pandora board should help
> test this for functionality.
>
>  arch/arm/mach-omap2/hsmmc.c | 239 +-------------------------------------------
>  arch/arm/mach-omap2/hsmmc.h |   9 --
>  2 files changed, 2 insertions(+), 246 deletions(-)

[...]

Kind regards
Uffe
