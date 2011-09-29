From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v5 00/15] OMAP2+: Serial: Runtime adaptation + cleanup
Date: Thu, 29 Sep 2011 14:12:25 +0530
Message-ID: <CAAL8m4xM-TL5KLdaXqbfmi470On_m-cXowGesgBeqd-beO7SzQ@mail.gmail.com>
References: <1316607097-21564-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1316607097-21564-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 21, 2011 at 5:41 PM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> Converting uart driver to adapt to pm runtime API's.
> Code re-org + cleanup.
> Moving some functionality from serial.c to omap-serial.c
>
> Changes involves:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1.) Cleaning up certain uart calls from sram_idle func.
> 2.) Removed all types of uart clock handling code from serial.c
> 3.) Using hwmod_mux API enable wakeup capability for uart pad during
> =A0 hwmod_idle state i.e., when uart clocks are disabled we can enabl=
e
> =A0 io-pad wakeup capability for uart if mux_data is available for
> =A0 given uart. Also during during resume from idle call to uart we n=
eed
> =A0 to enable clocks back conditionally and this can be done only whe=
n io-pad
> =A0 wakeup event bit is set for uart_rx pad. So we need a hwmod API
> =A0 which can probe the uart pad and let us know whether a uart wakeu=
p
> =A0 happened. So omap_hmwod_pad_wakeup_status API is added to meet th=
is
> =A0 requirement.
> 3.) Adapted omap-serial driver to use runtime API's.
> 4.) Modify serial_init calls to accept uart parameters from board fil=
e.
> =A0 =A0Like dma_usage, rx_timeout, dma_rx_pollrate, auto_suspend_time=
out etc.
> 5.) Use the omap_prm driver with irq_chaining to wake up uart after c=
locks are
> =A0 =A0cut.
>
> Patch series is based on 3.1.0-rc4 + omap_device fixes.
> From Kevin's tree.
> git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device
>
> Also the patch series depends on Tero's Irq_chaining patches.
> Dependent irq_chaining patches are as below.
>
> 3d5b543 omap3: pm: use prcm chain handler
> c00b340 OMAP2+: mux: add support for PAD wakeup interrupts
> db6397c power: omap-prm: added chain interrupt handler
> b3f8628 TEMP: OMAP4xxx: hwmod data: add PRM hwmod
> 61ec0fc TEMP: OMAP3xxx: hwmod data: add PRM hwmod
> a1ecf8c power: add omap prm driver skeleton
>
> Same combination is hosted at:
> git://gitorious.org/runtime_3-0/runtime_3-0.git v5_uart_irqchn
>

Update:
-----------

This patch series was tested against Tero's Irq chaining v9 [1]
tmp patches where dropped from tero's series and applied
on top v5 uart_runtime patches.

same combination is hosted here [2]

--
Thanks,
Govindraj.R

[1]:

43c5073 omap3+: add omap prm driver initialization
dad7fc5 OMAP3: pm: do not enable PRCM MPU interrupts manually
c205290 omap3: pm: use prcm chain handler
453656e OMAP2+: mux: add support for PAD wakeup interrupts
563bed3 mfd: omap-prm: added suspend prepare and complete callbacks
ff8770a mfd: omap-prm: added chain interrupt handler
46386a9 mfd: omap-prm: add driver skeleton
bdc8ddf TEMP: OMAP4xxx: hwmod data: add PRM hwmod
8cc0382 TEMP: OMAP3xxx: hwmod data: add PRM hwmod

[2]: git://gitorious.org/runtime_3-0/runtime_3-0.git v5_uart_runtime


> Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
>
> Changes from v4:
> ---------------
>
> 1.) Fixing v4 comments from Kevin.
> =A0 =A0Spilt into smaller logical patches.
> 2.) Using Irq_chaining OMAP_PRM driver for waking up uart.
>
> Testing updates:
> ----------------
> 3430SDP:
> retention, off_mode, system_wide suspend is tested.
> (earlyprintk & no_console_suspend checked)
>
> OMAP3630 - Zoom3:
> pm-retention checked with quart/omap-uart3
> [Also tested with uart3 as console uart and pm-ret checked]
>
> OMAP4430-SDP: Boot tested.
> OMAP2420/2430SDP: Boot tested.
>
> Deepak K (1):
> =A0OMAP2+: UART: Allow UART parameters to be configured from board fi=
le.
>
> Govindraj.R (13):
> =A0OMAP2+: hwmod: Add API to enable IO ring wakeup.
> =A0OMAP2+: hwmod: Add API to check IO PAD wakeup status
> =A0OMAP2+: UART: cleanup + remove uart pm specific API
> =A0OMAP2+: UART: cleanup 8250 console driver support
> =A0OMAP2+: UART: Cleanup part of clock gating mechanism for uart
> =A0OMAP2+: UART: Remove certain feilds from omap_uart_state struct
> =A0OMAP2+: UART: Add default mux for all uarts.
> =A0OMAP2+: UART: Store certain reg values to port structure
> =A0OMAP2+: UART: Add runtime pm support for omap-serial driver
> =A0OMAP2+: UART: Move errata handling from serial.c to omap-serial
> =A0OMAP2+: UART: Take console_lock in suspend path if not taken
> =A0OMAP2+: UART: Enable back uart clocks with runtime API for early
> =A0 =A0console
> =A0OMAP2+: UART: Do not gate uart clocks if used for debug_prints
>
> Jon Hunter (1):
> =A0OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UA=
RT
>
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0100 +=
---
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0 =A08=
 +-
> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A06 +-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 =A0| =A0 =A08 +=
-
> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 30 +
> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 13 +
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
66 ++
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 19 -
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 24 -
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0933 +++++++------------------
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 30 +-
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0| =A0 11 +-
> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A03=
05 +++++++--
> =A014 files changed, 654 insertions(+), 900 deletions(-)
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
