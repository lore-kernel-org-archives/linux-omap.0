From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: wakeupgen: AM43x adaptation
Date: Tue, 22 Oct 2013 19:23:10 +0530
Message-ID: <52668346.7010608@ti.com>
References: <1381302753-7045-1-git-send-email-afzal@ti.com> <525922CE.6080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab3JVNxh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Oct 2013 09:53:37 -0400
In-Reply-To: <525922CE.6080200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Hi Tony,

On Saturday 12 October 2013 03:52 PM, Afzal Mohammed wrote:
> On Wednesday 09 October 2013 12:42 PM, Afzal Mohammed wrote:

>> AM43x has 224 interrupts and 7 banks, make it as maximum values. Keep
>> default values as earlier, if am43x is detected, update interrupts and
>> banks accordingly.
>>
>> Also AM43x has only one cpu, ensure that clearing bitmask at wakeupgen
>> is done only for the single existing cpu, existing code assumes that
>> there are two cpu's.
>>
>> If bitmask is cleared in wakeupgen for the nonexistent second cpu,
>> an imprecise abort happens as soon as Kernel switches to user space.
>> It was rootcaused by Sekhar Nori <nsekhar@ti.com>.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> ---
>>
>> v2:
>> 1. make AM43x adaptation such that changes required for new SoC addition is less
>> 2. avoid usage of am43x local variable, use soc_is_am43xx() instead
> 
> Seems you missed this one, please consider this for the coming merge
> window. Without this AM43x would not boot to prompt.

Ping

Regards
Afzal

