From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: add fail hook for runtime_pm when bad data is detected
Date: Tue, 10 Dec 2013 09:41:28 -0800
Message-ID: <871u1k8uyf.fsf@linaro.org>
References: <1386121153-32351-1-git-send-email-nm@ti.com>
	<20131205190343.GI26766@atomide.com> <87mwka80vu.fsf@linaro.org>
	<20131210173033.GJ13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40582 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3LJRlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 12:41:31 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so7834017pde.27
        for <linux-omap@vger.kernel.org>; Tue, 10 Dec 2013 09:41:30 -0800 (PST)
In-Reply-To: <20131210173033.GJ13171@atomide.com> (Tony Lindgren's message of
	"Tue, 10 Dec 2013 09:30:34 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Joel F <joelf@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@linaro.org> [131209 08:07]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > * Nishanth Menon <nm@ti.com> [131203 17:40]:
>> >> Due to the cross dependencies between hwmod for automanaged device
>> >> information for OMAP and dts node definitions, we can run into scenarios
>> >> where the dts node is defined, however it's hwmod entry is yet to be
>> >> added. In these cases:
>> >> a) omap_device does not register a pm_domain (since it cannot find
>> >>    hwmod entry).
>> >> b) driver does not know about (a), does a pm_runtime_get_sync which
>> >>    never fails
>> >> c) It then tries to do some operation on the device (such as read the
>> >>   revision register (as part of probe) without clock or adequate OMAP
>> >>   generic PM operation performed for enabling the module.
>> >> 
>> >> This causes a crash such as that reported in:
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=66441
>> >> 
>> >> When 'ti,hwmod' is provided in dt node, it is expected that the device
>> >> will not function without the OMAP's power automanagement. Hence, when
>> >> we hit a fail condition (due to hwmod entries not present or other
>> >> similar scenario), fail at pm_domain level due to lack of data, provide
>> >> enough information for it to be fixed, however, it allows for the driver
>> >> to take appropriate measures to prevent crash.
>> >
>> > Kevin, any comments on this one?
>> 
>> Looks like a good approach to catch these corner cases.
>> 
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>
> Kevin, care to apply this directly?
>
> Acked-by: Tony Lindgren <tony@atomide.com> 

Applied.

Kevin
