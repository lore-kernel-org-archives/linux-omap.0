From: Raghuveer Murthy <x0075817@ti.com>
Subject: Re: [PATCH v1 0/3] OMAP: DSS2: Fix for DISPC core functional clock
 divider
Date: Thu, 3 Mar 2011 21:04:56 +0530
Message-ID: <4D6FB520.20407@ti.com>
References: <1299152316.2615.91.camel@deskari> <1299158197.2615.117.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab1CCPea (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 10:34:30 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p23FYReM013274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 09:34:29 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p23FYQe0029222
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 21:04:27 +0530 (IST)
In-Reply-To: <1299158197.2615.117.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 03 March 2011 06:46 PM, Valkeinen, Tomi wrote:
> On Thu, 2011-03-03 at 15:25 +0530, Raghuveer Murthy wrote:
>> OMAP4 has 2 LCD channels and corresponding DISPC_DIVISOR1 and DISPC_DIVISOR2
>> registers to configure the pixel clock frequency, for the respective LCD
>> displays.
>>
>> There is also DISPC_DIVISOR register, which by default has the ENABLE bit
>> set to zero, for backward compatibility mode. Hence the logical clock divider of
>> DISPC_DIVISOR1.LCD, gets used for core func clk configuration. The default value
>> of DISPC_DIVISOR1.LCD is 4.
>>
>> If only the secondary LCD is enabled, at high pixel resolutions the core clk
>> lags behind the pixel clock, causing stair-step effect (diagonal lines with
>> tearing) on the display.
>>
>> Hence DISPC_DIVISOR.ENABLE is set to 1, and the core functional clock is set
>> independently and exclusively in DISPC_DIVISOR.LCD.
>
> I think this patch set is ok. However, it doesn't apply with the latest
> master branch from DSS tree, some quite trivial conflicts with dss
> features. Can you rebase and post it?
>
> Also, please send patches to my ti.com address, not iki.fi address.
>
>   Tomi
>
>
Hi Tomi,

Resent the after re-basing.

Regards,
Raghuveer

