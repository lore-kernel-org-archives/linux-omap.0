From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: Enable pcf857x GPIO expander for Device Tree
Date: Wed, 19 Jun 2013 21:33:34 +0200
Message-ID: <CACRpkdZkas3t4Ztxv4d-sy+hUnn6L2us8hhriQYrPtdMEM9vOg@mail.gmail.com>
References: <1370527523-1030-1-git-send-email-archit@ti.com>
	<CAOY=C6HRMKKJsSzVdcQSBabmZxZ7Su_CC6m7qi14h1+mOOyABA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:59238 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566Ab3FSTdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 15:33:35 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so7130813oag.14
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 12:33:34 -0700 (PDT)
In-Reply-To: <CAOY=C6HRMKKJsSzVdcQSBabmZxZ7Su_CC6m7qi14h1+mOOyABA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stijn Devriendt <highguy@gmail.com>
Cc: Archit Taneja <archit@ti.com>, LKML <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Jun 18, 2013 at 12:57 PM, Stijn Devriendt <highguy@gmail.com> wrote:
> On Thu, Jun 6, 2013 at 4:05 PM, Archit Taneja <archit@ti.com> wrote:

>> +static struct pcf857x_platform_data *of_gpio_pcf857x(struct device *dev)
>> +{
>> +       struct pcf857x_platform_data *pdata;
>> +       int r;
>> +
>> +       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>
>
> This memory is never freed, is it?

Why should it, given it's allocated with devres?

Yours,
Linus Walleij
