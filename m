From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Tue, 10 Jan 2012 07:13:33 -0800
Message-ID: <878vlfvbdu.fsf@ti.com>
References: <20111215213358.26632.44165.stgit@dusk>
	<B5906170F1614E41A8A28DE3B8D1214304DF4E@DBDE01.ent.ti.com>
	<87obucuzev.fsf@ti.com>
	<B5906170F1614E41A8A28DE3B8D1214304EDAC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38634 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756203Ab2AJPNf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 10:13:35 -0500
Received: by mail-gy0-f170.google.com with SMTP id r1so2014183ghr.15
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 07:13:34 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304EDAC@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Tue, 10 Jan 2012 11:41:08 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi Kevin,
>
> On Tue, Jan 10, 2012 at 06:49:52, Hilman, Kevin wrote:
> [...]
>> >
>> > 1. IO and wakeup events are not supported on AM33XX. Since cpu_is_34xx()
>> > holds true for AM33XX I ended up adding a !cpu_is_am33xx() check in 
>> > omap3xxx_prcm_init() to bypass the chain handler registration.
>> 
>> > Without such a check we were seeing a crash in USB since USB_CLKCTRL on 
>> > AM33XX just happens to be at the IRQENABLE_MPU_OFFSET of OMAP3.
>> > Hope such cpu_is_*() checks are acceptable.
>> 
>> We try to avoid them, especially when we already have existing feature
>> flag for IO wakeups.
>> 
>> Does something like (completely untested) patch below work for you?
>> 
>> Of course, that implies that that feature flag is initialized correctly
>> for AM33xx.
>> 
>> Kevin
>> 
>> 
>> 
>> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> index c1c4d86..87451d9 100644
>> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>> @@ -302,7 +302,7 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
>>  
>>  static int __init omap3xxx_prcm_init(void)
>>  {
>> -	if (cpu_is_omap34xx())
>> +	if (cpu_is_omap34xx() && omap3_has_io_wakeup())
>>  		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
>>  	return 0;
>>  }
>> 
>
> I'll try this out once we have feature flag initialized on AM33xx.
> Can the cpu_is_omap34xx() check be completely dropped in that case?
> Or is there some other reason for retaining it?

The reason it is there is because that function is called from an
initcall.  By default, the kernel builds in support for OMAP2/3/4, so
that initcall will get called on every SoC.  Since it should only happen
for OMAP3, the cpu_is_ check is used.

Kevin


