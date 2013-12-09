From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Mon, 9 Dec 2013 13:23:31 +0100
Message-ID: <CABxcv=mTnAcYz3H4CzqJ8McwhxpP8aaSxOH3FFEADUiSaqd8=w@mail.gmail.com>
References: <52A29A82.106@collabora.co.uk>
	<52A2A3EF.1030306@collabora.co.uk>
	<52A5B111.3010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60413 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933415Ab3LIMXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 07:23:32 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so3663310wib.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 04:23:31 -0800 (PST)
In-Reply-To: <52A5B111.3010307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

On Mon, Dec 9, 2013 at 1:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-12-07 06:28, Javier Martinez Canillas wrote:
>
>> Actually, I looked at drivers/video/omap2/connector-dvi.c and it does the right
>> thing for legacy platform data probing but no for DT probing:
>>
>> static int dvic_probe_pdata(struct platform_device *pdev)
>> {
>> ..
>>               adapter = i2c_get_adapter(i2c_bus_num);
>>               if (!adapter) {
>>                       dev_err(&pdev->dev,
>>                                       "Failed to get I2C adapter, bus %d\n",
>>                                       i2c_bus_num);
>>                       return -EPROBE_DEFER;
>>               }
>> ..
>> }
>>
>> static int dvic_probe_of(struct platform_device *pdev)
>> {
>> ..
>>                adapter = of_find_i2c_adapter_by_node(adapter_node);
>>                 if (adapter == NULL) {
>>                         dev_err(&pdev->dev, "failed to parse i2c-bus\n");
>>                         omap_dss_put_device(ddata->in);
>>                         return -EINVAL;
>>                 }
>> ..
>> }
>>
>> The following patch solves the issue if you want to include in your patch-set:
>
> Thanks, I'll add this and the omap3-igep0020 support to my DT branch.
>

Great, thanks a lot for working on this!

I'm very happy that we will have proper display support for IGEPv2 on
v3.14 without any DT hacks or pdata-quirks :-)

>  Tomi

Best regards,
Javier
>
>
