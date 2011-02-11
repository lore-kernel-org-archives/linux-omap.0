From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP fixups
Date: Fri, 11 Feb 2011 16:17:48 +0000
Message-ID: <AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
References: <20110209142211.GA11460@n2100.arm.linux.org.uk>
	<20110210125624.GA3652@n2100.arm.linux.org.uk>
	<AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
	<AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
	<AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
	<20110210191125.GA12582@n2100.arm.linux.org.uk>
	<AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
	<20110211101345.GA23785@n2100.arm.linux.org.uk>
	<AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com>
	<20110211160500.GA31529@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60920 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377Ab1BKQRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:17:50 -0500
Received: by ewy5 with SMTP id 5so1432314ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 08:17:49 -0800 (PST)
In-Reply-To: <20110211160500.GA31529@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 4:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 11, 2011 at 10:52:17AM +0000, Dave Martin wrote:
>> On Fri, Feb 11, 2011 at 10:13 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Feb 11, 2011 at 09:33:56AM +0000, Dave Martin wrote:
>> >> Agreed -- actually, I suspected we might need to support this. =A0=
But I
>> >> don't think solving this problem (=3D keeping the fixup implement=
ation
>> >> in memory and enhancing the module loader) solved the
>> >> fixups-referencing-sections-discarded-from-vmlinux problem. =A0Th=
ese
>> >> seem to be two separate issues. =A0I am filing to understand some=
thing?
>> >
>> > They are separate, but related issues. =A0They both ultimately hav=
e the
>> > same cause - the placement of the spinlock code inline rather than
>> > out of line, resulting in fixups appearing all over the place rath=
er
>> > than just in kernel/spinlock.o.
>>
>> I guess what I want to understand is whether I (or someone) still
>> need(s) to sort out the vmlinux.lds issue.
>
> Yes we do - if you build your kernel you should find that your link
> fails because of discarded sections being referenced.

Yep -- I'm still applying my original patch to work around that, but
it sounds like I need to tidy that up.  Can you elaborate on what you
meant by defining a "KEEP_EXIT" macro to handle this?

>
>> If we're keeping inline spinlocks (I currently assume "yes"), then t=
he
>> vmlinux.lds issue still needs fixing. =A0Is that correct? =A0However=
, if
>> we get rid of inline spinlocks we won't have the problem, though the=
re
>> may be some performance impact -- hard to judge how significant.
>
> I don't see that we can get rid of inline spinlocks - it's controlled
> by stuff external to the arch.

That's fine -- just wanted to make sure I had the right understanding.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
