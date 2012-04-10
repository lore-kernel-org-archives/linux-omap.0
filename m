From: "S, Venkatraman" <svenkatr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/19] I2C updates
Date: Tue, 10 Apr 2012 17:01:37 +0530
Message-ID: <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334055397-899-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 10, 2012 at 4:26 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> w=
rote:
> The patch series does the following
>
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - I2C register restore only if context if the context is lost
> - Bus busy recovery mechanism.
> - the reset is not done in init.
>
> v2 changes
> -Adds a patch to use devm_* functions
> -Also checks the return type of the get_sync and in case
> =A0of errors prevents register access.
> - In case of i2c remove register access was done without any
> =A0get_sync fix the same.
> - Adds a pdata function pointer to do context save restore
>
> v3 changes
> - Split the omap_i2c_isr to increase readability
> - Adds the restore flag patch for OMAP4 to the series
> - Make the i2c use SET_RUNTIME_PM_OPS
> v4 changes
> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> - Prevents the XDUF flag to be set if the underflow condition is not =
met.
>
> v5 changes
> - Add consistency in the subject naming.
>
> v6 changes
> - As per discussion in [1] .Adds a patch to rename the 1p153 errata a=
nd
> =A0use the unique id instead as the section number in the recent erra=
ta
> =A0docs has changed.
>
>
> [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
>
> Tested on omap4sdp and omap3sdp.
>
>
> The following changes since commit 258f742635360175564e9470eb060ff4d4=
b984e7:
>
> =A0modpost: Fix modpost license checking of vmlinux.o (2012-04-09 20:=
52:56 -0700)
>
> are available in the git repository at:
> =A0git-OGgr7I4mDcYgsBAKwltoeQ@public.gmane.org:linus-tree/linus-tree.git i2c_omap-next

Minor nit:
You might want to indicate a git:// link instead of an ssh URL ?

>
>
> Jon Hunter (1):
> =A0I2C: OMAP: Correct I2C revision for OMAP3
>
> Shubhrajyoti D (16):
> =A0I2C: OMAP: make omap_i2c_unidle/idle functions depend on
> =A0 =A0CONFIG_PM_RUNTIME
> =A0I2C: OMAP: Remove reset at init
> =A0I2C: OMAP: I2C register restore only if context is lost
> =A0I2C: OMAP: Fix the interrupt clearing in OMAP4
> =A0I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
> =A0I2C: OMAP: Optimise the remove code
> =A0I2C: OMAP: Fix the error handling
> =A0I2C: OMAP: Don't check if wait_for_completion_timeout() returns le=
ss
> =A0 =A0than zero
> =A0I2C: OMAP: use devm_* functions
> =A0I2C: OMAP: Fix the crash in i2c remove
> =A0I2C: OMAP: Handle error check for pm runtime
> =A0I2C: OMAP: Use SET_RUNTIME_PM_OPS
> =A0I2C: OMAP: make the read ready processing a separate function
> =A0I2C: OMAP: Do not set the XUDF if the underflow is not reached
> =A0I2C: OMAP: Rename the 1p153 to the erratum id i462
> =A0ARM: OMAP4: hwmod data: I2C: add flag for context restore
>
> Tasslehoff Kjappfot (1):
> =A0I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153
>
> Vikram Pandita (1):
> =A0I2C: OMAP: Recover from Bus Busy condition
>
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A03 +-
> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A03 +
> =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0342 =
+++++++++++++++-------------
> =A0include/linux/i2c-omap.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
> =A04 files changed, 194 insertions(+), 155 deletions(-)
>
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
