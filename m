From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3:WDT:Enable support for IVA and SECURE
Date: Tue, 09 Jun 2009 07:47:18 -0700
Message-ID: <87prddzcp5.fsf@deeprootsystems.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
	<1244495293-17244-2-git-send-email-ubh@ti.com>
	<1244495293-17244-3-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:33711 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZFIOrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 10:47:18 -0400
Received: by pzk1 with SMTP id 1so20830pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 07:47:21 -0700 (PDT)
In-Reply-To: <1244495293-17244-3-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Mon\,  8 Jun 2009 16\:08\:12 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> This patch enables the IVA and SECURE WDTs in the omap_wdt
> driver for omap34xx family. SECURE will be available as /dev/watchdog1
> HS/EMU devices and IVA will be available as /dev/watchdog3.
> MPU will be available as /dev/watchdog2
> For omap versions earlier than 34xx only MPU watchdog is present and
> will be available as /dev/watchdog for backwards compatibility.
>
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> ---
>  drivers/watchdog/omap_wdt.c |   42 +++++++++++++++++++++++++++++++++++-------
>  1 files changed, 35 insertions(+), 7 deletions(-)
>  mode change 100644 => 100755 drivers/watchdog/omap_wdt.c
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c

[...]

>  static int omap_wdt_open(struct inode *inode, struct file *file)
>  {
> -	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
> -	void __iomem *base = wdev->base;
> +	struct omap_wdt_dev *wdev;
> +	void __iomem *base;
> +
> +	/* by default MPU wdt is present across omap family */
> +	wdev = platform_get_drvdata(omap_wdt_dev[1]);
> +
> +	/* if multiple wdts, find match between device node and wdt device */
> +	if (cpu_is_omap34xx()) {
> +		int i;
> +		for (i = 0; i < NUM_WDTS; i++) {
> +			if (omap_wdt_dev[i]) {
> +				wdev = platform_get_drvdata(omap_wdt_dev[i]);
> +				if (iminor(inode)
> +					== wdev->omap_wdt_miscdev.minor)
> +					break;
> +			}
> +		}
> +	}
> +
> +	base = wdev->base;

Hmm, this does not look right to me.  Any use of cpu_is_* in driver
code usually indicates that something is not quite right.  This same
watchdog IP is used in some DaVinci family processors and needs to be
reused there.

I didn't do the miscdev research, but can't you get the pdev from the
miscdev.parent, and from there get the right wdev pointer from the
pdev.drvdata.

Otherwise, drop the cpu_is_* and just do inode checking all the time.
The way you've done it looks error prone to me.

>  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
>  		return -EBUSY;
> @@ -263,6 +283,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  	struct resource *res, *mem;
>  	struct omap_wdt_dev *wdev;
>  	int ret;
> +	static char wdt_name[32];
>  
>  	/* reserve static register mappings */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -271,7 +292,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  		goto err_get_resource;
>  	}
>  
> -	if (omap_wdt_dev) {
> +	if (omap_wdt_dev[pdev->id-1]) {
>  		ret = -EBUSY;
>  		goto err_busy;
>  	}
> @@ -318,8 +339,14 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  
>  	wdev->omap_wdt_miscdev.parent = &pdev->dev;
>  	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
> -	wdev->omap_wdt_miscdev.name = "watchdog";
>  	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
> +	wdev->omap_wdt_miscdev.name = "watchdog";
> +	if (cpu_is_omap34xx()) {
> +		snprintf(wdt_name, sizeof(wdt_name), "watchdog%d", pdev->id);
> +		wdev->omap_wdt_miscdev.name = wdt_name;
> +		if (pdev->id != 2)
> +			wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
> +	}

Again, red flag: cpu_is_*

It might be more consistent to use pdev->dev->name which is already of
the form "watchdog.%d".

Any reason not to use MISC_DYNAMIC_MINOR for all of them?

Kevin
