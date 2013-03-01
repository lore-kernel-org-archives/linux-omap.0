From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 0/2] gpio/omap: updates for v3.10
Date: Fri, 1 Mar 2013 23:52:01 +0100
Message-ID: <CABxcv=nvZNWDgKLwQ6RPJyMdsAF5zVpo8dEhvE4YVZETiScDcg@mail.gmail.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42214 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab3CAWwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 17:52:05 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so2792399wgi.3
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 14:52:01 -0800 (PST)
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 1, 2013 at 6:22 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Summary of updates:
> - Convert OMAP GPIO driver to use linear mapping for IRQ domains
> - Avoid crashes seen if a gpio bank is not enabled when requesting an IRQ.
>
> Testing includes:
> - Boot testing on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP
>   and AM335x EVM.
> - Verified that GPIO interrupts are working on OMAP5912 OSK, OMAP2420 H4,
>   OMAP3430 SDP and OMAP4430 SDP by making sure networking was working
>   correctly as these boards use a GPIO with the ethernet chips. Also
>   checked /proc/interrupts to ensure GPIO interrupt counts are
>   incrementing as expected.
>
> Jon Hunter (2):
>   gpio/omap: convert gpio irq domain to linear mapping
>   gpio/omap: warn if bank is not enabled on setting irq type
>
>  drivers/gpio/gpio-omap.c |   75 +++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 41 deletions(-)
>
> --

I've tested on a TI OMAP3 DM3735 board (IGEPv2) and the ethernet chip
(which use a GPIO line as a IRQ) is working correctly too.

So, for both patches:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>
