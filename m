From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Bridge issue #3! dma_alloc_coherent causing crash - pm branch
Date: Fri, 13 Mar 2009 08:59:46 -0700
Message-ID: <87sklh1ki5.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD10D6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:37789 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCMP7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 11:59:52 -0400
Received: by gxk7 with SMTP id 7so914646gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 08:59:49 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD10D6@dbde02.ent.ti.com> (Ramesh Gupta's message of "Fri\, 13 Mar 2009 15\:18\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gupta, Ramesh" <grgupta@ti.com> writes:

[...]

>> > Sounds like a memory leak in the bridge driver to me.  I 
>> suggest you 
>> > enable memory leak debugging.  In Kconfig
>> > 
>> >    Kernel Hacking -->  Kernel debugging
>> > 
>> > Enable 'Debug slab memory allocations' and its child 'Memory leak 
>> > debugging'.
>> > 
>> > Or, you could switch to the SLUB allocator which has some more 
>> > flexible debug options which can be controlled at boot-time 
>> from the cmdline.
>> > 
>> > While you are in the Kernel debugging menu, make sure you enable 
>> > 'Verbose BUG()' and 'Verbose kernel errors'.  This will ensure that 
>> > any memory leaks will be dumped with some extra debug output.
>
> I enabled all the above options, do I need to add some boot options to enable 
> Debug messages? I am not seeing any debug information displayed in the cosole by default.
> Looks like I am mising some thing :( . Any comments?
>

You'll only see extra messages when the kerel hits a BUG() or a WARN().  If
you don't see anything more verbose with all these options enabled, then
the kernel is not detecting any problems.

Kevin
