From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/9] ARM: OMAP4+: Remove the un-necessary cache flush
 from hotplug code
Date: Thu, 28 Mar 2013 02:17:48 +0530
Message-ID: <51535AF4.3090607@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-5-git-send-email-santosh.shilimkar@ti.com> <87ehf07kfn.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44880 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab3C0Up7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 16:45:59 -0400
In-Reply-To: <87ehf07kfn.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 12:13 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> This was added with intial port where OMAP PM support wasn't existing
>> and only simple WFI based hooks were used.
>>
>> This should have been cleaned up while adding the PM support but some
>> how fall through cracks.
> 
> Changelog describes a bit of history, but does not it's no longer
> needed.
> 
I thought "This should have been cleaned up while adding PM support"
means its no longer needed. At least I meant that way.

Anyway I will just make it explicit.

Regards,
Santosh
