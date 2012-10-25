From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 11:27:50 +0530
Message-ID: <CAM=Q2cvO7T4S_efZuBub2EGMWLTK7tyUbhxJaJamv6yN8jNAkw@mail.gmail.com>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
	<20121023171840.GA32167@arwen.pp.htv.fi>
	<CAM=Q2cs-+O_BFrZFX4fuBooogEZiQO2Zxbm8W40vN9hmampLCA@mail.gmail.com>
	<20121023175706.GC32517@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43430 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab2JYF5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 01:57:51 -0400
In-Reply-To: <20121023175706.GC32517@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

On Tue, Oct 23, 2012 at 11:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Oct 23, 2012 at 11:26:15PM +0530, Shubhrajyoti Datta wrote:
>> >> @@ -1268,23 +1271,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
>> >>  {
>> >>       struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
>> >>
>> >> -     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>> >> -     }
>> >> -
>> >> -     /*
>> >> -      * Don't write to this register if the IE state is 0 as it can
>> >> -      * cause deadlock.
>> >> -      */
>> >> -     if (_dev->iestate)
>> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
>> >
>> > this part is not on __omap_i2c_init() so you're potentially causing a
>> > regression here.
>>
>> iestate is set at init so cannot be zero. so the check was removed.
>
Hmm thinking a little more, there is a case that I missed the resume
handler may get called before
the omap_i2c_init will  restore the check and send another version.
