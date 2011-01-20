From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Thu, 20 Jan 2011 14:14:40 +0100
Message-ID: <AANLkTimOc8PcEUaC81M=cYdyfbcJChG9ckriCsxHz-4m@mail.gmail.com>
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
	<87vd1ksq2i.fsf@ti.com>
	<87mxmwr2un.fsf@ti.com>
	<20110119221056.GG4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53889 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab1ATNOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 08:14:41 -0500
Received: by qyj19 with SMTP id 19so1902888qyj.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 05:14:40 -0800 (PST)
In-Reply-To: <20110119221056.GG4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Wed, Jan 19, 2011 at 11:10 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Kevin Hilman <khilman@ti.com> [110119 13:37]:
>> Kevin Hilman <khilman@ti.com> writes:
>>
>> > jean.pihet@newoldbits.com writes:
>> >
>> >> From: Jean Pihet <j-pihet@ti.com>
>> >>
>> >> The new fncpy API is better suited for copying some
>> >> code to SRAM at runtime. This patch changes the ad-hoc
>> >> code to the more generic fncpy API.
>> >>
>> >> Tested OK on OMAP3 in low power modes (RET/OFF)
>> >> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
>> >> Compile tested on OMAP1/2 using omap1_defconfig.
>> >>
>> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> >
>> > Acked-by: Kevin Hilman <khilman@ti.com>
>> >
>> > Boot tested on OMAP1 & OMAP2 as well. =A0Note that neither OMAP1 o=
r OMAP2
>> > has had working suspend/resume for a long time now, so I did not t=
est
>> > suspend/resume.
>>
>> For OMAP2:
>>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>>
>> to test a little more on OMAP2, I just removed the WFI from the
>> low-level code and tested suspend that way. =A0That's enough to be s=
ure
>> the copied code is copied and executed.
>>
>> Worked fine on OMAP2420/n810.
>>
>> For OMAP1, this didn't work and would require more serious hacking o=
n
>> the OMAP1 suspend path, which I currently have no plans to do.
>
> Boots fine on osk5912 and n800 too:
>
> Tested-by: Tony Lindgren <tony@atomide.com>
>

Thanks for testing!

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
