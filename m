From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] TWL4030:TWL5030:TPS659x0: add keypad support
Date: Wed, 22 Jul 2009 17:25:06 +0300
Message-ID: <20090722142506.GC4790@everest>
References: <1247876000-4457-1-git-send-email-vikram.pandita@ti.com>
 <5d5443650907200006h29b75a94kfab151a900f00fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59294 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZGVOZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 10:25:10 -0400
Received: by fxm18 with SMTP id 18so218507fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 07:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5d5443650907200006h29b75a94kfab151a900f00fd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

On 09 Jul 20, Trilok Soni wrote:
> Hi Vikram,
> 
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c/twl4030.h>
> > +#include <mach/keypad.h>
> 
> One empty line between above two headers.
> 
> I hope you are aware of earlier comments posted for this driver when
> it was submitted few months back and had long discussion on threaded
> irq stuff.
>

Trilok,

Could you please post a link to that discussion. Google isn't pointing
me to any relevant discussions besides
http://lkml.org/lkml/2008/10/1/334

I'll do a further cleanup and resubmit.

Regards,
Amit
