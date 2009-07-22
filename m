From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] TWL4030:TWL5030:TPS659x0: add keypad support
Date: Thu, 23 Jul 2009 00:13:06 +0530
Message-ID: <5d5443650907221143n3511129en333eca78ba886716@mail.gmail.com>
References: <1247876000-4457-1-git-send-email-vikram.pandita@ti.com>
	 <5d5443650907200006h29b75a94kfab151a900f00fd@mail.gmail.com>
	 <20090722142506.GC4790@everest>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:17887 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbZGVSnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 14:43:07 -0400
Received: by qw-out-2122.google.com with SMTP id 8so217417qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 11:43:06 -0700 (PDT)
In-Reply-To: <20090722142506.GC4790@everest>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

Hi Amit,

On Wed, Jul 22, 2009 at 7:55 PM, Amit
Kucheria<amit.kucheria@verdurent.com> wrote:
> On 09 Jul 20, Trilok Soni wrote:
>> Hi Vikram,
>>
>> > +
>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/init.h>
>> > +#include <linux/interrupt.h>
>> > +#include <linux/input.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/i2c/twl4030.h>
>> > +#include <mach/keypad.h>
>>
>> One empty line between above two headers.
>>
>> I hope you are aware of earlier comments posted for this driver when
>> it was submitted few months back and had long discussion on threaded
>> irq stuff.
>>
>
> Trilok,
>
> Could you please post a link to that discussion. Google isn't pointing
> me to any relevant discussions besides
> http://lkml.org/lkml/2008/10/1/334
>
> I'll do a further cleanup and resubmit.

If you follow latest discussion as below, you will get the pointers.

http://marc.info/?l=linux-i2c&m=124828117611346&w=2

It is also CCed to linux-input as well.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
