From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/17] omap4: pm: Add GIC save/restore support
Date: Thu, 03 Mar 2011 09:03:39 -0800
Message-ID: <87vd00qgpg.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
	<8739n55f75.fsf@ti.com>
	<000b275e5d210abd5dec6c09c5508734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42780 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758464Ab1CCRE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 12:04:28 -0500
Received: by mail-qy0-f179.google.com with SMTP id 7so1080619qyk.10
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 09:04:27 -0800 (PST)
In-Reply-To: <000b275e5d210abd5dec6c09c5508734@mail.gmail.com> (Santosh
	Shilimkar's message of "Thu, 3 Mar 2011 21:59:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@ti.com]
>> Sent: Thursday, March 03, 2011 4:00 AM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 08/17] omap4: pm: Add GIC save/restore support
> [...]
>
>> > @@ -67,6 +82,17 @@ struct omap4_cpu_pm_info {
>> >
>> >  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>> >
>> > +/* Helper functions */
>> > +static inline void sar_writel(u32 val, u32 offset, u8 idx)
>> > +{
>> > +	__raw_writel(val, sar_ram_base + offset + 4 * idx);
>> > +}
>>
>> aha, this is what I was thinking of in the earlier SAR patch.
>>
>> Something like this should be part of the SAR code, not here.
>>
> If you remember during the internal review, this helpers
> are added to improve the readability and they are inline
> functions. Same is the case with wakeupgen save code.
>
> If you move this code to SAR file and GIC helper
> to gic file, the save routine will become highly
> un-optimal.
>
> In General Save is like below.
> 	Read_Harfware_register()
> 	Write_it_sar_location()
>
> This happens for every GIC and wakeupgen
> registers and hence moving this across files
> and calling them from there is going add un-necessary
> stack overhead.
>
> I already got rid-off the global address pointers. I will
> get those now using omap4_get_*_base() and store it for
> local use in the file.

OK, that should be fine.

Thanks,

Kevin

