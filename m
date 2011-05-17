From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/19] ARM: omap1: convert to using readl/writel instead
 of volatile struct
Date: Tue, 17 May 2011 22:59:28 +0100
Message-ID: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61261 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab1EQV73 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 17:59:29 -0400
Received: by iyb14 with SMTP id 14so786320iyb.19
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 14:59:28 -0700 (PDT)
In-Reply-To: <E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org

On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.uk>=
 wrote:
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
=2E..
> =C2=A0static inline unsigned long notrace omap_mpu_timer_read(int nr)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 volatile omap_mpu_timer_regs_t* timer =3D omap=
_mpu_timer_base(nr);
> - =C2=A0 =C2=A0 =C2=A0 return timer->read_tim;
> + =C2=A0 =C2=A0 =C2=A0 omap_mpu_timer_regs_t __iomem *timer =3D omap_=
mpu_timer_base(nr);
> + =C2=A0 =C2=A0 =C2=A0 return readl(&timer->read_tim);
> =C2=A0}

We should start using the *_relaxed() accessors a bit more to avoid
the barriers overhead in the standard I/O accessors.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
