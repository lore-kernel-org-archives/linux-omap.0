From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 13 Dec 2011 18:31:13 +0530
Message-ID: <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58307 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab1LMNBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 08:01:36 -0500
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Hi Tony/kevin,

On Fri, Nov 11, 2011 at 3:27 PM, Govindraj.R <govindraj.raja@ti.com> wr=
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
> Patch series is based on 3.2-rc1.
>
> Patch series depends on *Tero's v9 Irq_chaining patches*.
> Dependent irq_chaining patches are as below.
>
> 89ac62b omap3+: add omap prm driver initialization
> 170431f OMAP3: pm: do not enable PRCM MPU interrupts manually
> 9aba1b0 omap3: pm: use prcm chain handler
> 435481f OMAP2+: mux: add support for PAD wakeup interrupts
> 5b2d361 mfd: omap-prm: added suspend prepare and complete callbacks
> aa55c41 mfd: omap-prm: added chain interrupt handler
> d1db904 mfd: omap-prm: add driver skeleton
> 31d056c TEMP: OMAP4xxx: hwmod data: add PRM hwmod
> 19ec3bc TEMP: OMAP3xxx: hwmod data: add PRM hwmod
> 9a89688 OMAP2+: hwmod: Add API to check IO PAD wakeup status
> 78e8b65 OMAP2+: hwmod: Add API to enable IO ring wakeup.
>
> Same combination is hosted at:
> git://gitorious.org/runtime_3-0/runtime_3-0.git 3.2-rc1_uart_runtime
>
> Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
> And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
> console might be sluggish.
>

I have re-based this patch series against LO master
commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a

Same is available here [1]

I have tested this patch series along with:

1.) Tero's V11 irq chaining series
     http://www.spinics.net/lists/linux-omap/msg61445.html
    (This patch series is used for uart wakeup handling using
      prcm_irq chaining)

2.) Rajendra's hwmod change
     http://www.spinics.net/lists/arm-kernel/msg148632.html
     (This patch handles init_no_idle flag setting
      without this patch there will be boot warning however
      all pm features will work after boot up.)

3.) Vishwa's io daisy chain changes.
     http://permalink.gmane.org/gmane.linux.ports.arm.omap/65500
     (tested with and without this patch series pm features works).

Same combination of patches based on above commit id
used for testing is available here [2].

--
Thanks,
Govindraj.R

[1]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/lo_rc4_uartruntime

[2]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/tmp_rc4_uart_pm_intg


> Changes from v7:
> ---------------
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57804.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58209.html
> http://www.spinics.net/lists/linux-omap/msg59978.html
> http://www.spinics.net/lists/linux-serial/msg04772.html
>
> Testing updates:
> ----------------
> OMAP2420/2430SDP: Boot tested.
>
> OMAP3430SDP:
> retention, off_mode, system_wide suspend is tested.
> (earlyprintk & no_console_suspend checked)
>
> OMAP3630 - Zoom3:
> pm-retention checked with quart/omap-uart3
> [Also tested with uart3 as console uart and pm-ret checked]
>
> BeagleBoard XM Rev C(3630):
> retention, off_mode, system_wide suspend is tested.
>
> Deepak K (1):
> =A0OMAP2+: UART: Allow UART parameters to be configured from board fi=
le.
>
> Govindraj.R (18):
> =A0OMAP2+: UART: cleanup + remove uart pm specific API
> =A0OMAP2+: UART: cleanup 8250 console driver support
> =A0OMAP2+: UART: Cleanup part of clock gating mechanism for uart
> =A0OMAP2+: UART: Add default mux for all uarts.
> =A0OMAP2+: UART: Remove mapbase/membase fields from pdata.
> =A0OMAP2+: UART: Add runtime pm support for omap-serial driver
> =A0OMAP2+: UART: Remove context_save and move context restore to driv=
er
> =A0OMAP2+: UART: Ensure all reg values configured are available from
> =A0 =A0port structure
> =A0OMAP2+: UART: Remove uart reset function.
> =A0OMAP2+: UART: Get context loss count to context restore
> =A0OMAP2+: UART: Move errata handling from serial.c to omap-serial
> =A0OMAP2+: UART: Add wakeup mechanism for omap-uarts
> =A0OMAP2+: UART: Remove old and unused clocks handling funcs
> =A0OMAP2+: UART: remove temporary variable used to count uart instanc=
e
> =A0OMAP2+: UART: Use custom activate func for console uart.
> =A0OMAP2+: UART: Avoid uart idling on suspend for no_console_suspend
> =A0 =A0usecase
> =A0OMAP2+: UART: Do not gate uart clocks if used for debug_prints
> =A0OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
>
> Jon Hunter (1):
> =A0OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UA=
RT
>
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0100 +=
---
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0 68 +=
--
> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A06 +-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 =A0| =A0 68 +--
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
5 -
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 20 -
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 42 --
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0926 +++++++------------------
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 36 +-
> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0| =A0 10 +-
> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A03=
41 ++++++++--
> =A011 files changed, 607 insertions(+), 1015 deletions(-)
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
