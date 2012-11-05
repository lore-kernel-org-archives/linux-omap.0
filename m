From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 15:10:49 +0530
Message-ID: <CAM=Q2ctUp-kOY928=5Opi59gTC1EACTqMfojKN9OPsT-nrZ2mQ@mail.gmail.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
	<1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
	<20121105075026.GB32468@arwen.pp.htv.fi>
	<50977A30.6040907@ti.com>
	<20121105090412.GA2913@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63401 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab2KEJkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 04:40:51 -0500
In-Reply-To: <20121105090412.GA2913@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
>> >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
>> >>
>> >>            dev->fifo_size = (dev->fifo_size / 2);
>> >>
>> >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
>> >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
>> >>                    dev->b_hw = 1; /* Enable hardware fixes */
>> > looks like this was applicable to 4430 too, what happened ?
>> No actually this can be deleted completely once the
>> start -> transaction -> stop sequence recommendation is followed.
>
> yes, but we're not there just yet and this patch is changing the
> behavior

No , earlier we were truncating the register for omap4 so
OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
omap4 then we donot find 3630 and 4430 value to be similar.

In this case the behavior is same as earlier also it enabled this for
lower than 3630 and
the same holds good even now.

So in essence,
Earlier  OMAP_I2C_REV_ON_3630_4430 is named to OMAP_I2C_REV_ON_3630
and omap4 rev will have a 32bit value which is greater.

> of the driver in ways which don't belong to $SUBJECT.
>
> --
> balbi
