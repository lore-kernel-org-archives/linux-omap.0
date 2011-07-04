From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: gpio interrupt is not invoked on Panda board
Date: Mon, 4 Jul 2011 11:17:29 +0530
Message-ID: <CA+HSevoHyVW_j0kiWiKbESt_RsO1jStaAcyuy56grBWETt2_zQ@mail.gmail.com>
References: <4E0E3978.9050805@ti.com> <1309562142.93488.YahooMailClassic@web161708.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:40690 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752670Ab1GDFsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 01:48:10 -0400
Received: by mail-qw0-f44.google.com with SMTP id 23so4149527qwc.31
        for <linux-omap@vger.kernel.org>; Sun, 03 Jul 2011 22:48:09 -0700 (PDT)
In-Reply-To: <1309562142.93488.YahooMailClassic@web161708.mail.bf1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org

Hong,

On Sat, Jul 2, 2011 at 04:45, hong zhang <henryzhang62@yahoo.com> wrote=
:
> --- On Fri, 7/1/11, Jon Hunter <jon-hunter@ti.com> wrote:
>
>> From: Jon Hunter <jon-hunter@ti.com>
>> Subject: Re: gpio interrupt is not invoked on Panda board
>> To: "hong zhang" <henryzhang62@yahoo.com>
>> Cc: linux-omap@vger.kernel.org
>> Date: Friday, July 1, 2011, 4:17 PM
>> Hi Henry
>>
>> On 7/1/2011 1:10 PM, hong zhang wrote:
>> > List,
>> >
>> > I try to get gpio_191 ping interrupted on panda but
>> never succeeded. What I do is
>> >
>> > 1. set 0x410b on dpm_emu19 register to enable
>> interrupt and wakeup
>> >=A0 =A0=A0=A0on gpio_191
>> > 2. set bit 31 to 1 on GPIO_IRQSTATUS_SET_0 register at
>> 0x4805d034
>> > 3. set bit 31 to 1 on GPIO_IRQWAKEN_0 register at
>> 0x4805d044
>> > 4. set bit 31 to 0 on GPIO_OE register at 0x4805d134
>> (output)
>> > 5. set bit 31 to 1 on GPIO_SETDATAOUT register at
>> 0x4805d194
>> >
>> > Then I expect I should see interrupt on
>> GPIO_IRQSTATUS_0 register at 0x4805d02c. But nothing happens
>> for both output and input (put pin on ground or 1,8v).
>>
>> You will not get an interrupt if you are configuring the
>> gpio as an
>> output (GPIO_OE[31] =3D 0).
>>
> =A0Jon
>
> GPIO_OE[31]=3D0 means output. I should get interrupt for output.

Wrong. As Jon mentioned, no interrupt if the gpio is an output.

> GPIO_OE[31]=3D1 means input, but I do not get interrupt too.

You would be able see the interrupt only if the GPIO191's state
is set/reset by the external peripheral /device which is connected
to GPIO191.

Refer TRM for more details.

-V Charulatha

>
> Do I miss anything here?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
