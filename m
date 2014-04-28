From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] ARM: dts: am33xx: fix DMA support for the second USB interface
Date: Mon, 28 Apr 2014 18:17:29 +0200
Message-ID: <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
References: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com> <535E64EF.2020108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56898 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbaD1QRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 12:17:49 -0400
In-Reply-To: <535E64EF.2020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Apr 28, 2014 at 4:25 PM, George Cherian <george.cherian@ti.com> wrote:
> On 4/28/2014 2:07 PM, yegorslists@googlemail.com wrote:
>>
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch creates unique DMA channels for the second USB
>> interface, otherwise the second USB interface is not usable
>> at all.
>
> MUSB_DMA_NUM_CHANNELS is 15, so if you pass  any dma-names > 15 (>
> rx15/tx15),
> the dma_controller_create in musb_core.c fails and it falls back to PIO
> mode.

What's the proper fix for the DMA issue?

Yegor
