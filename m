From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 09:32:01 -0600
Message-ID: <BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com>
 <201104151640.01040.arnd@arndb.de> <20110415152643.GC4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34969 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab1DOPcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 11:32:22 -0400
Received: by iyb14 with SMTP id 14so2272659iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Apr 2011 08:32:21 -0700 (PDT)
In-Reply-To: <20110415152643.GC4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 9:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 15, 2011 at 04:40:00PM +0200, Arnd Bergmann wrote:
>> On Friday 15 April 2011 15:39:55 Rob Herring wrote:
>>
>> > On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
>> > > This is work in progress.
>> > >
>> > > We have two SoCs using SRAM, both with their own allocation syst=
ems,
>> > > and both with their own ways of copying functions into the SRAM.
>> >
>> > It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.
>>
>> There are also non-ARM systems doing something like that,
>> arch/blackfin/mm/sram-alloc.c comes to mind. On powerpc, the
>> ppc7410 also has this feature in hardware, but I believe it was
>> never supported in mainline Linux.
>
> Yes, but there's some horrible bits out there. =A0PPC is one of them
> which looks like it doesn't lend itself to consolidating with this
> kind of implementation.
>
>> How about putting sram-pool.c into the top-level mm/ directory
>> and sram-pool.h into include/linux? They seem to be completely
>> generic to me, aside from the dependency on asm/fncpy.h which
>> should probably remain arch specific.
>
> I've thought about lib - but first lets see whether other architectur=
es
> want to use it first. =A0I've asked the sh folk off-list about this a=
nd
> waiting for a reply.
>
> Blackfin and PPC look horrible to sort out though, so they can come a=
t
> a later date if they so wish.

Yes, once the infrastructure is in place, powerpc can do its own
migration to the new code.  I vote for putting it in lib at the
outset.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
