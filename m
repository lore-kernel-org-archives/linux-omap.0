From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv9 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Mon, 14 May 2012 16:56:19 +0530
Message-ID: <4FB0EBDB.3040902@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com> <1335969135-20858-7-git-send-email-shubhrajyoti@ti.com> <20120512181019.GA28973@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:42918 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab2ENL01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 07:26:27 -0400
Received: by obbup19 with SMTP id up19so7578816obb.38
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 04:26:26 -0700 (PDT)
In-Reply-To: <20120512181019.GA28973@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Saturday 12 May 2012 11:40 PM, Wolfram Sang wrote:
>> Cc: Kevin Hilman <khilman@ti.com>
>> > Cc: Rajendra Nayak <rnayak@ti.com>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> I'd really like a comment from the PM experts if each and every driver
> has to ensure that the clocks are enabled on remove like this?
Just resent cc ing linux-pm

BTW also found that

Some others are also doing the same. eg:
 
drivers/mmc/host/omap_hsmmc.c
static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
{
        struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
        struct resource *res;

        pm_runtime_get_sync(host->dev);
        mmc_remove_host(host->mmc);

2. drivers/usb/musb/musb_core.c

static void musb_shutdown(struct platform_device *pdev)
{
        struct musb     *musb = dev_to_musb(&pdev->dev);
        unsigned long   flags;

        pm_runtime_get_sync(musb->controller);

Anyways will wait for feedback.




>
>> > ---
>> >  drivers/i2c/busses/i2c-omap.c |   

