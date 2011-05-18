From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/19] ARM: omap1: convert to using readl/writel instead
 of volatile struct
Date: Wed, 18 May 2011 22:48:11 +0200
Message-ID: <BANLkTikSZGjM5VUjbNXK2y0UC7jVMmbYEA@mail.gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
	<BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44830 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab1ERUsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 16:48:12 -0400
Received: by iwn34 with SMTP id 34so1622335iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 13:48:11 -0700 (PDT)
In-Reply-To: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/5/17 Catalin Marinas <catalin.marinas@arm.com>:
> On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.u=
k> wrote:
>> --- a/arch/arm/mach-omap1/time.c
>> +++ b/arch/arm/mach-omap1/time.c
> ...
>> =A0static inline unsigned long notrace omap_mpu_timer_read(int nr)
>> =A0{
>> - =A0 =A0 =A0 volatile omap_mpu_timer_regs_t* timer =3D omap_mpu_tim=
er_base(nr);
>> - =A0 =A0 =A0 return timer->read_tim;
>> + =A0 =A0 =A0 omap_mpu_timer_regs_t __iomem *timer =3D omap_mpu_time=
r_base(nr);
>> + =A0 =A0 =A0 return readl(&timer->read_tim);
>> =A0}
>
> We should start using the *_relaxed() accessors a bit more to avoid
> the barriers overhead in the standard I/O accessors.

Speaking of which.

The documentation for the *_relaxed calls are in
Documentation/DocBook/deviceiobook.tmpl
and reads like this:

"PCI ordering rules also guarantee that PIO read responses arrive after=
 any
outstanding DMA writes from that bus, since for some devices the
result of a readb
call may signal to the driver that a DMA transaction is complete. In ma=
ny cases,
however, the driver may want to indicate that the next readb call has
no relation to
any previous DMA writes performed by the device. The driver can use
readb_relaxed for these cases, although only some platforms will honor
the relaxed
semantics. Using the relaxed read functions will provide significant pe=
rformance
benefits on platforms that support it. The qla2xxx driver provides
examples of how
to use readX_relaxed. In many cases, a majority of the driver's readX c=
alls can
safely be converted to readX_relaxed calls, since only a few will indic=
ate or
depend on DMA completion."

I guess that in the ARM case "PCI DMA" corresponds to "bus mastering" b=
ut
is this strictly speaking properly describing the semantics of the ARM
*_relaxed operations?

If it isn't a hint on how it should be understood would be much appreci=
ated.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
