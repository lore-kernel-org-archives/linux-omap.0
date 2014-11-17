From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Mon, 17 Nov 2014 20:33:39 +0530
Message-ID: <546A0E4B.5000901@ti.com>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com> <546635DB.4020202@ti.com> <546636C3.8070202@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbaKQPEJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2014 10:04:09 -0500
In-Reply-To: <546636C3.8070202@zonque.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, d-gerlach@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

On Friday 14 November 2014 10:37 PM, Daniel Mack wrote:
> Hi Sekhar,
> 
> On 11/14/2014 06:03 PM, Sekhar Nori wrote:
>> I think I have asked this before, and I am still not sure why this call 
>> to pm_runtime_get_sync() is needed here. From my testing today, this 
>> does seem to be a a no-op and this call returns from rpm_resume() 
>> because of this check:
>>
>> 	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
>> 	    && dev->power.runtime_status == RPM_ACTIVE)
>> 		retval = 1;
> 
> Yes. IIRC, it was in fact not needed.
> 
>> So, AFAICS, the net effect is an increment of dev->power.usage_count
>> (which is already greater than 0) and its subsequent decrement at the
>> end of the function.
>>
>> After removing this call I did not see any EDMA malfunction as well 
>> (can access MMC/SD just fine after suspend/resume cycle).
>>
>> So, any objections to merging this patch with the attached hunk 
>> applied?
> 
> Looks good to me, we can still add it back later if it turns out to be
> needed.

Okay, thanks for the confirmation.

Regards,
Sekhar
