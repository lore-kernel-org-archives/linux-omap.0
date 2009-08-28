From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH v3]OMAP3:PM: Fix OPP scale logic
Date: Fri, 28 Aug 2009 12:13:06 +0300
Message-ID: <87bpm01eu5.fsf@deeprootsystems.com>
References: <Re: [RFC][PATCH v2] OMAP3:PM: Fix OPP scale logic>
	<1249400032-23759-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51312 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZH1JNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:13:08 -0400
Received: by bwz19 with SMTP id 19so1483825bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 02:13:09 -0700 (PDT)
In-Reply-To: <1249400032-23759-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Tue\,  4 Aug 2009 10\:33\:52 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <ext-roger.quadros@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> While switching from higher OPP to lower OPP,
> current scale logic can fail by switching to lower
> voltage while frequency remains at old value.
>
> This patch adds a cleaner recovery logic and
> additional freq dpll checks. This changes
> program_freq_opp return type in the process
> for program_opp to handle error in a consistent
> manner.
>
> NOTE: I moved the *cur_opp setting to under the
> scratchpad locked region to allow for code
> simplicity - i wonder if anyone sees an issue with it
>
> Thanks to Roger in patiently catching my goofups :(
>
> Tested on:rx-51, ported to pm branch - untested linux-omap
> Patch generated on linux-omap pm branch, commit:
> 7e7377395d6b4576341a6939bf2179f3946f2ea0
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Roger Quadros <ext-roger.quadros@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com> 
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/resource34xx.c |   61 +++++++++++++++++++++++++++---------
>  1 files changed, 46 insertions(+), 15 deletions(-)

The fix looks good for adding the extra checks, but can you do some
more testing on current PM branch?  This currently doesn't even
compile on current PM branch.

Thanks,

Kevin


[...]
  CC      arch/arm/mach-omap2/resource34xx.o
distcc[24405] ERROR: compile /tmp/khilman/.ccache/resource34.tmp.vence.24379.i on localhost failed
/opt/home/khilman/work.local/kernel/omap/pm-next/arch/arm/mach-omap2/resource34xx.c: In function 'program_opp':
/opt/home/khilman/work.local/kernel/omap/pm-next/arch/arm/mach-omap2/resource34xx.c:333: error: 'PRCM_VDD1' undeclared (first use in this function)
/opt/home/khilman/work.local/kernel/omap/pm-next/arch/arm/mach-omap2/resource34xx.c:333: error: (Each undeclared identifier is reported only once
/opt/home/khilman/work.local/kernel/omap/pm-next/arch/arm/mach-omap2/resource34xx.c:333: error: for each function it appears in.)
make[2]: *** [arch/arm/mach-omap2/resource34xx.o] Error 1
make[1]: *** [arch/arm/mach-omap2] Error 2
make[1]: *** Waiting for unfinished jobs....

