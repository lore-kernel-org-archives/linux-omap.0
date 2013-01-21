From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 07/10] ARM: OMAP5: clock data: Add OMAP54XX full clock
 tree and headers
Date: Mon, 21 Jan 2013 13:44:15 +0530
Message-ID: <50FCF8D7.1010609@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-8-git-send-email-santosh.shilimkar@ti.com> <20130118171912.GD15361@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab3AUINQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 03:13:16 -0500
In-Reply-To: <20130118171912.GD15361@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

On Friday 18 January 2013 10:49 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130118 07:30]:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Add the clock tree related data for OMAP54xx platforms.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> [santosh.shilimkar@ti.com: Generated es2.0 data]
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> As mentioned in the summary, this patch will be updated once the
>> movement of clock data to drivers/clock is clear.
>
> Yes let's first fix up the issues prevent us from moving all the
> cclock*_data.c files to live under drivers/clock/omap.
>
> It seems that fixing this issue boils down to rearranging some
> clock related headers in arch/arm/mach-omap2, and then populating
> some of the clock data dynamically. Or am I missing something?
>
Am not sure of all the dependencies.  Since clock data is using the low
level prm/cm APIs, all those needs to be exported some how to move
the data. Paul can comment better on it.

Regards,
Santosh

