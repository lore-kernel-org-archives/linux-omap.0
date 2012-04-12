From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: mm: Flush only CPU local cache instead of all
 cache levels.
Date: Thu, 12 Apr 2012 20:00:26 +0530
Message-ID: <CAMQu2gzdaGOq-dyJ8dZmyL3e+jg0QJj2BfQBsxh=EYkXrQVTsw@mail.gmail.com>
References: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
 <1334230187-21553-3-git-send-email-santosh.shilimkar@ti.com> <20120412132729.GA27744@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38995 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934057Ab2DLOas convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 10:30:48 -0400
Received: by qafi31 with SMTP id i31so4452218qaf.8
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 07:30:46 -0700 (PDT)
In-Reply-To: <20120412132729.GA27744@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Thu, Apr 12, 2012 at 6:57 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Santosh,
>
> just posted a series whose aim is the same, please have a look and
> let's try to merge the two approaches.
>
Sure ...

> On Thu, Apr 12, 2012 at 12:29:47PM +0100, Santosh Shilimkar wrote:
>> The ARMv7 processor setup functions clean and invalidates the
>> cpu cache before enabling MMU. The intention here is to start
>> with clean CPU local cache.
>>
>> But on architectures like Cortex-[A15/A8], this code will end
>> up flushing the L2 cache as well which undesirable and incorrect.
>
> Undesirable agreed, can you define incorrect please ?
>
I was mainly visualizing mainly the hotplug scenario where one CPU
is middle of accessing shared data and other CPU in it's way up path
flush L1 + L2. After thinking bit more, looks like it might work withou=
t
issues so incorrect may not be write word.

>> The setup functions are used in CPU hotplug scenario's too and
>> hence flushing all cache levels should be avoided.
>>
>
> Agreed, but this is also true for __cpu_disable() if we consider hotp=
lug into
> the picture. The difference is that __cpu_disable is not v7 specific
> that's what I tried to address with my series, a more generic (and of=
 course
> arguable) approach.
>
>> Fix this code by restricting the cache flush to local cpu
>> cache or L1.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> =A0arch/arm/mm/proc-v7.S | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index f1c8486..96cfc31 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -172,7 +172,8 @@ __v7_ca15mp_setup:
>> =A0__v7_setup:
>> =A0 =A0 =A0 adr =A0 =A0 r12, __v7_setup_stack =A0 =A0 =A0 =A0 =A0 @ =
the local stack
>> =A0 =A0 =A0 stmia =A0 r12, {r0-r5, r7, r9, r11, lr}
>> - =A0 =A0 bl =A0 =A0 =A0v7_flush_dcache_all
>> + =A0 =A0 mov =A0 =A0 r0, #0x1
>> + =A0 =A0 bl =A0 =A0 =A0v7_flush_dcache_by_level
>
> I did not post my patch here that is similar but basically the idea h=
ere is
> to clean/invalidate up to Level of Unification Inner Shareable.
>
ok.

> That hardcoded 0x1 must be explained, it might work for most of the v=
7 systems
> but I think it should be generalized.
>
Agree. I just looked at current V7 processors and thought that #1 shoul=
d be
fine.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
