From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5] OMAP3EVM: Set TSC wakeup option in pad config
Date: Thu, 27 Jan 2011 10:42:58 -0800
Message-ID: <87k4hqnq6l.fsf@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
	<1295977061-11086-6-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48394 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423Ab1A0SnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 13:43:05 -0500
Received: by pwj5 with SMTP id 5so448490pwj.1
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 10:43:01 -0800 (PST)
In-Reply-To: <1295977061-11086-6-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 25 Jan 2011 23:07:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Set OMAP_PIN_OFF_WAKEUPENABLE to enable the wake-up
> functionality from touchscreen controller.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 2a2efa9..5eddf93 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -716,7 +716,8 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
>  				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>  				OMAP_PIN_OFF_WAKEUPENABLE),
>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> -				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
> +				OMAP_PIN_OFF_WAKEUPENABLE),

This hunk doesn't apply because the code below (SYS_BOOT5, etc.) doesn't
exist in upstream code.

Kevin

>  	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>  				OMAP_PIN_OFF_NONE),
>  	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> @@ -729,7 +730,8 @@ static struct omap_board_mux omap36x_board_mux[] __initdata = {
>  				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>  				OMAP_PIN_OFF_WAKEUPENABLE),
>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> -				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
> +				OMAP_PIN_OFF_WAKEUPENABLE),
>  	/* AM/DM37x EVM: DSS data bus muxed with sys_boot */
>  	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
>  	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
