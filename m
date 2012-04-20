From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 20:21:33 +0530
Message-ID: <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	<CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
	<1334926721.2149.40.camel@sokoban>
	<87vckupkxj.fsf@ti.com>
	<1334933002.2149.44.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:52305 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754754Ab2DTOvf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 10:51:35 -0400
Received: by qcsp15 with SMTP id p15so9569707qcs.16
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 07:51:33 -0700 (PDT)
In-Reply-To: <1334933002.2149.44.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Fri, Apr 20, 2012 at 8:13 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Fri, 2012-04-20 at 06:55 -0700, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> [...]
>>
>> >> I tried your branch on gp/emu devices but could not reproduce thi=
s issue.
>> >> My observation is that while resuming, omap_hsmmc.1 eMMC is
>> >> trying to turn on phoenix vaux1 regulator via i2c which fails due
>> >> to controller timeout.
>> >> Note: eMMC is present only on sdp/blaze
>> >
>> > Did you try this with off-mode enabled and did you check the devic=
e
>> > actually goes to off? (see pm_debug/count and verify core off coun=
t is
>> > increasing.) And as said, I was only able to see this problem on a=
 blaze
>> > device, panda works fine. But yes, you are probably right and it i=
s not
>> > an MMC driver issue but I2C.
>>
>> Can you try the patch below? =A0It sounds like the same problem.
>
> Doesn't help with this one. I guess I2C loses context during device o=
ff
> and it is not restored properly.
>
> -Tero
Could you try the following patch

https://lkml.org/lkml/2012/3/30/345
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
