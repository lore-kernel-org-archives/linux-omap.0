From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 09:38:22 -0800
Message-ID: <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f12.google.com ([209.85.217.12]:36804 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540AbYLKRlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 12:41:12 -0500
Received: by gxk5 with SMTP id 5so519415gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 09:41:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Dec 11, 2008 at 8:49 AM, Paul Walmsley <paul@booyaka.com> wrote:
> Hi Grazvydas, Steve,
>
> On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:
>
>> > Can you please post whatever patches you need to apply to make it work
>> > occasionally so others can also look at the issue?
>>
>> For pandora, making infinite while loops finite doesn't help much,
>> kernel crashes later on. Steve had this too:
>> http://marc.info/?l=linux-omap&m=122378604027303&w=2
>>
>> I did bisect and found that commit
>> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
>> Reverting this makes EHCI work again on pandora.
>> http://marc.info/?l=linux-omap&m=122453174024860&w=2
>
> Would one of you be willing to run with this patch and send back any debug
> output relating to dpll5_ck ?  (Unfortunately, I don't have access to any
> boards with EHCI hardware, so cannot try it myself)
>
> This will help determine what fix should be applied

Here you go.  Note that no infinite loop!

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
clock: dpll5_ck: clk->rate = 0, hdwr rate = 120000000, parent rate = 13000000
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 2
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
usb 1-1: new high speed USB device using musb_hdrc and address 2
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.28-rc7-omap1 ehci_hcd
usb usb2: SerialNumber: ehci-omap.0

Steve

> - Paul
>
>
>
> Add debugging in omap3_noncore_dpll_enable() - for testing only.
>
> ---
>  arch/arm/mach-omap2/clock34xx.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 2c655be..3b80667 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -275,6 +275,10 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
>        if (!dd)
>                return -EINVAL;
>
> +       pr_info("clock: %s: clk->rate = %ld, hdwr rate = %d, parent "
> +               "rate = %ld\n", clk->name, clk->rate,
> +               omap2_get_dpll_rate(clk), dd->bypass_clk->rate);
> +
>        if (clk->rate == dd->bypass_clk->rate)
>                r = _omap3_noncore_dpll_bypass(clk);
>        else
>
>
>
