From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 12/32] OMAP: PM: DMA context save/restore for off-mode  support
Date: Fri, 23 Oct 2009 10:57:16 -0700
Message-ID: <87ljj2f0xv.fsf@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<618f0c910910230654l3a7e241esd3f838878424310b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34647 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZJWR5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 13:57:13 -0400
Received: by pwj9 with SMTP id 9so293198pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 10:57:18 -0700 (PDT)
In-Reply-To: <618f0c910910230654l3a7e241esd3f838878424310b@mail.gmail.com> (Venkatraman S.'s message of "Fri\, 23 Oct 2009 19\:24\:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

Venkatraman S <svenkatr@ti.com> writes:

> On Fri, Oct 23, 2009 at 4:39 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> For HS/EMU devices, these additional features are also used:
>>
>> - DMA interrupt disable routine added
>> - Added DMA controller reset to DMA context restore
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

[...]

>> +void omap_dma_disable_irq(int lch)
>> +{
>> + =A0 =A0 =A0 u32 val;
>> +
>> + =A0 =A0 =A0 if (cpu_class_is_omap2()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable interrupts */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(1 << lch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
>> + =A0 =A0 =A0 }
>> +}
>> +
> Just curious - Doesn't it need EXPORT_SYMBOL() ?

No, was not meant to be used by modules.  In fact, when I update this
patch for the chmod problem, I'm going to drop the EXPORT_SYMBOL() for
the context save/restore as well since that is only meant to be called
from the PM core.

> Is this used somewhere ? If yes,
> would be nice to have omap_dma_enable_irq as well

Looking closer, it looks like the user of this was removed in=20
"[PATCH v2 17/32] OMAP3: PM: Fix secure SRAM context save/restore", so =
I'll
remove this function in that patch as well.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
