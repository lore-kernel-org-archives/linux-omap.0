From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 07 Mar 2011 14:09:03 -0800
Message-ID: <87fwqy1t34.fsf@ti.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45919 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067Ab1CGWJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 17:09:08 -0500
Received: by mail-qy0-f171.google.com with SMTP id 19so2437593qyj.16
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 14:09:07 -0800 (PST)
In-Reply-To: <1299252837-18074-1-git-send-email-dave.martin@linaro.org> (Dave
	Martin's message of "Fri, 4 Mar 2011 15:33:52 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

Dave Martin <dave.martin@linaro.org> writes:

> This set of patches, along with some other patches under
> discussion on alkml, should enable omap3 and omap4 kernels to be
> built with CONFIG_THUMB2_KERNEL.
>
> This patch set builds on recent cleanup done by the omap
> maintainers.
>
> At least some of this code definitely works, most features have
> been tested successfully.  Further testing, especially of Thumb-2
> behaviour, is still welcome.
>
> In particular, I still have no Ack/Tested-by on the following
> patches, so it would be great if anyone who has an opportunity
> to do a final review / re-test can do so.
>
>  * ARM: omap3: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
>  * ARM: omap3: Thumb-2 compatibility for sram34xx.S
>  * ARM: omap3: Thumb-2 compatibility for sleep34xx.S

Jean Pihet and I have now done both retention and off-mode testing
of these, so I'll add a Tested-by for the last two for Jean and queue
these for 2.6.39 in my PM queue

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-misc

If you want to do sanity checking with all the other OMAP PM stuff that
is queued for 2.6.39, feel free to test with my pm-core branch in the
tree above.  This has all OMAP PM related changes that will be queued
for 2.6.39 integrated.

FWIW, I also tested on 3430/n900 (retention and off-mode) and 3630/Zoom3
(retention-only, since the Si rev have has off-mode errata.)

Kevin

> Seems to work with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL
> enabled on Beagle xM A2 and Panda A1.
>
> Thanks also to Santosh Shilimkar and Kevin Hilman for their help
> with testing so far.
>
>
> v3:
>     * make SMC instruction syntax more consistent
>     * remove do_wfi() in favour of the generic wfi() macro
>
> v4:
>     * revert to the OMAP-specific do_wfi() implementation, pending
>       discussion of how generic macros can/should be provided
>
> v5:
>     * use ARM for low-level code in mach-omap2/*34xx.S, for
>       correct interoperation with non-Thumb-capable firmware.
>
> I've stripped the Acked/Tested-bys from the major patches to
> mach-omap2/*34xx.S, since the reversion to ARM constitutes a
> significant change -- I would be grateful if people could re-
> test / re-review if they have the chance.
>
> For best future compatibility, I've left the changes which
> avoid architecturally deprecated features.
>
>
> Details below.
>
> Cheers,
> Dave
>
>
> The patches can be found, along with a buildable working tree,
> in the following repo:
>
> git://git.linaro.org/people/dmart/linux-2.6-arm.git
>
>  * arm/omap-thumb2: has the patches proposed here
>  * arm/omap-thumb2+merged: additionally has some patches cherry-
>         picked from other trees which are needed in order for the
>         patches on arm/omap-thumb2 to work usefully.
>  * dirty/arm/omap-thumb2+merged: buildable test tree, which adds
>         2 local patches to work around a toolchain bug.
>
> A working kernel config for this tree is here:
> http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config :
>
>   CONFIG_SMP_ON_UP=y
>   CONFIG_THUMB2_KERNEL=y
>   CONFIG_SERIAL_OMAP=y (to avoid garbage on xM; for Panda use console=ttyS2)
>
> (The config is derived from the linaro omap config and so turns on
> loads of modules -- don't feel you have to build them all...)
>
>
> Cherry-picked patches originated from Russell's devel tree
> and Tony Lindgren's omap-testing tree:
>
> http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git devel
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-testing
>
> This series also depends on one un-merged patch to generic-ise
> the wfi() macro:
>
> git://git.linaro.org/people/dmart/linux-2.6-arm.git arm/wfi-macro
>
>
> Dave Martin (5):
>   ARM: omap4: Provide do_wfi() for Thumb-2
>   ARM: omap4: Convert END() to ENDPROC() for correct linkage with
>     CONFIG_THUMB2_KERNEL
>   ARM: omap3: Remove hand-encoded SMC instructions
>   ARM: omap3: Thumb-2 compatibility for sram34xx.S
>   ARM: omap3: Thumb-2 compatibility for sleep34xx.S
>
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++
>  arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
>  arch/arm/mach-omap2/omap44xx-smc.S              |    8 ++--
>  arch/arm/mach-omap2/sleep34xx.S                 |   62 ++++++++++++++++++----
>  arch/arm/mach-omap2/sram34xx.S                  |   36 ++++++++++---
>  5 files changed, 87 insertions(+), 25 deletions(-)
