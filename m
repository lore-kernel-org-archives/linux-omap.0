From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused
 uarts
Date: Fri, 4 May 2018 10:39:31 -0700
Message-ID: <20180504173931.GD98604@atomide.com>
References: <20180504173103.73881-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504173103.73881-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180504 17:33]:
> I noticed that unused UARTs won't necessarily idle properly always
> unless at least one byte tx transfer is done first.
> ---
>  arch/arm/mach-actions/platsmp.c     |  6 +++---
>  arch/arm/mach-exynos/platsmp.c      | 12 ++++++------
>  arch/arm/mach-hisi/platmcpm.c       | 22 +++++++++++-----------
>  arch/arm/mach-omap2/omap-smp.c      | 10 +++++-----
>  arch/arm/mach-prima2/platsmp.c      | 10 +++++-----
>  arch/arm/mach-qcom/platsmp.c        | 10 +++++-----
>  arch/arm/mach-spear/platsmp.c       | 10 +++++-----
>  arch/arm/mach-sti/platsmp.c         | 10 +++++-----
>  arch/arm/mach-sunxi/mc_smp.c        | 20 ++++++++++----------
>  arch/arm/plat-versatile/platsmp.c   | 10 +++++-----
>  drivers/tty/serial/8250/8250_omap.c | 16 +++++++++++++++-
>  11 files changed, 75 insertions(+), 61 deletions(-)

Uhh sorry I managed to commit also a patch I was testing while
updating patch comments.. Will send out v3 shortly, this can be
ignored.

Regards,

Tony
