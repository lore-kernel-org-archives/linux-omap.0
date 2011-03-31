From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 02/21] OMAP4: Use WARN_ON() instead of BUG_ON()
 with graceful exit
Date: Thu, 31 Mar 2011 20:09:54 +0530
Message-ID: <4D94923A.5060006@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>	<1301304157-2466-3-git-send-email-santosh.shilimkar@ti.com>	<20110328205323.GD30616@atomide.com> <4D943CB8.70002@ti.com> <87wrjfmlnp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59491 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab1CaOkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 10:40:11 -0400
Received: by mail-vx0-f173.google.com with SMTP id 41so2800595vxb.18
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 07:40:08 -0700 (PDT)
In-Reply-To: <87wrjfmlnp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On 3/31/2011 7:34 PM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> On 3/29/2011 2:23 AM, Tony Lindgren wrote:
>>> * Santosh Shilimkar<santosh.shilimkar@ti.com>   [110328 02:20]:
>

[...]

>> L2 cache is no problem and kernel can boot without L2 cache
>> support. I agree with you on interrupt controller init though.
>>
>> Will drop the interrupt related checks from this patch.
>>
>> Kevin, Are you ok with it ?
>
> In general, BUG should only be used when the kernel really can not
> possibly continue[1].  I suppose inability to map the GIC falls into
> that category.
>
Thanks. Will drop GIC ones.

Regards
Santosh
