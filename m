From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
Date: Mon, 09 Aug 2010 14:45:15 -0700
Message-ID: <87y6cfh34k.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
	<1281098065-24177-12-git-send-email-charu@ti.com>
	<1281098065-24177-13-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64573 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0HIVpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 17:45:18 -0400
Received: by pvg2 with SMTP id 2so935077pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 14:45:18 -0700 (PDT)
In-Reply-To: <1281098065-24177-13-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Fri, 6 Aug 2010 18:04:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, "Basak, Partha" <p-basak2@ti.com>

Charulatha V <charu@ti.com> writes:

> @@ -1728,7 +1729,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_enable(bank->dev);
> -	pm_runtime_get_sync(bank->dev);

Why do you remove this?

>  	omap_gpio_mod_init(bank, id);

This next call accesses GPIO registers and will fault if the GPIO module
is reset.

You get lucky currently as the GPIO hwmods are not reset on init due to
a problem under investigation.  (see this patch in Benoit's series)
[PATCH v3 6/7] OMAP: hwmod: Temporary prevent reset during _setup for GPIOs

Kevin
