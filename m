From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 14:02:44 +0300
Message-ID: <AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	 <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	 <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	 <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36504 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0ERLCt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:02:49 -0400
Received: by fxm10 with SMTP id 10so930602fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 04:02:46 -0700 (PDT)
In-Reply-To: <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 11:05 AM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> On Mon, May 17, 2010 at 2:51 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So currently (v2.6.33), before sending a read-olny buffer (TO_DEVICE=
),
>> we do dmac_flush_range (should be clean, but whatever) and before
>> sending a write-only (FROM_DEVICE), we do dmac_inv_range.
>>
>> On v2.6.33 the same could be achieved with only dma_map_* functions,
>> but on v2.6.34 that's not the case.
>
> Sorry, I didn't completely follow you here, let's take a look at the
> mapping code:
>
> ENTRY(v7_dma_map_area)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0add =C2=A0 =C2=A0 r1, r1, r0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0teq =C2=A0 =C2=A0 r2, #DMA_FROM_DEVICE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0beq =C2=A0 =C2=A0 v7_dma_inv_range
> =C2=A0 =C2=A0 =C2=A0 =C2=A0b =C2=A0 =C2=A0 =C2=A0 v7_dma_clean_range
> ENDPROC(v7_dma_map_area)
>
> DMA_FROM_DEVICE will get the cache invalidated and then cleaned,
> and DMA_BIDIRECTIONAL/DMA_TO_DEVICE will get the cache only
> cleaned.

No, when DMA_FROM_DEVICE, only v7_dma_inv_range is executed (see the
mov pc, lr at the end).

> Unfortunately I don't have a setup right now to test this, but the co=
de
> seems to be ok for our needs, don't you think ?

But yeah, actually that fits our needs; calling the dma_map only,
while still wrong, will give us the same behavior we have right now
(v2.6.33).

So my table was wrong, it's actually:

in: begin BIDI:
       dma_clean_range

out: begin FROM_DEV:
       dma_inv_range

out: end FROM_DEV:
       dma_inv_range

in: end BIDI:
       dma_inv_range

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
