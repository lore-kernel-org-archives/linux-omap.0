From: Will Deacon <will@willdeacon.co.uk>
Subject: Re: [PATCH] ARM: hw_breakpoint: Enable debug powerdown only if
 system supports 'has_ossr'
Date: Fri, 15 Mar 2013 05:00:14 +0000
Message-ID: <20130315050014.GA15706@tiny-lites>
References: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com>
 <51406BA7.8010306@arm.com>
 <51407120.7030709@ti.com>
 <51417E58.5050501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51417E58.5050501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Lokesh Vutla <lokeshvutla@ti.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 14, 2013 at 01:08:00PM +0530, Santosh Shilimkar wrote:
> Will,

Hi guys,

I'm out of the office at the moment and have really terrible connectivity,
so I can't do too much until next week. However, I don't think adding the
has_ossr check is the right fix for this problem.

> On Wednesday 13 March 2013 05:59 PM, Lokesh Vutla wrote:
> > Hi Dietmar,
> > On Wednesday 13 March 2013 05:35 PM, Dietmar Eggemann wrote:
> >> On 13/03/13 06:52, Lokesh Vutla wrote:
> >>> Commit {9a6eb31 ARM: hw_breakpoint: Debug powerdown support for
> >>> self-hosted
> >>> debug} introduces debug powerdown support for self-hosted debug.
> >>> While merging the patch 'has_ossr' check was removed which
> >>> was needed for hardwares which doesn't support self-hosted debug.
> >>> Pandaboard (A9) is one such hardware and Dietmar's orginial
> >>> patch did mention this issue.
> >>> Without that check on Panda with CPUIDLE enabled, a flood of
> >>> below messages thrown.
> >>>
> >>> [ 3.597930] hw-breakpoint: CPU 0 failed to disable vector catch
> >>> [ 3.597991] hw-breakpoint: CPU 1 failed to disable vector catch

Ok, so this means that we've taken an undefined instruction exception while
trying to reset the debug registers on the PM_EXIT path. Now, the code there
deals with CPUs that don't have the save/restore registers just fine, so
that shouldn't have anything to do with this problem, particularly if the
bit that is tripping us up is related to clearing vector catch.

Furthermore, I was under the impression that hw_breakpoint did actually
work on panda, which implies that a cold boot *does* manage to reset the
registers (can you please confirm this by looking in your dmesg during
boot?). In that case, it seems as though a PM cycle is powering down a
bunch of debug logic that was powered up during boot, and then we trip over
because we can't access the register bank.

The proper solution to this problem requires us to establish exactly what is
turning off the debug registers, and then having an OMAP PM notifier to
enable it again. Assuming this has always been the case, I expect hardware
debug across PM fails silently with older kernels.

> I was also wondering whether we should just warn once rather
> than continuous warnings in the notifier. Patch is end of the
> email.

Could do, but I'd like to see a fix for the real issue before we simply hide
the warnings :)

Cheers,

Will
