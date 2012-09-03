From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH] gpio/omap: fix possible memory leak in omap2_gpio_dev_init()
Date: Mon, 3 Sep 2012 20:36:20 +0800
Message-ID: <CAPgLHd8XqqodUF8j5FRvfyGYGt_a3jbLZjtZfdMcst2_tj0NYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48765 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab2ICMgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 08:36:21 -0400
Received: by qaas11 with SMTP id s11so2141057qaa.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Sep 2012 05:36:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On 09/03/2012 07:11 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 03, 2012 at 06:13:33PM +0800, Wei Yongjun wrote:
>> @@ -130,6 +132,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>>  
>>  	pdev = omap_device_build(name, id - 1, oh, pdata,
>>  				sizeof(*pdata),	NULL, 0, false);
>> +	kfree(pdata->regs);
>>  	kfree(pdata);
> This one looks wrong.  pdata is copied by the internals of
> omap_device_build(), which includes the 'regs' pointer, so it should not
> be freed after a successful call to omap_device_build().  (It should,
> however, be freed after an unsuccessful call.)
>
> BTW, you want to copy Paul Walmsley with this patch (address in Cc).
>
>

Thanks, I will fix this and send a update version.


