From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
Date: Tue, 17 Apr 2012 15:20:55 -0700
Message-ID: <878vhut2yg.fsf@ti.com>
References: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:35385 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab2DQWU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 18:20:59 -0400
Received: by dacx6 with SMTP id x6so8876153dac.18
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 15:20:57 -0700 (PDT)
In-Reply-To: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 13 Apr 2012 23:25:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The current serial UART code, while fidling with ocp idlemode bits,
> forget about the smart idle wakeup bit even if it is supported by
> UART IP block. This will lead to missing the module wakeup on OMAP's
> where the smart idle wakeup is supported.
>
> This was the root cause of the console sluggishness issue, I have been
> observing on OMAP4 devices and also can be potential reason for some
> other UART wakeup issues.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@ti.com>

> ---
>  arch/arm/mach-omap2/serial.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c9503a7..b28aae1 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -108,8 +108,14 @@ static void omap_uart_set_noidle(struct platform_device *pdev)
>  static void omap_uart_set_smartidle(struct platform_device *pdev)
>  {
>  	struct omap_device *od = to_omap_device(pdev);
> +	u8 idlemode;
>  
> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
> +	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
> +		idlemode = HWMOD_IDLEMODE_SMART_WKUP;
> +	else
> +		idlemode = HWMOD_IDLEMODE_SMART;
> +
> +	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
>  }
>  
>  #else
