From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Initialize USB DPLL
Date: Thu, 21 Mar 2013 15:55:32 +0200
Message-ID: <514B1154.1020100@ti.com>
References: <1363873705-3224-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363873705-3224-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, rnayak@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/21/2013 03:48 PM, Roger Quadros wrote:
> If the bootloader doesn't configure USB DPLL (e.g. in u-boot,
> disable CONFIG_USB_EHCI_OMAP), then we get all sorts of problems
> like
> - division by zero errors at boot [1]
> - USB DPLL fails to enter locked state
> - USB EHCI Host is non functional
> - Device can't enter OFF mode
> 
> Initializing the USB DPLL fixes all these issues.
> 
> [1]
> 
> [    0.000000] clock: dpll_usb_ck failed transition to 'locked'
> [    0.000000] Division by zero in kernel.
> [    0.000000] [<c001b00c>] (unwind_backtrace+0x0/0xf0) from [<c02b2378>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02b2378>] (Ldiv0+0x8/0x10) from [<c041cf3c>] (clk_divider_set_rate+0x10/0x124)
> [    0.000000] [<c041cf3c>] (clk_divider_set_rate+0x10/0x124) from [<c041bfc4>] (clk_change_rate+0x3c/0xb4)
> [    0.000000] [<c041bfc4>] (clk_change_rate+0x3c/0xb4) from [<c041c028>] (clk_change_rate+0xa0/0xb4)
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index bfc46c1..6127bb9 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -53,6 +53,12 @@
>   */
>  #define OMAP4_DPLL_ABE_DEFFREQ				98304000
>  
> +/*
> + * OMAP4450 TRM Rev X, section "3.6.3.9.5 DPLL_USB Preferred Settings"

4460 actually.

cheers,
-roger
