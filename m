From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Git tree updated to v2.6.27, some issues remain
Date: Sat, 11 Oct 2008 04:27:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624A4A@dbde02.ent.ti.com>
References: <20081010120427.GZ3044@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A47@dbde02.ent.ti.com>
 <200810101554.34176.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43310 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYJJW5j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 18:57:39 -0400
In-Reply-To: <200810101554.34176.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

>From: David Brownell [mailto:david-b@pacbell.net]
>Sent: Friday, October 10, 2008 5:55 PM
>To: Pandita, Vikram
>Cc: Steve Sakoman; linux-omap@vger.kernel.org List
>Subject: Re: Git tree updated to v2.6.27, some issues remain
>
>On Friday 10 October 2008, Pandita, Vikram wrote:
>> --- a/arch/arm/mach-omap2/irq.c
>> +++ b/arch/arm/mach-omap2/irq.c
>> @@ -159,7 +159,7 @@ void __init omap_init_irq(void)
>> =A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "Total of %ld interrupts on=
 %d active controller%s\n",
>> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 nr_irqs, nr_banks, nr_banks > 1=
 ? "s" : "");
>>
>> -=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < nr_irqs; i++) {
>> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < NR_IRQS; /*nr_irqs;*/ i++) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_chip(i, &oma=
p_irq_chip);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_handler(i, h=
andle_level_irq);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_flags(i, IRQ=
=46_VALID);
>>
>
>This could explain a problem appearing on every OMAP3 board.
>But not one appearing only on Overo ... especially when the
>same binary works on Beagle.

I saw this problem on LDP.=20

>
>However, that's also very incorrect.  Most of those NR_IRQS
>interrupts are managed by some chip other than the toplevel
>OMAP IRQ controller(s)...

Somewhere for the T2 interrupts following function has to be run:=20
	set_irq_flags(i, IRQF_VALID);

>
>- Dave
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
