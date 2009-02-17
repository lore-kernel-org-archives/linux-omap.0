From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Tue, 17 Feb 2009 17:33:07 +0200
Message-ID: <499AD8B3.5090601@gmail.com>
References: <96DA7A230D3B2F42BA3EF203A7A1B3B5012AB15CC9@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:37155 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZBQPdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 10:33:13 -0500
Received: by bwz5 with SMTP id 5so4203983bwz.13
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 07:33:10 -0800 (PST)
In-Reply-To: <96DA7A230D3B2F42BA3EF203A7A1B3B5012AB15CC9@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Curran, Dominic" <dcurran@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>

Curran, Dominic said the following on 02/17/2009 04:27 PM:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>> Sent: Tuesday, February 17, 2009 2:12 AM
>> To: Curran, Dominic
>> Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
>> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
>>     
>> Would a solution as follows be appropriate?
>> in arch/arm/mach-omap2/Kconfig:
>>  config MACH_OMAP_ZOOM2
>>            bool "OMAP3 ZOOM2 board"
>>            depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> +        select TWL4030_CORE if VIDEO_OMAP3
>>
>> A similar strategy has been implemented for N800, albeit for other
>> peripherals.
>>     
>
> If 'reverse dependencies' set the symbol and its dependencies I would say this would be a good solution, but unfortunately it does not.
> The documentation for reverse dependencies warns:
>
>  107         select should be used with care. select will force
>  108         a symbol to a value without visiting the dependencies.
>  109         By abusing select you are able to select a symbol FOO even
>  110         if FOO depends on BAR that is not set.
>  111         In general use select only for non-visible symbols
>
> Since TWL4030 has dependencies then I don't think this is appropriate
Mach-omap && video_omap3 depends on twl4030 and twl4030 is not reverse
dependent on mach-omap. twl4030 is dependent on i2c - I believe based on
drivers/mfd/Kconfig how do we handle this? Maybe a select of i2c is
appropriate there? or how about:

+        select TWL4030_CORE if VIDEO_OMAP3
+        select  I2C if TWL4030_CORE


You may want to see arch/arm/mach-omap2/Kconfig -> MACH_NOKIA_N800. I
think we have a similar condition there with CBUS and VIDEO_TCM825X I
think..

my 2cents: i like select better than #ifdef ;).. but then, that is just
me :)..

Regards,
Nishanth Menon
