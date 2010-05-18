From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 11:05:23 +0300
Message-ID: <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	<AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	<AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	<AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:43543 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab0ERIFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 04:05:44 -0400
Received: by gxk27 with SMTP id 27so3225163gxk.1
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 01:05:43 -0700 (PDT)
In-Reply-To: <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 17, 2010 at 2:51 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So currently (v2.6.33), before sending a read-olny buffer (TO_DEVICE),
> we do dmac_flush_range (should be clean, but whatever) and before
> sending a write-only (FROM_DEVICE), we do dmac_inv_range.
>
> On v2.6.33 the same could be achieved with only dma_map_* functions,
> but on v2.6.34 that's not the case.

Sorry, I didn't completely follow you here, let's take a look at the
mapping code:

ENTRY(v7_dma_map_area)
	add	r1, r1, r0
	teq	r2, #DMA_FROM_DEVICE
	beq	v7_dma_inv_range
	b	v7_dma_clean_range
ENDPROC(v7_dma_map_area)

DMA_FROM_DEVICE will get the cache invalidated and then cleaned,
and DMA_BIDIRECTIONAL/DMA_TO_DEVICE will get the cache only
cleaned.

Unfortunately I don't have a setup right now to test this, but the code
seems to be ok for our needs, don't you think ?

Thanks,
Ohad.
