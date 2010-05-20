From: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: Re: [PATCH] twl4030_wdt: Disable watchdog while probing
Date: Thu, 20 May 2010 08:39:48 +0300
Message-ID: <1274333988.30871.17.camel@sarki.nmp.nokia.com>
References: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59424 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0ETFkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 01:40:07 -0400
In-Reply-To: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wim@iguana.be" <wim@iguana.be>

Hi,

On Mon, 2010-05-17 at 13:12 +0200, Palande Ameya (Nokia-D/Helsinki)
wrote:
> If we are not able to register then it is better to have watchdog in disabled
> state than noticing a system reboot.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/watchdog/twl4030_wdt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
> index dcabe77..b5045ca 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -190,6 +190,8 @@ static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
>  
>  	twl4030_wdt_dev = pdev;
>  
> +	twl4030_wdt_disable(wdt);
> +
>  	ret = misc_register(&wdt->miscdev);
>  	if (ret) {
>  		dev_err(wdt->miscdev.parent,


It seems that in this patch, you disable the watchdog regardless whether
the registration fails or not. I wonder if this is a good thing to do.
What if the bootloader have already enabled the watchdog and then user
space booting fails for some reason before any process is able to open
and re-enable the watchdog? We could end up with a hung system that does
not have the watchdog enabled. Maybe we should disable the watchdog only
in case the registration actually fails?

And even in that case, do we want to disable the watchdog? What are the
situations where watchdog registration can fail? Is there a possibility
that we would like to leave watchdog running in such case and cause a
reboot (say, something bad happened before the watchdog module was
loaded and the system ran out of memory, which causes watchdog
registration to fail)?

Maybe there is something I've missed, but this kind of questions came in
my mind..

-Timo

