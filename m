From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled
Date: Tue, 07 Dec 2010 12:59:51 -0800
Message-ID: <87sjy9l2ns.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<87oc9e5j4c.fsf@deeprootsystems.com>
	<20101125005923.GE31536@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33821 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0LGU75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 15:59:57 -0500
Received: by qwa26 with SMTP id 26so351951qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 12:59:56 -0800 (PST)
In-Reply-To: <20101125005923.GE31536@atomide.com> (Tony Lindgren's message of
	"Wed, 24 Nov 2010 16:59:23 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, jean.pihet@newoldbits.com, govindraj.raja@ti.com

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [101124 16:32]:
>> Paul Walmsley <paul@pwsan.com> writes:
>
> <snip>
>
>> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Very nice.  I've been exploring various solutions to this problem as
>> well, but this one is much cleaner.  Also, I hadn't discovered the 'try'
>> version of the console semaphore, so was running into recursive locking.
>> 
>> Anyways, tested on omap35xx: omap3evm (uart1/core console) and beagle
>> (uart3/per console) and omap34xx/n900 (uart3/per console) using both
>> retention-idle and off-idle.
>
> Thanks, queuing this as fix for the -rc cycle.

FYI.. just found a regression caused by this patch.  It prevented
suspend from ever happening since the console semaphore is already held
during suspend.

Just posted a fix for this:

Date: Tue, 7 Dec 2010 12:24:13 -0800
Subject: [PATCH] OMAP2+: PM/serial: fix console semaphore acquire during suspend


Kevin

