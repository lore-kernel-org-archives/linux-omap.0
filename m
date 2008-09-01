From: "arun c" <arun.edarath@gmail.com>
Subject: Re: omapfb problem on 3430sdp
Date: Mon, 1 Sep 2008 02:38:20 -0400
Message-ID: <c656a4d20808312338s6abe13c3m8dc8700116fe36fc@mail.gmail.com>
References: <1219829316.15818.77.camel@localhost>
	 <56537.192.168.10.89.1219847223.squirrel@dbdmail.itg.ti.com>
	 <1220012913.14924.55.camel@localhost>
	 <c656a4d20808290848q3c676ddbn19df1d5fff43e5ad@mail.gmail.com>
	 <1220232703.14924.68.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:48407 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbYIAGiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 02:38:24 -0400
Received: by ti-out-0910.google.com with SMTP id b6so995524tic.23
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2008 23:38:20 -0700 (PDT)
In-Reply-To: <1220232703.14924.68.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stanley.miao@windriver.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Aug 31, 2008 at 9:31 PM, stanley.miao
<stanley.miao@windriver.com> wrote:
>
> On Fri, 2008-08-29 at 21:18 +0530, arun c wrote:
>> Hi stanley,
>>
>> On Fri, Aug 29, 2008 at 5:58 PM, stanley.miao
>> <stanley.miao@windriver.com> wrote:
>> >
>> > I have tried. It is not backlight's problem.
>>
>> Try this out
>>
>> Boot with the working kernel after that soft reset the board and try
>> the non working image(git) and see what happens.
>>
>> If no success
>
> If yes, what should I do ? You seems to encounter this problem ever.
>
> After soft reset with the working kernel, the non-working kernel will
> work. It look like the initial process is incomplete.

Can you check DSS DATA pin voltages for both the kernel?

Procedure:
Write various data (white, red ,green ,blue etc.) and verify
the pin voltages.

>
> Thanks
> Stanley
>
>>
>> Try the below values in lcd_2430sdp.c
>>
>> #define ENABLE_VAUX3_DEDICATED  0x05
>> #define ENABLE_VAUX3_DEV_GRP    0xE0
>>
>> >
>> > I found that only green color was showed, red and blue were filtered. So
>> > the picture looked green and dark.
>> >
>> > The color mode is RGB565. I wrote 0x07e0, 0xffe0, and 0xffff to /dev/fb0
>> > respectively. All of them are showed to the same color, it's green.
>> >
>> > I am using the latest code from source.mvista.com on omap3430sdp. Does
>> > anybody encounter this problem ?
>> >
>> > Thanks
>> > Stanley.
>> >
>> >
>> > On Wed, 2008-08-27 at 19:57 +0530, iqbal wrote:
>> >> > The linux bootup logo is green, and LCD is dark. It looks like backlight
>> >> > disabled.
>> >> >
>> >> > I commented the following two sentences in lcd_2430.c, there is still
>> >> > the same thing. It seems these two sentences doesn't work.
>> >> >
>> >> >  96         omap_set_gpio_dataout(enable_gpio, 1);
>> >> >  97         omap_set_gpio_dataout(backlight_gpio, 1);
>> >> >
>> >> > Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
>> >> > this problem.  However, the old version in linux-omap-2.6, 2.6.21,
>> >> > doesn't have this problem.
>> >> >
>> >> > Stanley.
>> >>
>> >> If I use this piece of code in panel suspend and resume, I see that the panel
>> >> backlight is going off on suspend and comes back while calling resume. Give a
>> >> try .
>> >>
>> >>  static int sdp2430_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
>> >>  {
>> >> +       omap_set_gpio_dataout(backlight_gpio, 0);
>> >> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
>> >> +                               TWL4030_VPLL2_DEDICATED);
>> >> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,0x0,
>> >> +                               TWL4030_VPLL2_DEV_GRP);
>> >> +       mdelay(4);
>> >>         return 0;
>> >>  }
>> >>
>> >>  static int sdp2430_panel_resume(struct platform_device *pdev)
>> >>  {
>> >> +       if (lcd_in_use)
>> >> +       return 0;
>> >> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> >> +                       ENABLE_VPLL2_DEDICATED,TWL4030_VPLL2_DEDICATED);
>> >> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> >> +                       ENABLE_VPLL2_DEV_GRP,TWL4030_VPLL2_DEV_GRP);
>> >> +       omap_set_gpio_dataout(backlight_gpio, 1);
>> >> +
>> >>         return 0;
>> >>  }
>> >>
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> >> > the body of a message to majordomo@vger.kernel.org
>> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >
>> >> >
>> >>
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>
