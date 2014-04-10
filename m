From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RFC PATCH 0/5] add gpio_chip_ops to hold GPIO operations
Date: Thu, 10 Apr 2014 13:46:02 +0200
Message-ID: <CABxcv=kAk1Gwm6LHq2X5CFxM6Qo97WUZdmSwszuUiesz699Hdg@mail.gmail.com>
References: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk>
	<CAAVeFu+XV_wy9JzewGs0bcSA-ivQg-kzygMh_kt434rsYRQwHQ@mail.gmail.com>
	<534665B1.9090207@collabora.co.uk>
	<1397127659.11914.94.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37271 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030202AbaDJLqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 07:46:05 -0400
Received: by mail-wg0-f43.google.com with SMTP id x13so3790425wgg.26
        for <linux-omap@vger.kernel.org>; Thu, 10 Apr 2014 04:46:03 -0700 (PDT)
In-Reply-To: <1397127659.11914.94.camel@smile.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Andy,

On Thu, Apr 10, 2014 at 1:00 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2014-04-10 at 11:34 +0200, Javier Martinez Canillas wrote:
>> On 04/10/2014 09:36 AM, Alexandre Courbot wrote:
>> >
>> > "Since having the operations" maybe?
>> >
>>
>> Yes, since I'm not a native english speaker I sometimes miss some obvious
>> grammatical errors. I'll fix those when posting the final version with all the
>> drivers converted.
>
> JFYI: there is nice project called codespell [1].
>
> [1] git://github.com/lucasdemarchi/codespell.git

Interesting project, thanks a lot for the pointer.

Best regards,
Javier

>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
