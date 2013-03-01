From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 15/15] ARM: OMAP5: PM: handle device instance for for
 coldreset
Date: Fri, 1 Mar 2013 18:39:20 +0530
Message-ID: <5130A880.5080703@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-16-git-send-email-santosh.shilimkar@ti.com> <20130301130430.GA19894@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3CANHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 08:07:52 -0500
In-Reply-To: <20130301130430.GA19894@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Friday 01 March 2013 06:34 PM, Nishanth Menon wrote:
> $subject - warm reset
> 
ok
> On 17:41-20130301, Santosh Shilimkar wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> OMAP5 and OMAP4 have different device instance offsets.
>>
>> So to handle them properly, use a runtime detected instance offset
>> Other bit offsets and register offsets remained constant.
>>
>> Creating a new function is not really worthwhile here as the logic
>> will be replicated without much benefit.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> santosh.shilimkar@ti.com: Refreshed patch against 3.8
> [santosh.shilimkar@ti.com: Refreshed patch against 3.8]
> ?
#include "soc.h" :)

