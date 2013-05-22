From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Date: Wed, 22 May 2013 10:09:30 +0200
Message-ID: <CAGm1_kvoJ=y5t4SY_3p2Bk1PgU1DOJ39yOBFO83yBo__oLUGuw@mail.gmail.com>
References: <20130515002537.GG5600@atomide.com> <20130515015212.GB3268@animalcreek.com>
 <20130515170734.GI5600@atomide.com> <20130515215028.GA11883@animalcreek.com>
 <5194B2A8.8020608@visionsystems.de> <20130517185620.GF28484@animalcreek.com>
 <CAGm1_ks10f=6aBxWHzd6KxAaFGfnZUNWrQrSZeFwsT3He9r0Ow@mail.gmail.com>
 <20130520220540.GL10378@atomide.com> <87zjvokxf0.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:43176 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab3EVIJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 04:09:52 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx1so909833bkb.40
        for <linux-omap@vger.kernel.org>; Wed, 22 May 2013 01:09:51 -0700 (PDT)
In-Reply-To: <87zjvokxf0.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Yegor Yefremov <yegor_sub1@visionsystems.de>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, May 21, 2013 at 8:20 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>
>> * Yegor Yefremov <yegorslists@googlemail.com> [130517 14:34]:
>>> On Fri, May 17, 2013 at 8:56 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
>>> > On Thu, May 16, 2013 at 12:19:20PM +0200, Yegor Yefremov wrote:
>>> >> On 15.05.2013 23:50, Mark A. Greer wrote:
>>> >> > On Wed, May 15, 2013 at 10:07:35AM -0700, Tony Lindgren wrote:
>>> >
>>> >> >> Mark, do you have some omap3 with no iva (other than am3703) to test the
>>> >> >> idle states with?
>>> >> >
>>> >> > I have an am35xx which isn't supposed to have an IVA so I can test with it
>>> >> > (although, I'm not sure how well the kernel works on the am35xx these days).
>>> >> >
>>> >> > I'm a bit busy today but I'll try booting the am35xx tomorrow and if it
>>> >> > comes up, see what I can figure out.
>>> >>
>>> >> I think this issue is relevant to am3517 as you can see from this
>>> >> thread: http://thread.gmane.org/gmane.linux.ports.arm.omap/97903
>>> >> I could boot only with your patch http://www.spinics.net/lists/arm-kernel/msg168865.html
>>> >>
>>> >> I have such a system running, so if you have any other patches/ideas to test, I would do it.
>>> >
>>> > Yegor, since I've so far been unable to get my am3517evm to fire up, can
>>> > you play around with the 3517 to see if there appears to be iva registers
>>> > that can be read/written to safely?  In particular, can the code that idles
>>> > the iva be run safely on an am3517?
>>>
>>> I'll look into this next week. am3517 and IVA seems to be a really big
>>> mystery. In the TI forum will be stated, there is no IVA:
>>> http://e2e.ti.com/support/arm/sitara_arm/f/791/t/150961.aspx, but TRM
>>> has various appearances of IVA2 registers, but no real
>>> description/explanation of what is IVA and how to eat it.
>>
>> On 3703 it looks like the whole omap3_iva_idle() reset is needed, except
>> for setting the iva2 bootmode to idle. So I'm planning to merge the following
>> patch with just comments update this week unless somebody has a better fix
>> in mind.
>>
>> Regards,
>>
>> Tony
>>
>>
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Tue, 14 May 2013 20:28:15 -0700
>> Subject: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
>>
>> Commit a819c4f1 (ARM: OMAP3: PM: Only access IVA if one exists)
>> changed PM to not access IVA registers on omaps that don't have
>> them. Turns out we still need to idle iva2 as otherwise
>> iva2_pwrdm will stay on and block deeper idle states.
>>
>> It seems that the only part of the reset that may not be needed
>> is the setting of the iva2 boot mode to idle. But as that register
>> seems to be there and is harmless if no iva2 is on the SoC, it's
>> probably safest to do the complete reset.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
