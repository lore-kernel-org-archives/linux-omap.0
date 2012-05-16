From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX gic control register change
Date: Wed, 16 May 2012 17:53:54 +0530
Message-ID: <4FB39C5A.5080404@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com> <1336989796-26594-4-git-send-email-t-kristo@ti.com> <87zk99ce5q.fsf@ti.com> <4FB3707B.2080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44130 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757231Ab2EPMYB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 08:24:01 -0400
Received: by ghbz22 with SMTP id z22so4357ghb.41
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 05:24:00 -0700 (PDT)
In-Reply-To: <4FB3707B.2080200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Kevin,

On Wednesday 16 May 2012 02:46 PM, Santosh Shilimkar wrote:
> On Wednesday 16 May 2012 03:14 AM, Kevin Hilman wrote:
>> Santosh,
>>
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> GIC distributor control register has changed between CortexA9 r1pX and
>>> r2pX. The Control Register secure banked version is now composed of 2
>>> bits:
>>>      bit 0 == Secure Enable
>>>      bit 1 == Non-Secure Enable
>>> The Non-Secure banked register has not changed. 
>>
>> For those without the r1pX TRM handy, please include what this look like
>> before (presumably 1 bit?)  The changelog and in-code comments should
>> both be enhanced.
>>
> You are right. There was only one bit previously which was used for
> secure/non-secure mode. So ROM over-writes the non-secure bit
> accidentally.
> 
>>> Since the ROM Code is based on the r1pX GIC, the CPU1 GIC restoration
>>> will cause a problem to CPU0 Non-Secure SW.
>>
>> Please describe the problem, so we can better understand the specifics
>> of the workaround.
>>
Below is the updated changelog.

--------------
ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic control
register change

With MPUSS programmed to OSWR(Open Switch retention), GIC context is
lost. On the CPU wakeup paths, ROM code gets executed which will setup
GIC secure configurations and restore the GIC context if it was saved
based on SAR_BACKUP_STATUS.

The ROM Code GIC distributor restoration is split in two parts:
CPU specific register done by each CPU and common register done by
only one CPU. If the GIC Distributor Control Register = 1, the
second CPU will not do the common GIC restoration.

GIC distributor control register has changed between CortexA9 r1pX and
r2pX. The Control Register secure banked version is now composed of 2
bits vs only one bit before r1px:
     bit 0 == Secure Enable
     bit 1 == Non-Secure Enable
Hence the value of Control register will be 3 and not 1 as the r1pX
based ROM code expects. So he CPU1 on it's wakeup ROM code path, will
go to the GIC initialization procedure and will so reset the full GIC
and NS GIC distributor Enable bit will get cleared.
Since the GIC distributor gets disabled in a live system, CPU1 will
hang because the interrupts stop firing.

Workaround for the issue:
     1) Before doing the CPU1 wakeup, CPU0 must disable
        the GIC distributor and wait for it to be enabled.
     2) CPU1 must re-enable the GIC distributor on
        it's wakeup path.

With this procedure, the GIC configuration done between the
CPU0 wakeup and CPU1 wakeup will not be lost but during this
short windows, the CPU0 will not receive interrupts.

The BUG is applicable to only OMAP4460(r2pX) devices.
OMAP4470(r2Px), ROM code is fixed for this BUG.
----------------

Let me know if it clarifies the issue ?

Regards
Santosh

