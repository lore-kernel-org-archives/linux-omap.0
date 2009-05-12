From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: linux-omap pm branch
Date: Tue, 12 May 2009 10:22:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305601567@dbde02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A873958F7E3@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57644 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbZELExB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 00:53:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4C4quod009290
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 23:53:02 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4C4qsdu004997
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 10:22:55 +0530 (IST)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A873958F7E3@dlee01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hunter, Jon
>Sent: Tuesday, May 12, 2009 4:09 AM
>To: Premi, Sanjeev; linux-omap@vger.kernel.org
>Subject: RE: linux-omap pm branch 
>
>Hi Sanjeev,
>
>> > 1). What omap3430 board(s) are being using to validate the pm
>> > branch functionality?
>> 
>> [sp] I believe most common are omap3evm and beagle.
>
>Do you know if we are doing any validation on the SDP3430 or 
>Zoom boards? 

Jon,

Most of the validation on the 3430SDP have been done using a minimal
defconfig, omap_3430sdp_min_defconfig.

>
>Using defconfig for the SDP3430 the kernel failed to boot. I 
>found that this was due to the MUSB driver and SmartReflex. 
>Disabling these allows it to boot.
>
>> > 2). Is there a list of pm features are currently
>> > supported/functional for omap3430? For example, cpuidle,
>> > cpufreq, retention, off-mode, smart-reflex, suspend/restore, etc.
>> 
>> [sp] All of above - though all drivers may not support power
>>      management. Hence you may see some failures scenarios
>>      esp. with off mode.
>
>Off mode does not appear to be working currently on the SDP. 
>It hangs when enabled. Is off-mode stable on any of the boards?

If you tried with the default config (omap_3430sdp_defconfig) it most probably does hang.
Not all drivers do context save/restore today. Only the ones enabled in the minimal defconfig
do.

>
> 
>> > 3). Are there any userspace tools (such as powertop) that are
>> > recommended for monitoring power states?
>> 
>> [sp] You can definitely use powertop.
>
>Is this what everyone is using or is there any other 
>diagnostics available through the proc or sys file-systems? 
>Powertop is fine but I am curious how people are validating 
>which c-states are being entered. 

There is a few debugfs entries which throw count of how many times
a power/clock domain has been in a given state.
Most of the implementation of these counters is in mach-omap2/pm-debug.c

http://marc.info/?l=linux-omap&m=122399525014763&w=2

regards,
Rajendra

>
>Cheers
>Jon
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>