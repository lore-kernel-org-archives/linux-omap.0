From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/9] ARM: OMAP1: PM: Remove bogus fiq_[enable/disable]
 tuple
Date: Wed, 20 Feb 2013 21:44:58 +0530
Message-ID: <5124F682.6060603@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com> <20130220160953.GO5724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934558Ab3BTQNg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 11:13:36 -0500
In-Reply-To: <20130220160953.GO5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 09:39 PM, Tony Lindgren wrote:
> Hi,
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130220 07:21]:
>> On OMAP platform, FIQ is reserved for secure environment only. If at all
>> the FIQ needs to be disabled, it involves going through security
>> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
>>
>> So just get rid of it.
>
> This is not true for all omaps, needs to be checked carefully
> at what point it was made HS omap only. We have at least
> mach-omap1//ams-delta-fiq.c that's being used.
>
This is true for all OMAP2 and onward devices. I assumed it was
the case for OMAP1 as well but that doesn't seems to be the
case. Sorry I didn't look at OMAP1 code carefully.

So this patch can be dropped then.

Regards
Santosh

