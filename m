From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Sat, 15 Jan 2011 04:26:05 +0800
Message-ID: <AANLkTinXK9Y9YYLn1R5WxDHp0oV2C8yuNjcq+5-XUS+5@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com> <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
 <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com>
 <36befcf1947882da51ace32cbfb0b922@mail.gmail.com> <AANLkTim2dv+cKDsDgPMQFWgEcN_p1Q1_R6HFh3=v44Xk@mail.gmail.com>
 <AANLkTime0otkEhqwFBS4k_aYiU7a8hnbhYQsfE=GBHdr@mail.gmail.com>
 <85fb20a5e00e0a3e5b0abbd56574e36f@mail.gmail.com> <AANLkTi=oYRQdeTMckVpBD7ydfqNVjn4is0YTfZj+nGMf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39496 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab1ANU02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 15:26:28 -0500
Received: by qyk12 with SMTP id 12so3771979qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 12:26:27 -0800 (PST)
In-Reply-To: <AANLkTi=oYRQdeTMckVpBD7ydfqNVjn4is0YTfZj+nGMf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sebastien Jan <s-jan@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Sat, Jan 15, 2011 at 3:06 AM, Bryan Wu <bryan.wu@canonical.com> wrot=
e:
> On Sat, Jan 15, 2011 at 2:55 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>>> -----Original Message-----
>>> From: cooloney@gmail.com [mailto:cooloney@gmail.com] On Behalf Of
>>> Bryan Wu
>>> Sent: Saturday, January 15, 2011 12:11 AM
>>> To: Jan, Sebastien; Santosh Shilimkar
>>> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Ricardo Salveti de
>>> Araujo
>>> Subject: Re: Passing mem=3D1G to kernel on Panda, system is unstabl=
e.
>>>
>>> On Sat, Jan 15, 2011 at 1:48 AM, Jan, Sebastien <s-jan@ti.com>
>>> wrote:
>>> > Hi Santosh,
>>> >
>>> > On Fri, Jan 14, 2011 at 6:22 PM, Santosh Shilimkar
>>> > <santosh.shilimkar@ti.com> wrote:
>>> >>>
>>> >>> I just tested with the 2.6.37 mainline kernel and Bryan config,
>>> and
>>> >>> can reproduce the issue with CONFIG_SMP disabled.
>>> >> Can you try the patch I sent on the list as well ?
>>> >
>>>
>>> Unfortunately, I still can reproduce this issue with mainline 2.6.3=
7
>>> kernel + the patch here:
>> I see.
>> Since it's undefined async abort.... Mostly some clock/module race.
>> I have one more experimental debug patch if you would like to
>> try out.
>>
>> This patch just configures the interconnect space to SO instead of
>> device memory.
>>

I applied this patch to 2.6.37 kernel and try the kernel again, still
got the same bus error with this patch.

for the clock/module race, do you have any simpler test case to
generate this issue than building a whole kernel package.

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
