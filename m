From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 07 Mar 2011 13:35:19 -0800
Message-ID: <87d3m2397s.fsf@ti.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
	<7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42343 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754763Ab1CGVfa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 16:35:30 -0500
Received: by yxl31 with SMTP id 31so2439823yxl.27
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 13:35:28 -0800 (PST)
In-Reply-To: <7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 4 Mar 2011 23:08:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Dave,
>> -----Original Message-----
>> From: Dave Martin [mailto:dave.martin@linaro.org]
>> Sent: Friday, March 04, 2011 11:05 PM
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: patches@linaro.org; Tony Lindgren; Santosh Shilimkar; Jean
>> Pihet; Kevin Hilman; linux-omap@vger.kernel.org; Nicolas Pitre;
>> linaro-dev@lists.linaro.org
>> Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2
>> compatibility fixes
>>
>> On Fri, Mar 4, 2011 at 3:33 PM, Dave Martin <dave.martin@linaro.org>
>> wrote:
>> > This set of patches, along with some other patches under
>> > discussion on alkml, should enable omap3 and omap4 kernels to be
>> > built with CONFIG_THUMB2_KERNEL.
>> >
>> > This patch set builds on recent cleanup done by the omap
>> > maintainers.
>> >
>> > At least some of this code definitely works, most features have
>> > been tested successfully. =C2=A0Further testing, especially of Thu=
mb-2
>> > behaviour, is still welcome.
>> >
>> > In particular, I still have no Ack/Tested-by on the following
>> > patches, so it would be great if anyone who has an opportunity
>> > to do a final review / re-test can do so.
>> >
>> > =C2=A0* ARM: omap3: Convert END() to ENDPROC() for correct linkage=
 with
>> CONFIG_THUMB2_KERNEL
>> > =C2=A0* ARM: omap3: Thumb-2 compatibility for sram34xx.S
>> > =C2=A0* ARM: omap3: Thumb-2 compatibility for sleep34xx.S
>>
>> Following up on this, it looks like I have some locally-recorded
>> acks
>> which didn't make it into my posting ...
>>
>> The one patch I currently have no feedback on is this one:
>>
>>   * ARM: omap4: Provide do_wfi() for Thumb-2
>>
> You can drop this one since do_wfi()  won't be needed
> anymore after my recent series.
>
> http://www.spinics.net/lists/linux-omap/msg46495.html

Santosh,

I'm planning to queue/merge Dave's series as-is for 2.6.39, since it ha=
s
already received significan review & testing.

When you update your OMAP4 series, feel free to drop it as needed.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
