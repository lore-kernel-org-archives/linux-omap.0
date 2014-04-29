From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH] ARM: dts: am33xx: fix DMA support for the second USB
 interface
Date: Tue, 29 Apr 2014 10:01:21 +0530
Message-ID: <535F2B19.7020300@ti.com>
References: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com> <535E64EF.2020108@ti.com> <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbaD2Ebr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 00:31:47 -0400
In-Reply-To: <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 4/28/2014 9:47 PM, Yegor Yefremov wrote:
> On Mon, Apr 28, 2014 at 4:25 PM, George Cherian <george.cherian@ti.com> wrote:
>> On 4/28/2014 2:07 PM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> This patch creates unique DMA channels for the second USB
>>> interface, otherwise the second USB interface is not usable
>>> at all.
>> MUSB_DMA_NUM_CHANNELS is 15, so if you pass  any dma-names > 15 (>
>> rx15/tx15),
>> the dma_controller_create in musb_core.c fails and it falls back to PIO
>> mode.
> What's the proper fix for the DMA issue?
I could not understand what issue you are referring to.
In my setup I use both BBB and BBW (Beagle Bone Black/White)with one USB 
in host (USB1)
and one USB in gadget (USB0). I dont see any issues with DMA.

Can you be more specific?
>
> Yegor


-- 
-George

