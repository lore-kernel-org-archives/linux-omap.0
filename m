From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/9] ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable]
 tuple
Date: Thu, 28 Mar 2013 00:32:13 +0530
Message-ID: <51534235.6030506@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-4-git-send-email-santosh.shilimkar@ti.com> <874nfw8zb7.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39619 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623Ab3C0TA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 15:00:28 -0400
In-Reply-To: <874nfw8zb7.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 12:06 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On OMAP platform, FIQ is reserved for secure environment only. If at all
>> the FIQ needs to be disabled, it involves going through security
>> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
>>
>> So just get rid of it.
> 
> What about GP devices?
> 
On GP devices as well FIQ isn't available for non-secure software since
its marked secure only in ROM initialization. There has been heavy
debate on this since some customers wanted to have it available
for debug purpose but some other work-around was done rather
than opening it for public.

Regards,
Santosh

