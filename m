From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 16:18:35 +0200
Message-ID: <CANOLnONLVM8zRckvSLE538qHHjQaie7xMmxAhhhn9zvPdYuoVQ@mail.gmail.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
	<CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
	<20120116105949.GG16726@n2100.arm.linux.org.uk>
	<CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
	<20120116131329.GA928@n2100.arm.linux.org.uk>
	<CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
	<WC20120117085444.17057E@terrafix.co.uk>
	<20120117121138.GC11475@arm.com>
	<4F15692D.4070100@ti.com>
	<CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
	<20120117133918.GE11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33155 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754147Ab2AQOSh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 09:18:37 -0500
Received: by lahc1 with SMTP id c1so1546669lah.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 06:18:36 -0800 (PST)
In-Reply-To: <20120117133918.GE11475@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 3:39 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
>> Well the L2 can be configured as inner or outer, so above
>> alone won't work.
>>
>> Boot-loader disabling L2 cache ( all caches) =C2=A0is still right th=
ing
>> and that's what kernel expect.
>>
>> Since the early kernel code can't be patches for A8, may be
>> delaying L2 enabled would work.
>
> Ah, I missed the fact that the L2 is an inner cache on OMAP3+A8.

At least on my OMAP3 board it's not. There is L2 AUX control register
"L2 inner" bit that's always cleared here. I know outer cacheablility
bits in page table descriptors have effect here, we have tested
performace before..


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
