From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Add clock post-rate-change notifier
Date: Thu, 26 Jun 2008 16:52:39 +0300
Message-ID: <20080626135238.GN12992@atomide.com>
References: <20080620231155.21640.89851.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60251 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbYFZNwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:52:42 -0400
Content-Disposition: inline
In-Reply-To: <20080620231155.21640.89851.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080621 02:16]:
> 
> This series adds a clock rate change notifier to the OMAP clock
> framework.  Currently only post-rate-change notification is
> implemented, although pre-rate-change notification is in the works.
> 
> Clock post-rate-change notifiers are intended for drivers that need to
> be notified when other code (such as power management code) changes
> their clock's rate.  DSPBridge is apparently one such user, but
> drivers for UART, MCSPI, etc. are also candidates for these notifiers.
> 
> Drivers should use these notifiers by adding function pointers for
> clk_notifier_register() and clk_notifier_unregister() to their
> platform_data structure.  Ensure that the function pointers are not
> NULL before calling, since non-OMAP platforms may not support this
> notifier:
> 
>   if (pdata->clk_notifier_register)
>      (*pdata->clk_notifier_register)(clk, &test_nb);
> 
> The callback code must not call back into the clock framework nor
> sleep, as the clock framework spinlock is held for the duration of the
> callbacks.  Callback functions should be short and lightweight.
> 
> ...
> 
> A few implementation notes.  Upon request, an alternate design was
> also investigated based on the existing CPUFreq notifiers.  That
> design was set aside, due to the following problems:
> 
> - CPUFreq notifier callbacks can sleep.  This will break the clock
>   framework, since it calls the notifier inside a spinlock.
> 
> - Identifying the changed clock from the callback would require a new
>   platform_data-based function in the clock framework, since struct
>   cpufreq_freqs has no good way to pass it.
> 
> - CPUFreq notifiers depend on CPUFreq, which not everyone uses.
> 
> There was also some concern expressed that separate CPUFreq notifiers
> and clk rate notifiers could race.  (That would only apply to the
> clocks that are changed by CPUFreq, and any clocks downstream from
> it.)  This doesn't appear to be a problem in practice, since CPUFreq
> post-rate notifiers can only start after the clk post-rate notifiers
> have completed and exited the clock framework.
> 
> The current implementation has been moderately tested with multiple
> clock notifiers on both DPLLs and a downstream clock on 3430SDP.  Also
> compile-tested for N800.

Let's run these by linux-arm-kernel and linux-pm lists before we apply.

Tony

> 
> 
> - Paul
> 
> 
>    text    data     bss     dec     hex filename
> 3404721  158888  108176 3671785  3806e9 vmlinux.3430sdp.orig
> 3405361  158896  108176 3672433  380971 vmlinux.3430sdp.patched
> 
>  arch/arm/mach-omap2/clock.c       |   37 ++++++++--
>  arch/arm/mach-omap2/clock24xx.c   |   42 ++++++++++-
>  arch/arm/mach-omap2/clock34xx.c   |   10 +++
>  arch/arm/plat-omap/clock.c        |  144 +++++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/clock.h |   21 +++++
>  5 files changed, 246 insertions(+), 8 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
