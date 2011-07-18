From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
Date: Mon, 18 Jul 2011 07:52:07 -0700
Message-ID: <87aacbmyjs.fsf@ti.com>
References: <1309251943.3984.1.camel@phoenix> <87boxi2eep.fsf@ti.com>
	<CAF+7xW=DKMi9doKm0XH0+EvJLX0gzUE0_TqrZNrqHqvjuSeHdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF+7xW=DKMi9doKm0XH0+EvJLX0gzUE0_TqrZNrqHqvjuSeHdA@mail.gmail.com>
	(Axel Lin's message of "Sun, 17 Jul 2011 21:38:56 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: axel.lin@gmail.com
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Axel Lin <axel.lin@gmail.com> writes:

> 2011/6/28 Kevin Hilman <khilman@ti.com>:
>> Axel Lin <axel.lin@gmail.com> writes:
>>
>>> The gpio-omap driver has been converted to use generic IRQ chip.
>>> Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.
>>>
>>> =C2=A0 LD =C2=A0 =C2=A0 =C2=A0vmlinux
>>> drivers/built-in.o: In function `omap_mpuio_alloc_gc':
>>> drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_ge=
neric_chip'
>>> drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_ge=
neric_chip'
>>> drivers/built-in.o: In function `omap_gpio_show_rev':
>>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_c=
lr_bit'
>>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_s=
et_bit'
>>> make: *** [vmlinux] Error 1
>>>
>>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>>
>> Thanks, I have a fix for this already queued for v3.0-rc3 series:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://marc.info/?l=3Dlinux-omap&m=3D1307=
49135312468&w=3D2
>>
>=20
> Seems this patch is not upstream.
> I still have the same build error with  [linux-next: Tree for July 16=
].

Hmm, you're right.  Tony hasn't queued that fix yet.

Tony?

Kevin
