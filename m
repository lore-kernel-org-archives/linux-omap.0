From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Wed, 18 Feb 2015 19:28:43 +0100
Message-ID: <CAALWOA-P0vov1HHR3Wh-B_xz_X1WNgVQGOHD_gvaf3NPWsNu_w@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <20150218145446.GA32521@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34288 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbBRS3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2015 13:29:05 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so4154717wib.4
        for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2015 10:29:04 -0800 (PST)
In-Reply-To: <20150218145446.GA32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 18 February 2015 at 15:54, Tony Lindgren <tony@atomide.com> wrote:
> From memory.. I believe the issue was that for anything needing to
> set the counter and rely on the counter interrupt things would fail
> as the counter interrupts would not always happen.

Correct, but the interrupt is just used to indicate when counters
overflow, intended to be used to correctly keep track of the counters
when they exceed 2^32 (which can happen easily when measuring across a
timespan of more than a few seconds).

However, no performance counter can increment more than twice per cpu
cycle, which means it takes at least 2^31 cpu cycles to completely
wrap a counter around.  If you make sure you update local copies
(untested code below) more often than once per 2^31 cycles they should
therefore keep accurate track.

void update_perf_counters( u64 ctr[4] )
{
        for( int i = 0; i < 4; i++ ) {
                u32 val;
                asm volatile( "mcr p15, 0, %0, c9, c12, 5" :: "r"(i) );
                asm volatile( "mrc p15, 0, %0, c9, c13, 2" : "=r"(val) );
                ctr[i] += (u32)( val - ctr[i] );
        }
}

- Matthijs
