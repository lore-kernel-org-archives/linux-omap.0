From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 14:21:19 -0700
Message-ID: <87prcqbsj4.fsf@deeprootsystems.com>
References: <20090626062539.GX7352@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B53AB55D@dbde02.ent.ti.com>
	<20090626084633.GD7352@atomide.com>
	<13B9B4C6EF24D648824FF11BE8967162038E4C7D46@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:40460 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZFZVVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 17:21:20 -0400
Received: by pzk40 with SMTP id 40so80503pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 14:21:22 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E4C7D46@dlee02.ent.ti.com> (Richard Woodruff's message of "Fri\, 26 Jun 2009 13\:14\:03 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tony Lindgren
>
>> > > Last week I posted some more omap io.h clean-up patches to
>> > > the linux-omap
>> > > list [1], and started looking at what it would take to
>> > > reclaim lost address
>> > > space on top of the io.h clean-up patches.
>> > >
>> > > Looks like we should be able to reclaim about 454MB of the 640MB
>> > > of the lost IO address space by doing the following:
>
> Using section entries to cover ranges provides superior performance.  1 TLB will cover a whole series of accesses when doing things like servicing an interrupt.  Using fewer TLBs to cover system accesses leaves more in tact for application usage.  I've not see recent data but long back TLB optimization provided sizeable performance boost for many applications.
>
> Additionally debug is simplified by having the simple static map around.
>
> Russell recently pointed out and David showed an example of how ioremap() can take an arch specific function which can return virtual address from already defined static ranges.  I do think this is a nice clean up and optimization (to stop some double mapping which now happens with ioremap).
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03813.html
>
> So, I think yes moving to ioremap in all drivers is good, but it would use underlying static maps where they exist.

Current linux-omap has worked like this for a while now.  IOW,
ioremap() will first check any static mappings before doing a real
remap.

So, without any changes to the memory map, everything could be converted
to ioremap + read/write already.

Kevin
