From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2plus: fix ads7846 pendown gpio request
Date: Tue, 31 May 2011 04:12:46 -0700
Message-ID: <20110531111246.GX11352@atomide.com>
References: <1304521495-20578-1-git-send-email-grinberg@compulab.co.il>
 <4DC18B64.2020903@gmail.com>
 <4DCA3C56.9020502@compulab.co.il>
 <4DDE5C8B.7030308@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42995 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184Ab1EaLMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 07:12:50 -0400
Content-Disposition: inline
In-Reply-To: <4DDE5C8B.7030308@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, Thomas Weber <thomas.weber.linux@googlemail.com>, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

* Igor Grinberg <grinberg@compulab.co.il> [110526 06:54]:
> ping
> 
> On 05/11/11 10:35, Igor Grinberg wrote:
> 
> > Tony,
> >
> >
> > You can fold this one to the original patch from Mike as well,
> >
> > or do you want it into the rc1?

Thanks adding to fixes.

Tony

> >
> >
> >
> > On 05/04/11 20:22, Thomas Weber wrote:
> >
> >> Am 04.05.2011 17:04, schrieb Igor Grinberg:
> >>> introduced by: 96974a24
> >>> (omap: consolidate touch screen initialization among different boards)
> >>>
> >>> ads7846 driver can use either gpio_pendown or get_pendown_state()
> >>> callback. In case of gpio_pendown, it requests the provided gpio_pendown
> >>> thus resulting in double requesting that gpio:
> >>>
> >>> ads7846 spi1.0: failed to request pendown GPIO57
> >>> ads7846: probe of spi1.0 failed with error -16
> >>>
> >>> Fix this by restricting the gpio request to the case of
> >>> get_pendown_state() callback is used.
> >>>
> >>> Signed-off-by: Igor Grinberg<grinberg@compulab.co.il>
> >>> ---
> >>>   arch/arm/mach-omap2/common-board-devices.c |   20 ++++++++++----------
> >>>   1 files changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> >>> index d57c71d..61fee80 100644
> >>> --- a/arch/arm/mach-omap2/common-board-devices.c
> >>> +++ b/arch/arm/mach-omap2/common-board-devices.c
> >>> @@ -83,17 +83,17 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> >>>       struct spi_board_info *spi_bi =&ads7846_spi_board_info;
> >>>       int err;
> >>>
> >>> -    err = gpio_request(gpio_pendown, "TS PenDown");
> >>> -    if (err) {
> >>> -        pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
> >>> -        return;
> >>> -    }
> >>> -
> >>> -    gpio_direction_input(gpio_pendown);
> >>> -    gpio_export(gpio_pendown, 0);
> >>> +    if (board_pdata&&  board_pdata->get_pendown_state) {
> >>> +        err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> >>> +        if (err) {
> >>> +            pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> >>> +            return;
> >>> +        }
> >>> +        gpio_export(gpio_pendown, 0);
> >>>
> >>> -    if (gpio_debounce)
> >>> -        gpio_set_debounce(gpio_pendown, gpio_debounce);
> >>> +        if (gpio_debounce)
> >>> +            gpio_set_debounce(gpio_pendown, gpio_debounce);
> >>> +    }
> >>>
> >>>       ads7846_config.gpio_pendown = gpio_pendown;
> >>>
> >> Tested-by: Thomas Weber <weber@corscience.de>
> >>
> >> On Devkit8000.
> >>
> 
> -- 
> Regards,
> Igor.
> 
