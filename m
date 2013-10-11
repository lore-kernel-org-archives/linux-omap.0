From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: DRA: DTS: Remove clock-frequency field for cpu timers
Date: Fri, 11 Oct 2013 21:31:09 +0200
Message-ID: <525851FD.9040803@baylibre.com>
References: <1381391413-4361-1-git-send-email-r.sricharan@ti.com> <5256A76F.2080503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40478 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3JKTbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 15:31:13 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn3so1585157wib.11
        for <linux-omap@vger.kernel.org>; Fri, 11 Oct 2013 12:31:12 -0700 (PDT)
In-Reply-To: <5256A76F.2080503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

Hi Sricharan,

On 10/10/2013 15:11, Santosh Shilimkar wrote:
> On Thursday 10 October 2013 03:50 AM, Sricharan R wrote:
>> The arm arch timers frequency are now programmed in the CNTFREQ
>> per-cpu register by the timer code using the secure API [1].
>> So remove the redundant entry from the dts.
>>
>> [1] http://marc.info/?l=linux-omap&m=138139106312786&w=2
>>
>> Cc: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>

I've just applied it for 3.13.

Thanks,
Benoit
