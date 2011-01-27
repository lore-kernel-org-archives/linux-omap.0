From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v10 18/18] OMAP2, 3: DSS2: Get DSS IRQ from platform device
Date: Thu, 27 Jan 2011 20:53:38 +0530
Message-ID: <AANLkTimrU=TNeX46dK9LZSNxa6QXJZJewKonSWFOSpkv@mail.gmail.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
 <1295850125-21405-19-git-send-email-sumit.semwal@ti.com> <4D4169D1.20001@ti.com>
 <20110127125955.GC26418@n2100.arm.linux.org.uk> <4D416D69.6030200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35856 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751534Ab1A0PX7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 10:23:59 -0500
Received: by mail-bw0-f52.google.com with SMTP id 4so2719678bwz.25
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 07:23:58 -0800 (PST)
In-Reply-To: <4D416D69.6030200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <x0075817@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Raghuveer,

On Thu, Jan 27, 2011 at 6:34 PM, Raghuveer Murthy <x0075817@ti.com> wro=
te:
> On Thursday 27 January 2011 06:29 PM, Russell King - ARM Linux wrote:
>>
>> On Thu, Jan 27, 2011 at 06:19:21PM +0530, Raghuveer Murthy wrote:
>>>>
>>>> + =A0 =A0 =A0 r =3D request_irq(dss_irq,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_is_omap24xx()
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? dss_irq_handler_omap2
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : dss_irq_handler_omap3,
>>>
>>> it should be
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_is_omap24xx()
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? dss_irq_handler_omap3
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: dss_irq_handler_omap2,
>>>
>>> I am seeing a crash on Panda, which gets rectified with this
>>> change. The root cause is access to DSS_IRQSTATUS register in the
>>> dss_irq_handler_omap3 handler, which is not valid for OMAP4.
>>
>> That really doesn't look right. =A0Let me translate the code you've =
just
>> written:
>>
>> =A0 =A0 =A0 =A0if (cpu_is_omap24xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handler =3D dss_irq_handler_omap3;
>> =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handler =3D dss_irq_handler_omap2;
>>
>> Which means: if we have an OMAP24xx device, use the OMAP3 handler,
>> otherwise use the OMAP2 handler. =A0That's got to be wrong.
>>
> I agree, that the logic seems counter-intuitive. I was doing a quick =
test.
>
> However, to =A0keep the correct sequence, the logic inside the respec=
tive
> handlers need to be looked at.
If you see the patch series, this is relevant only for OMAP2,3. OMAP4
related IRQ handling is not yet introduced.
There would a different patch set which should set the correct irq
handler for OMAP4.
>
> Regards,
> Raghuveer
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
