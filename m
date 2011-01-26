From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH v2 0/3] oprofile: ARM backtraces and few minors
Date: Wed, 26 Jan 2011 19:33:55 +0100
Message-ID: <20110126183355.GM5874@erda.amd.com>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ari Kauppi <kauppi@papupata.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matt Fleming <matt@console-pimps.org>
List-Id: linux-omap@vger.kernel.org

On 20.01.11 13:57:17, Ari Kauppi wrote:
> This patchset re-enables ARM backtraces with non-PMU capable CPUs.
> 
> In V2 I have tried to address the comments received for the V1
> patches. arch/sh/oprofile/common.c is untouched but should work
> as earlier.
> 
> Compile tested with arm/omap2plus_defconfig (with and without
> CONFIG_HW_PERF_EVENTS).
> 
> Ari Kauppi (3):
>   oprofile: Use CONFIG_HW_PERF_EVENTS for oprofile_perf_init and
>     friends
>   oprofile: Provide stubs for oprofile_perf_{init,exit}
>   ARM: oprofile: Always allow backtraces
> 
>  arch/arm/oprofile/common.c |   12 ++----------
>  include/linux/oprofile.h   |   13 +++++++++++--
>  2 files changed, 13 insertions(+), 12 deletions(-)

Applied to oprofile/urgent, thanks Ari.

I squashed patch 2 and 3 and modified the commit messages (see below).

Added to .37-stable.

-Robert


commit d14dd7e20d5e526557f5d3cfef4046a642f80924
Author: Ari Kauppi <kauppi@papupata.org>
Date:   Thu Jan 20 13:57:19 2011 -0500

    ARM: oprofile: Fix backtraces in timer mode
    
    Always allow backtraces when using oprofile on ARM, even if a PMU
    isn't present. Restores functionality originally introduced in commit
    1b7b56982fdcd9d85effd76f3928cf5d6eb26155 ("oprofile: Always allow
    backtraces on ARM") by Richard Purdie.
    
    It is not that obvious, but there is now only one oprofile_arch_init()
    function. So the .backtrace callback is available also in timer mode.
    
    Implemented by removing code and using stubs for oprofile_perf_{init,
    exit} provided by <linux/oprofile.h>. This allows cleaning of other
    architecture specific implementations too.
    
    Cc: stable@kernel.org # 37.x
    Signed-off-by: Ari Kauppi <kauppi@papupata.org>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Robert Richter <robert.richter@amd.com>

commit 1ea1bdf7faa4d0b5293e605f2e1ef1c2c59f6b53
Author: Ari Kauppi <kauppi@papupata.org>
Date:   Thu Jan 20 13:57:18 2011 -0500

    oprofile: Fix usage of CONFIG_HW_PERF_EVENTS for oprofile_perf_init and friends
    
    The implementations are flagged in Makefile with CONFIG_HW_PERF_EVENTS
    instead of CONFIG_PERF_EVENTS.
    
    Cc: stable@kernel.org # 37.x
    Signed-off-by: Ari Kauppi <kauppi@papupata.org>
    Signed-off-by: Robert Richter <robert.richter@amd.com>


-- 
Advanced Micro Devices, Inc.
Operating System Research Center
