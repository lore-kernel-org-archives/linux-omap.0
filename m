From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
Date: Mon, 17 Jan 2011 12:12:55 +0000
Message-ID: <AANLkTikrgOLJ0bj_V23i-RM_wYa_4dDTXb_RaPY8Cr8v@mail.gmail.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
	<AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
	<20110117103739.GA18626@n2100.arm.linux.org.uk>
	<20110117105332.GC18626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60482 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab1AQMM4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:12:56 -0500
Received: by iyj18 with SMTP id 18so4546945iyj.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 04:12:56 -0800 (PST)
In-Reply-To: <20110117105332.GC18626@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 17 January 2011 10:53, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 17, 2011 at 10:37:39AM +0000, Russell King - ARM Linux wr=
ote:
>> 3. Do we always need a dsb prior to a sev? =C2=A0Maybe the SPEAR pat=
ches need
>> another review to determine how they're using sev()?
>
> FYI, this is how the SPEAR patches use sev():
>
> | +static void __init wakeup_secondary(void)
> | +{
> | + =C2=A0 =C2=A0 /* nobody is to be released from the pen yet */
> | + =C2=A0 =C2=A0 pen_release =3D -1;
> | +
> | + =C2=A0 =C2=A0 /*
> | + =C2=A0 =C2=A0 =C2=A0* Write the address of secondary startup into=
 the system-wide
> | + =C2=A0 =C2=A0 =C2=A0* location (presently it is in SRAM). The Boo=
tMonitor waits
> | + =C2=A0 =C2=A0 =C2=A0* for this register to become non-zero.
> | + =C2=A0 =C2=A0 =C2=A0* We must also send an sev to wake it up
> | + =C2=A0 =C2=A0 =C2=A0*/
> | + =C2=A0 =C2=A0 __raw_writel(BSYM(virt_to_phys(spear13xx_secondary_=
startup)),
> | + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __io_address(SPEAR13XX_SYS_LOCATION));
> | +
> | + =C2=A0 =C2=A0 mb();
> | +
> | + =C2=A0 =C2=A0 /*
> | + =C2=A0 =C2=A0 =C2=A0* Send a 'sev' to wake the secondary core fro=
m WFE.
> | + =C2=A0 =C2=A0 =C2=A0*/
> | + =C2=A0 =C2=A0 sev();
> | +}
>
> so the dsb() is inside mb(), before the outer sync call.

BTW, don't we need some cache flushing for the pen_release?

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
