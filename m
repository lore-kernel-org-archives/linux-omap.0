From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
Date: Sun, 17 Jul 2011 21:38:56 +0800
Message-ID: <CAF+7xW=DKMi9doKm0XH0+EvJLX0gzUE0_TqrZNrqHqvjuSeHdA@mail.gmail.com>
References: <1309251943.3984.1.camel@phoenix> <87boxi2eep.fsf@ti.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36180 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1GQNjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Jul 2011 09:39:17 -0400
In-Reply-To: <87boxi2eep.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/6/28 Kevin Hilman <khilman@ti.com>:
> Axel Lin <axel.lin@gmail.com> writes:
>
>> The gpio-omap driver has been converted to use generic IRQ chip.
>> Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.
>>
>> =A0 LD =A0 =A0 =A0vmlinux
>> drivers/built-in.o: In function `omap_mpuio_alloc_gc':
>> drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_gen=
eric_chip'
>> drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_gen=
eric_chip'
>> drivers/built-in.o: In function `omap_gpio_show_rev':
>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_cl=
r_bit'
>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_se=
t_bit'
>> make: *** [vmlinux] Error 1
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Thanks, I have a fix for this already queued for v3.0-rc3 series:
>
> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-omap&m=3D130749135312468&w=
=3D2
>
Hi,
Seems this patch is not upstream.
I still have the same build error with  [linux-next: Tree for July 16].

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
