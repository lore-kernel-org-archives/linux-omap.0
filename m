From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()
Date: Thu, 28 Mar 2013 02:20:27 +0530
Message-ID: <51535B93.2040505@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com> <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com> <87txnw62la.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab3C0Use (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 16:48:34 -0400
In-Reply-To: <87txnw62la.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 01:24 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
>>>
>>> Why?
>>>
>> Because that code belongs to smp_prepare_cpus(). As I said
>> in earlier patches, it was remainder of the pen release code
>> which was borrowed from ARM code initially.
> 
> Sure, but that should be in the changelog.
> 
Yep. Will add above info in changelog.

Regards,
Santosh

