From: Rob Herring <robherring2@gmail.com>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Sat, 01 Oct 2011 15:55:05 -0500
Message-ID: <4E877E29.7000309@gmail.com>
References: <87aa9mm8ts.fsf@ti.com> <87k48pfyvg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50290 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab1JAUzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Oct 2011 16:55:11 -0400
Received: by iaqq3 with SMTP id q3so3216308iaq.19
        for <linux-omap@vger.kernel.org>; Sat, 01 Oct 2011 13:55:11 -0700 (PDT)
In-Reply-To: <87k48pfyvg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 09/30/2011 05:29 PM, Kevin Hilman wrote:
> Hi Arnd,
> 
> Kevin Hilman <khilman@ti.com> writes:
> 
>> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
>> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
>> in the irq/core branch of Thomas' tip tree[3].
>>
>> In the past, I noticed you merged external trees like this to solve
>> dependencies.
>>
>> Could you pull the irq/core branch into your tree to meet this
>> dependency?
> 
> On second thought, since Santosh's branch is the only one with this
> dependency (and we also have a dependency on Russell's devel-stable)
> I'll just build up a branch for Santosh's series that includes
> rmk/devel-stable and tglx/irq-core.
> 

Any new platforms will have a dependency on rmk/devel-stable with the
mach header clean-up. I'll probably have a dependency on tglx's tree as
well.

Rob
