From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC, kexec,
	atags
Date: Tue, 5 Jan 2010 18:24:51 +0900
Message-ID: <aec7e5c31001050124q5a0a7b7co872bd58ddfabe5f@mail.gmail.com>
References: <20091219034151.26198.26570.stgit@localhost>
	 <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
	 <20091229220705.GM3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42253 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0AEJYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 04:24:54 -0500
Received: by pwj9 with SMTP id 9so10024666pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 05 Jan 2010 01:24:53 -0800 (PST)
In-Reply-To: <20091229220705.GM3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Dec 30, 2009 at 7:07 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Magnus Damm <magnus.damm@gmail.com> [091227 21:54]:
>> > =A0 =A0 =A0arm: Fix cpu_proc_fin() for proc-v7.S and make kexec wo=
rk
>
> Are you seeing the occasional crc errors when uncompressing the
> new kernel on your v7?

Nope, it's very stable. I boot over USB with kexec for all my ARM
kernel development and I have not seen any issues so far.

> I'm seeing those maybe 1 out of 10 times on omap3430 boards unless if
> I do an extra (and wrong) flush_cache_all after local_flush_tlb_all
> at the end of setup_mm_for_reboot.

My second kernel does not need any workaround, however...

> If you're not seeing the crc errors, do you have L2 cache on?

I'm not sure at this point, but I think L2 is disabled. Will try to tur=
n it on.

> Also, what's the Cortex version on your v7? It's rev r2p3 on
> omap3430.

The data sheet of sh7377 says r2p3 as well.

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
