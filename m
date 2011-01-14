From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Sat, 15 Jan 2011 01:48:35 +0800
Message-ID: <AANLkTikEGVY8SNTWoJc5qrMoNqnd_=5jXnu_tHCVT_KK@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com> <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
 <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com> <36befcf1947882da51ace32cbfb0b922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58847 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693Ab1ANRs4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:48:56 -0500
Received: by qwa26 with SMTP id 26so2964119qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:48:56 -0800 (PST)
In-Reply-To: <36befcf1947882da51ace32cbfb0b922@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sebastien Jan <s-jan@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Sat, Jan 15, 2011 at 1:22 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Seb,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Jan, Sebastien
>> Sent: Friday, January 14, 2011 10:41 PM
>> To: Bryan Wu
>> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Ricardo Salveti de
>> Araujo
>> Subject: Re: Passing mem=3D1G to kernel on Panda, system is unstable=
=2E
>>
>> On Fri, Jan 14, 2011 at 11:09 AM, Bryan Wu <bryan.wu@canonical.com>
>> wrote:
>> > On Fri, Jan 14, 2011 at 1:41 PM, Paul Walmsley <paul@pwsan.com>
>> wrote:
>> >> On Thu, 13 Jan 2011, Bryan Wu wrote:
>> >>
>> >>> On Thu, Jan 13, 2011 at 7:50 AM, Paul Walmsley <paul@pwsan.com>
>> wrote:
>> >>> > On Wed, 12 Jan 2011, Bryan Wu wrote:
>> >>> >
>> >>> > Does the problem also happen if you boot with 'nosmp' on the
>> kernel
>> >>> > command line?
>> >>>
>> >>> Yeah, I think so, since Sebastien reported that 'nosmp' doesn't
>> work either.
>> >>
>> >> Will try to find time to give this a shot. =A0You might want to t=
ry
>> a build
>> >> without CONFIG_SMP set to see if it helps.
>> >>
>> > Thanks a lot, man. Sebastien and I will try to disable CONFIG_SMP
>> with
>> > mainline kernel on Panda.
>>
>> I just tested with the 2.6.37 mainline kernel and Bryan config, and
>> can reproduce the issue with CONFIG_SMP disabled.
> Can you try the patch I sent on the list as well ?

I've applied this patch to our Ubuntu Natty 2.6.35 based kernel, still
can reproduce the issue. But it looks to me this patch makes the
building run longer.

I'm testing the mainline 2.6.37 kernel + your patch here. I will let
you know the result soon.

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
