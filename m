From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Tue, 15 Feb 2011 10:20:57 -0800
Message-ID: <AANLkTin3u=2+sbXes-ZvzDM3cRQgJ-Xc7fa8rUZ8Da=r@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
	<AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
	<20110215105050.GA11199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31913 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab1BOSVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 13:21:15 -0500
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id p1FILCfo026918
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 10:21:13 -0800
Received: from gxk25 (gxk25.prod.google.com [10.202.11.25])
	by kpbe14.cbf.corp.google.com with ESMTP id p1FILBtp027899
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 10:21:11 -0800
Received: by gxk25 with SMTP id 25so245759gxk.37
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 10:21:11 -0800 (PST)
In-Reply-To: <20110215105050.GA11199@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 2:50 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 14, 2011 at 08:11:23PM -0800, Colin Cross wrote:
>> Even with a cache flush, cpu_resume_turn_on_mmu fails because the pa=
ge
>> table modification, done with the cache off, ends up in memory, but
>> the L2 contains the old value. =A0When the MMU and cache are enabled=
,
>> the 1:1 mapping disappears. =A0The page table would need to be
>> invalidated during suspend.
>>
>> I can avoid the problem entirely by leaving the MMU on and skipping
>> cpu_resume when the CPU does not go through reset.
>
> If you're not losing CPU state, what's the point in calling the suspe=
nd
> function? =A0It's purpose is to save CPU state ready for the CPU goin=
g to
> sleep and losing power, and restoring that state when the CPU wakes u=
p
> sometime later.

The CPU is going to a state where it may lose power (if the other CPU
enters the same state), or it may get an interrupt before the other
CPU powers down and wake back up again.  In the second case, it has
already called cpu_suspend, so it either needs to return without
calling cpu_resume (which I have working), or cpu_suspend/cpu_resume
needs to work with the L2 cache enabled.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
