From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/7] OMAP2/3 clock: implement clock rate change notifiers
Date: Tue, 13 Jan 2009 09:01:50 -0800
Message-ID: <87ab9vkum9.fsf@deeprootsystems.com>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:2625 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbZAMRBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 12:01:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so45926wah.21
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 09:01:54 -0800 (PST)
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain> (Paul Walmsley's message of "Tue\, 23 Dec 2008 03\:13\:49 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello,
>
> This series implements a clock rate change notifier for OMAP2/3 [1].
> It applies on top of the "OMAP clock: bug fixes, cleanup,
> optimization" series posted to linux-omap on Mon, 22 Dec 2008.

Now that the 'buf fixes, cleanup' series is now in linux-omap, I'll pull 
this series into the PM branch for more testing.

Kevin

> (The notes below assume that the notifiers are used by device drivers;
> however, they are also usable by core code.)
>
> The clock notifier is called for both rate and parent changes, and
> is called even when the current rate is the same as the future rate,
> in the event that the reprogramming causes a glitch.
>
> A single notifier is defined, with four types of messages:
>
> CLK_PREPARE_RATE_CHANGE: Used to ask the driver whether a rate
>    change is OK to complete.  When drivers receive this message,
>    they should start any actions that must complete before a
>    rate change can succeed.
>
> CLK_ABORT_RATE_CHANGE: Indicates that a notifier callback
>    has aborted the rate change, or that the clock rate/parent
>    change function has failed.  Upon receipt of this message,
>    drivers can 
>
> CLK_PRE_RATE_CHANGE: Indicates that the rate/parent change is about
>    to take place. The callback must not return until the driver
>    is ready for the change.
>
> CLK_POST_RATE_CHANGE: Indicates that the rate/parent change has
>    successfully completed.
>
> ...
>
> There are three possible sequences of notifier messages that a driver
> can receive:
>
> PREPARE -> PRE -> POST: 
>    Successful rate/parent change.
>
> PREPARE -> ABORT: 
>    Rate/parent change aborted by one of the callbacks.
>
> PREPARE -> PRE -> ABORT
>    Rate/parent change aborted by the clock's set_rate()/set_parent()
>    functions.
>
> ...
>
> If clock notifier callbacks are expected to abort clock changes, they
> probably should not be used as the only method for aborting changes.
> The clk_set_rate() or clk_set_parent() functions will return -EAGAIN
> if a driver aborts the change.  Higher-level code such as CPUFreq may
> attempt to call the function repeatedly, pointlessly burning CPU
> cycles.  In these situations, application code or system daemons
> must also be used to prevent the frequency change from reaching the
> clock code when it is expected to fail for long durations.
>
> Callbacks are called with the clock framework spinlock held.  Callback
> code should be extremely fast and lightweight and must not call back
> into the clock framework.
>
> Since support for clock notifiers currently does not exist in
> include/linux/clk.h, drivers that wish to use them should pass
> function pointers for clk_notifier_register() and
> clk_notifier_unregister() via their platform_data structs.
>
> Please note that these patches have only been lightly tested.  Further
> testing is ongoing; help always appreciated.
>
> Compile-tested on OMAP1.  Boot-tested on N800.  Notifier callback
> tested on 3430SDP GP ES2.1.
>
> - Paul
>
> --
>
> 1, There's no technical reason why these can't also be implemented for
> OMAP1.  I just don't have a convenient way to test OMAP1 builds at the
> moment.
>
>
> size:
>    text    data     bss     dec     hex filename
> 3582501  190928  108824 3882253  3b3d0d vmlinux.3430sdp.orig
> 3583605  191824  108824 3884253  3b44dd vmlinux.3430sdp.patched
>
> diffstat:
>  arch/arm/mach-omap2/clock.c             |   69 +++++++++--
>  arch/arm/plat-omap/clock.c              |  203 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/clock.h |   83 +++++++++++++
>  3 files changed, 346 insertions(+), 9 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
