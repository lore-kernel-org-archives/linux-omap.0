From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 5/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
 drivers interface
Date: Mon, 28 Feb 2011 12:00:39 +0530
Message-ID: <AANLkTim9Nwst-2cLu5-8Yx9B-fnWO=xeDdMwuh=4pvgJ@mail.gmail.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	<1298643715-21540-6-git-send-email-mythripk@ti.com>
	<1298801837.1977.63.camel@deskari>
	<AANLkTimiQ2pdvzP0OAnq5YqzkWq_91XLMWSq1K5M_3VH@mail.gmail.com>
	<1298874423.2096.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35190 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752413Ab1B1Gam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:30:42 -0500
Received: by mail-vw0-f45.google.com with SMTP id 19so3876168vws.18
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 22:30:40 -0800 (PST)
In-Reply-To: <1298874423.2096.11.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Mon, Feb 28, 2011 at 11:57 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Mon, 2011-02-28 at 00:11 -0600, K, Mythri P wrote:
>> Hi Tomi,
>>
>> On Sun, Feb 27, 2011 at 3:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>
>> >> + * HDMI interface DSS driver setting for TI's OMAP4 family of pr=
ocessor.
>> >> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http=
://www.ti.com/
>> >> + * Authors: Yong Zhi
>> >
>> > Who is Yong Zhi and where's his signed-off-by?
>> Yong zhi had written some of the functions in this file , which was =
in
>> a library.He no longer works on the driver though .
>
> Ok. Generally there should be a signed-off-by from everybody who has
> written the code. It's like "I have written this code and I have
> permission to send it upstream" etc.
>
> His signed-off would be good for this too, but if the code is just ba=
sed
> on his work, and doesn't really resemble it anymore, perhaps you coul=
d
> then say "Based on code by Yong Zhi", or similar.
>
sure i shall check with him to add his sign-off.
>> >> +
>> >> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg=
 idx,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int=
 b2, int b1, u32 val)
>> >> +{
>> >> + =A0 =A0 =A0 u32 t =3D 0;
>> >> + =A0 =A0 =A0 while (val !=3D FLD_GET(hdmi_read_reg(idx), b2, b1)=
) {
>> >
>> > There's REG_GET macro used in other DSS files to read bits from th=
e
>> > registers.
>> Hmm i see that in dsi.c REG_GET is defined to do the same,
>> #define REG_GET(idx, start, end) \
>> =A0 =A0 =A0 =A0 FLD_GET(dsi_read_reg(idx), start, end)
>> So should this be fine of should i define a new REG_GET ?
>
> REG_GET() uses the private dsi_read_reg() function, so it has to be
> defined again in each interface file. So for HDMI, define REG_REG
> similarly with hdmi_read_reg().
>
But it is used in only one function here , so is it really needed :) ?

>> >> + =A0 =A0 =A0 /* HACK : DDC needs time to stablize */
>> >> + =A0 =A0 =A0 mdelay(10);
>> >
>> > So what is the reason for this? It's a sleep that for unknown reas=
on
>> > make the code work? Or is there an idea why this is needed?
>> This is the time it needs to stabilize DDC, else most of the time it
>> reads a 0 or
>> wrong shifted values , so i have prefixed with a HACK.
>
> Ok. I'm fine with the hack for now, but I'm just interested: Is the 1=
0ms
> just something that happens to work? This sleep is not discussed in a=
ny
> documentation? Has this been discussed with HW people?

yes i have checked with the silicon validation.
>
>> >> +static inline void print_omap_video_timings(struct omap_video_ti=
mings *timings)
>> >
>> > Why is this inline?
>> Its only a print function , called many times by the driver. Do you
>> see any reason not to make it inline?
>
> Well, generally you shouldn't use inline. I think that's the basic ru=
le.
> Compiler usually makes better choices than humans. I have used them f=
or
> xxx_read_reg() and xxx_write_reg(), although I'm not quite sure if ev=
en
> that is needed.
>
> And in this case the function is quite long. I'm guessing here, but m=
ost
> likely the code runs faster if it's _not_ inlined, because not inlini=
ng
> reduces the size of the code. Also, print functions are on the slower
> side anyway, so the overhead of calling this function is probably
> negligible compared to the contents of the function.
>
ok i shall change.

> =A0Tomi
>
>
>

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
