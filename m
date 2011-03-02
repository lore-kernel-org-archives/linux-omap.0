From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Wed, 2 Mar 2011 10:11:29 +0530
Message-ID: <AANLkTimJi6y8zUVzV6_e9RKb6=54-JzNMkbkjwPfc-81@mail.gmail.com>
References: <1298925943.16391.19.camel@marge> <AANLkTikmwLoUPJrFZ2o7qsO8MbxBLe2hMbetwxeToW-Z@mail.gmail.com>
 <1298996981.6461.5.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:35233 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757565Ab1CBEmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 23:42:11 -0500
Received: by mail-gx0-f181.google.com with SMTP id 3so820041gxk.40
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 20:42:09 -0800 (PST)
In-Reply-To: <1298996981.6461.5.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Michael_B=FCsch?= <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

On Tue, Mar 1, 2011 at 21:59, Michael B=FCsch <mb@bu3sch.de> wrote:
> On Tue, 2011-03-01 at 11:23 -0500, Varadarajan, Charulatha wrote:
>> > My temporary workaround to this issue is to disable
>> > soft reset for the first GPIO module:
>> >
>> > =A0 =A0 =A0 =A0static struct omap_hwmod omap2420_gpio1_hwmod =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio=
1",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D HWMOD=
_INIT_NO_RESET, /* Workaround: Don't reset the n810 MIPID */
>>
>> NACK.
>>
>> As the problem is specific to the board settings, this shall be hand=
led
>> in the board file itself.
>
> Yeah, sure. But how can I handle this in the board file? Is
> there a hwmod API for this?
>
>> > I'm wondering if a better fix suitable for the mainline
>> > kernel inclusion could be found.
>> > Any ideas?
>>
>> Re-initialize the =A0"nreset" line of the Blizzard in the
>> corresponding board file.
>
> That is not sufficient. The blizzard chip has to be reinitialized
> completely.

Yes. I meant the same but did not mention it clearly :-(

> Code for that doesn't exist in the current driver. It currently depen=
ds
> on the bootloader doing the lowlevel init. As long as I don't have
> documentation for that chip, I'm stuck with that.

How about the following driver?
drivers/video/omap/blizzard.c

I guess this is the same Blizzard  LCD driver.

You may also be interested in the following which I came across while
searching for Blizzard LCD.

https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2.6=
=2E36/300-nokia-board.patch?rev=3D23082

-V Charulatha

>
> --
> Greetings Michael.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
