From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM-OMAP1: Adjustments for three function
 implementations
Date: Wed, 7 Jun 2017 00:02:24 -0700
Message-ID: <20170607070224.GO3727@atomide.com>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* SF Markus Elfring <elfring@users.sourceforge.net> [170601 13:50]:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 1 Jun 2017 22:40:04 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (5):
>   Improve a size determination in omap1_system_dma_init()
>   Delete an error message for a failed memory allocation in omap1_system_dma_init()
>   Delete an unnecessary return statement in omap1_show_dma_caps()
>   Delete an error message for a failed memory allocation in omap1_dm_timer_init()
>   Fix a typo in a comment line
> 
>  arch/arm/mach-omap1/dma.c   | 5 +----
>  arch/arm/mach-omap1/timer.c | 4 +---
>  2 files changed, 2 insertions(+), 7 deletions(-)

Thanks applying all into omap-for-v4.13/omap1.

Tony
