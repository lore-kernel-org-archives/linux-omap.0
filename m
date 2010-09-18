From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform support
Date: Sat, 18 Sep 2010 14:47:22 +0530
Message-ID: <AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
References: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
	<87tylorl9i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87tylorl9i.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 18, 2010 at 5:11 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch series adds a serial driver to handle uarts on omap platf=
orms.
>> Currenlty omap-uarts are handled with 8250 driver, since updating
>> this driver with omap specific features will over load
>> the 8250 driver with all omap-specific data thus a new driver
>> is added to configure and support features like
>> dma, h/w, s/w flowcontrol for omap-uarts.
>> Also the patch series updates various low level platform specific
>> serial data to support omap-uarts with hwmod framework and adds supp=
ort
>> for uart4 on OMAP3630.
>
> This series is missing a couple things to work more broadly on all
> boards, specifically 3630-based boards.
>
> First, due to the current UART idle code base, you need to enable all
> OMAP UARTs 36xx. =A0Enabling less than all OMAP UARTs will break the
> current idle code. =A0As we discussed, the next phase we will move th=
e
> idle management from this serial.c hackery into the omap-serial drive=
r
> iteself. =A0Until then, you need to call omap_serial_init() on
> Zoom2/Zoom3. =A0Patch below[1]
>
> Also, you previously had a patch that updated omap_uart_idle_init() t=
o
> handle 36xx and specifically UART4. =A0Without that, struct
> omap_uart_state is not setup correctly for UART4, and thus cannot be
> properly idled on 3630.

ok fine, I will I incorporate initialize all uarts patch for zoom board=
s.

Are you referring to this patch?
https://patchwork.kernel.org/patch/108066/

Is this still needed if we have initialized all uarts?
This patch might not needed if we have initialized all uarts right?

>
> Also, it's been a while since I tested this on OMAP2. =A0Please re-te=
st on
> OMAP2 with the whole series. =A0Also, please report here the other
> platforms this was tested on. =A0The final needs to be tested on OMAP=
2, 3
> and 4 before merge.

Yes Sure,

Just FYI this patch series was also tested on omap2,3,4.

>
>> This patch series is tested on mainline 2.6.36-rc4
>> and has dependencies on:
>>
>> 1) https://patchwork.kernel.org/patch/117148/
>> =A0 =A0 =A0 This patch to support all hwmod data with proper structu=
re name.
>>
>> 2) https://patchwork.kernel.org/patch/117347/
>> =A0 =A0 =A0 This patch is needed to apply omap4 uart hwmods.
>
> Can you rebase this against my pm-core branch, which already has thes=
e
> dependencies, as well as several other fixes to the hwmod and PM core=
s
> that are queued for 2.6.37?
>
> Thanks,
>
> Kevin
>
>> 3) http://marc.info/?l=3Dlinux-omap&m=3D128403141221947&w=3D2
>> =A0 =A0 =A0 This patch series is needed for omap4430SDP ES2.0 valida=
tion.
>>
>>
>> Benoit Cousson (1):
>> =A0 OMAP4: UART: Add uart1-4 hwmods data for omap4
>>
>> Govindraj.R (6):
>> =A0 OMAP2: UART: remove set_uart_globals.
>> =A0 OMAP clock: Add uart4_ick/fck definitions for 3630
>> =A0 OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>> =A0 OMAP3: PM: Add prepare idle and resume idle call for uart4
>> =A0 serial: Add OMAP high-speed UART driver
>> =A0 OMAP: SERIAL: Enable omap-serial driver in Kconfig.
>>
>> Kevin Hilman (4):
>> =A0 OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
>> =A0 OMAP: UART: omap_device converions, remove implicit 8520 assumpt=
ions
>> =A0 OMAP: UART: don't do automatic bus-level suspend/resume
>> =A0 OMAP: UART: use non-locking versions of hwmod enable/idle functi=
ons
>>
>> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 11 +-
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 =A0 =A0| =A0 22 =
+
>> =A0arch/arm/mach-omap2/cm-regbits-34xx.h =A0 =A0 =A0 =A0 | =A0 =A02 =
+
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c =A0 =A0| =A0193 ++++
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c =A0 =A0| =A0193 ++++
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 =A0| =A0253 +++++-
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 =A0| =A0235 +++++
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 17 +-
>> =A0arch/arm/mach-omap2/prcm-common.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
5 +
>> =A0arch/arm/mach-omap2/prm-regbits-34xx.h =A0 =A0 =A0 =A0| =A0 =A01 =
+
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0548 +++++-----
>> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 16 -
>> =A0arch/arm/plat-omap/include/plat/common.h =A0 =A0 =A0| =A0 =A01 -
>> =A0arch/arm/plat-omap/include/plat/dma.h =A0 =A0 =A0 =A0 | =A0 =A02 =
+
>> =A0arch/arm/plat-omap/include/plat/irqs.h =A0 =A0 =A0 =A0| =A0 =A02 =
+
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0129 +++
>> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 27 +
>> =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
>> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 1332 +++++++++++++++++++++++++
>> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +
>> =A020 files changed, 2699 insertions(+), 294 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>> =A0create mode 100644 drivers/serial/omap-serial.c
>
>
> [1]
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/=
mach-omap2/board-zoom-peripherals.c
> index 6b39849..641765a 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -282,4 +282,5 @@ void __init zoom_peripherals_init(void)
> =A0 =A0 =A0 =A0omap_i2c_init();
> =A0 =A0 =A0 =A0usb_musb_init(&musb_board_data);
> =A0 =A0 =A0 =A0enable_board_wakeup_source();
> + =A0 =A0 =A0 omap_serial_init();
> =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
