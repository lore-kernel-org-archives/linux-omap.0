From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Mon, 08 Sep 2014 15:30:28 -0700
Message-ID: <7h7g1dlp8b.fsf@linaro.org>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
	<1405047349-15101-11-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54506 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbaIHWaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 18:30:30 -0400
Received: by mail-pa0-f44.google.com with SMTP id kx10so4002097pab.17
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2014 15:30:30 -0700 (PDT)
In-Reply-To: <1405047349-15101-11-git-send-email-d-gerlach@ti.com> (Dave
	Gerlach's message of "Thu, 10 Jul 2014 21:55:48 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Ohad Ben-Cohen <ohad@wizery.com>

+Ohad

Dave Gerlach <d-gerlach@ti.com> writes:

> AM335x supports various low power modes as documented
> in section 8.1.4.3 of the AM335x Technical Reference Manual.
>
> DeepSleep0 mode offers the lowest power mode with limited
> wakeup sources without a system reboot and is mapped as
> the suspend state in the kernel. In this state, MPU and
> PER domains are turned off with the internal RAM held in
> retention to facilitate the resume process. As part of
> the boot process, the assembly code is copied over to OCMCRAM
> using the OMAP SRAM code so it can be executed to turn of the
> EMIF.
>
> AM335x has a Cortex-M3 (WKUP_M3) which assists the MPU
> in DeepSleep0 and Standby entry and exit. WKUP_M3 takes care
> of the clockdomain and powerdomain transitions based on the
> intended low power state. MPU needs to load the appropriate
> WKUP_M3 binary onto the WKUP_M3 memory space before it can
> leverage any of the PM features like DeepSleep.
>
> The WKUP_M3 is managed by a remoteproc driver. The PM code hooks
> into the remoteproc driver through an rproc_ready callback to
> allow PM features to become available once the firmware for the
> wkup_m3 has been loaded. This code maintains its own state machine
> for the wkup_m3 so that it can be used in the manner intended for
> low power modes.
>
> In the current implementation when the suspend process
> is initiated, MPU interrupts the WKUP_M3 to let it know about
> the intent of entering DeepSleep0 and waits for an ACK. When
> the ACK is received MPU continues with its suspend process
> to suspend all the drivers and then jumps to assembly in
> OCMC RAM. The assembly code puts the external RAM in self-refresh
> mode, gates the MPU clock, and then finally executes the WFI
> instruction. Execution of the WFI instruction with MPU clock gated
> triggers another interrupt to the WKUP_M3 which then continues
> with the power down sequence wherein the clockdomain and
> powerdomain transition takes place. As part of the sleep sequence,
> WKUP_M3 unmasks the interrupt lines for the wakeup sources. WFI
> execution on WKUP_M3 causes the hardware to disable the main
> oscillator of the SoC and from here system remains in sleep state
> until a wake source brings the system into resume path.
>
> When a wakeup event occurs, WKUP_M3 starts the power-up
> sequence by switching on the power domains and finally
> enabling the clock to MPU. Since the MPU gets powered down
> as part of the sleep sequence in the resume path ROM code
> starts executing. The ROM code detects a wakeup from sleep
> and then jumps to the resume location in OCMC which was
> populated in one of the IPC registers as part of the suspend
> sequence.
>
> Code is based on work by Vaibhav Bedia.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Remove all direct wkup_m3 usage and moved to rproc driver introduced
> 	in previous patch.

This statement is rather confusing as there's still quite a bit of
direct wkup_m3 usage, including the guts of the protocal for message
passing.  I thought you had agreed based on earilier reviews to split
out the wkup_m3 into it's on little driver with a clear/clean API which
could be called from here?

To me, it's not terribly clear how you made the split between this PM
core code an the remoteproc code.  In the changelog for the remoteproc
patch, it states it's to "load the firmware for and boot the wkup_m3".
But, while parts of the IPC are here in pm33xx.c, parts of the IPC are
also inside the remoteproc driver, so I'm quite curious if that's OK
with the remoteproc maintainers.  Either way, please make it clearer how
and why you made the split, and please isolate the wkup_m3 IPC/protocol
from this code.  Think of people wanting to rework/extend the wkup_m3
firmware.  They shouldn't be messing around in here, but rather inside a
driver specificaly for the wkup_m3.

Also, I'll beat this drum again even though nobody is listening: it's
still very fuzzy to me how this approach is going to be used to manage
low-power idle?  Is low-power idle just being completely ignored for
this SoC?

Kevin
