From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH] omap: hwmod: add support to set dmadisable in hwmod framework
Date: Wed, 4 Jul 2012 20:36:12 +0530
Message-ID: <CAAe_U6K7MyQ-Tg41=fCjLvCBxDKhpxckc4qbgjxZnG5bCJVeZg@mail.gmail.com>
References: <1336544794-25644-1-git-send-email-kishon@ti.com>
	<alpine.DEB.2.00.1207040515360.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55962 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752849Ab2GDPGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 11:06:13 -0400
Received: by vcbgb22 with SMTP id gb22so9971948vcb.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 08:06:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040515360.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com

Hi,

On Wed, Jul 4, 2012 at 4:46 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 9 May 2012, Kishon Vijay Abraham I wrote:
>
>> The DMADISABLE bit is a semi-automatic bit present in sysconfig register
>> of some modules. When the DMA must perform read/write accesses, the
>> DMADISABLE bit is cleared by the hardware. But when the DMA must stop for power
>> management, software must set the DMADISABLE bit back to 1.
>>
>> In cases where the ROMCODE/BOOTLOADER uses dma, the hardware clears the
>> DMADISABLE bit (but the romcode/bootloader might not set it back to 1).
>> In order for the kernel to start in a clean state, it is
>> necessary for the kernel to set DMADISABLE bit back to 1 (irrespective
>> of whether it's been set to 1 in romcode or bootloader).
>>
>> During _reset of the (hwmod)device, the DMADISABLE bit is set so that it
>> does not prevent idling of the system. (NOTE: having DMADISABLE to 0,
>> prevents the system to idle)
>>
>> DMADISABLE bit is present in usbotgss module of omap5.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> Thanks for the detailed comments and the kerneldoc.  This one has been
> updated to apply and also to resolve some checkpatch warnings.  Updated
> patch below.

Thanks :-)

-Kishon
