From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume support
Date: Thu, 23 Jun 2011 14:57:03 -0700
Message-ID: <871uyk8b4g.fsf@ti.com>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> <874o3g9xmv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob119.obsmtp.com ([74.125.149.245]:52979 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752783Ab1FWV5J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:57:09 -0400
In-Reply-To: <874o3g9xmv.fsf@ti.com> (Kevin Hilman's message of "Thu, 23 Jun
	2011 12:05:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

> Hi Russell,
>
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> Convert sa11x0 to use the generic CPU suspend/resume support, rather
>> than implementing its own version.  Tested on 3430 LDP.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> I tested this on 3430/n900 and 3530/Overo and it worked fine for
> retention, but not for off.
>
> Testing with off-mode, I found the MULTI_CPU path to be broken in
> cpu_suspend (jumping to zero.)  

Problem found, and patch sent to list:

[PATCH] ARM: pm: add v7 suspend/resume functions to v7_processor functions

With that patch, off-mode in both suspend and idle is working on
3430/n900 and 3530/Overo when built in MULTI_CPU mode also.

Kevin
