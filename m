From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Mon, 09 Jan 2012 17:19:52 -0800
Message-ID: <87obucuzev.fsf@ti.com>
References: <20111215213358.26632.44165.stgit@dusk>
	<B5906170F1614E41A8A28DE3B8D1214304DF4E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34980 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932176Ab2AJBT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 20:19:56 -0500
Received: by yenm3 with SMTP id m3so1962690yen.12
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 17:19:55 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304DF4E@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Mon, 9 Jan 2012 05:31:02 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi Paul,
>
> On Fri, Dec 16, 2011 at 03:06:09, Paul Walmsley wrote:
>> Hi,
>> 
>> This is a repost of Tero's PRCM chain handler patch set with a few changes:
>> 
>> - A new mux patch has been added to place hwmod mux entries with
>>   OMAP_DEVICE_PAD_WAKEUP set into the dynamic list
>> 
>> - Several OCP barriers have been added to PRM writes to try to protect
>>   against races between PRM register writes and the MPU
>> 
>> - Kerneldoc documentation has been added
>> 
>> - The pending IRQ test functions have been split into per-SoC versions
>> 
>> - Some patches have been rearranged and merged to avoid churn
>> 
>> - The PRM IRQ handler is now installed on OMAP4
>> 
>
> I found a few (minor) issues with this patch series.
>
> 1. IO and wakeup events are not supported on AM33XX. Since cpu_is_34xx()
> holds true for AM33XX I ended up adding a !cpu_is_am33xx() check in 
> omap3xxx_prcm_init() to bypass the chain handler registration.

> Without such a check we were seeing a crash in USB since USB_CLKCTRL on 
> AM33XX just happens to be at the IRQENABLE_MPU_OFFSET of OMAP3.
> Hope such cpu_is_*() checks are acceptable.

We try to avoid them, especially when we already have existing feature
flag for IO wakeups.

Does something like (completely untested) patch below work for you?

Of course, that implies that that feature flag is initialized correctly
for AM33xx.

Kevin



diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index c1c4d86..87451d9 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -302,7 +302,7 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 
 static int __init omap3xxx_prcm_init(void)
 {
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx() && omap3_has_io_wakeup())
 		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	return 0;
 }
