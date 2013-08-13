From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 13 Aug 2013 07:59:39 -0700
Message-ID: <87zjslocv8.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8Xb8cy-=ESE4nWOCub=aw7KFrOgEgzfdGUd1TqDJ0ZR_Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45602 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3HMO7n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 10:59:43 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so8974277pad.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 07:59:43 -0700 (PDT)
In-Reply-To: <CA+Bv8Xb8cy-=ESE4nWOCub=aw7KFrOgEgzfdGUd1TqDJ0ZR_Gg@mail.gmail.com>
	(Russ Dill's message of "Tue, 13 Aug 2013 00:43:09 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

Russ Dill <russ.dill@gmail.com> writes:

> On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:

[...]

>> +static int wkup_m3_probe(struct platform_device *pdev)
>> +{
>> +       int irq, ret = 0;
>> +       struct resource *mem;
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       ret = pm_runtime_get_sync(&pdev->dev);
>> +       if (IS_ERR_VALUE(ret)) {
>> +               dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
>> +               return ret;
>> +       }
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (!irq) {
>> +               dev_err(wkup_m3->dev, "no irq resource\n");
>
> &pdev->dev
>
>> +               ret = -ENXIO;
>> +               goto err;
>> +       }
>> +
>> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!mem) {
>> +               dev_err(wkup_m3->dev, "no memory resource\n");
>
> &pdev->dev

For future reference, when reviewing, please trim to only relevant
content/context, especially on large patches so maintainers/reviewers do
not have to find 2 one-line comments in a huge amount of irrelevant
context.

Thanks,

Kevin
