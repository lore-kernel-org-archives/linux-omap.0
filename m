From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume
 support
Date: Thu, 23 Jun 2011 05:03:39 +0530
Message-ID: <4E027BD3.6030500@ti.com>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> <20110622161021.GB9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34081 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757961Ab1FVXdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 19:33:42 -0400
In-Reply-To: <20110622161021.GB9449@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

On 6/22/2011 9:40 PM, Russell King - ARM Linux wrote:
> A couple of things to point out here:
>
> On Wed, Jun 22, 2011 at 04:16:58PM +0100, Russell King - ARM Linux wrote:
>> -	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
>> -	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
>> -	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
>> -	mrs	r7, cpsr		@ Store current cpsr
>> -	stmia	r8!, {r4-r7}
>
> 1. The User r/w thread and process ID is not saved/restored by Linux over
> context switches, so it doesn't serve any useful purpose to save and
> restore over resume.
>
It will be needed for CPUIDLE I guess.

> 2. Compare the instruction saving and restoring the vector base address
> (see below for the restore code.)
>
That's typo. It should have been mcr. Actually VBAR isn't used on GP
devices but might be used on secure devices. I know that common suspend
code doesn't consider this register. It's fine to keep it that way
and if OMAP needs it, it can save/restored outside common code.

Regards
Santosh
