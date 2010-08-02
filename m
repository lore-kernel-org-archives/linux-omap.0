From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 0/5] HTC Herald various device support
Date: Mon, 2 Aug 2010 08:27:02 -0700
Message-ID: <AANLkTinO4AFFsw9oc+UE+2=8oaykqC4T4kmvVovuEATA@mail.gmail.com>
References: <1280762636-17206-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45288 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab0HBPdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 11:33:17 -0400
Received: by wwf26 with SMTP id 26so9871869wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Aug 2010 08:33:15 -0700 (PDT)
In-Reply-To: <1280762636-17206-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

ok, so apparently I had the wrong address for the linux-arm-kernel
list, so I'll be resubmitting the series again, with the correct
address.

Sorry for the spam...

- Cory

On Mon, Aug 2, 2010 at 8:23 AM, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
> This patch set is an updated version of a series of patches I submitt=
ed
> a while ago. =C2=A0It's built against the latest linux-omap master br=
anch, and
> removes all defconfig updates. =C2=A0Other comments were put in place=
 as well.
>
> This patch set implements the following drivers and support for them =
into
> the HTC Herald:
>
> =C2=A0* MMC card support
> =C2=A0* I2C and HTCPLD drivers
> =C2=A0* TSC2046 touchscreen support
> =C2=A0* Serial port fixes for omap7xx
> =C2=A0* Bluetooth common code for HTC omap7xx smartphones
>
> The bluetooth drivers are implemented with the expectation that they =
will
> be used by other devices once the board files are submitted (Elf/Elfi=
n,
> Opal, etc).
>
> Cory Maccarrone (5):
> =C2=A0[OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices
> =C2=A0[OMAP] htcherald: SPI register config, TSC2046 touchscreen
> =C2=A0[omap1] omap7xx clocks, mux, serial fixes
> =C2=A0[omap1] Bluetooth device code common to HTC smartphones
> =C2=A0[htcherald] Add board support for UARTs, bluetooth
>
> =C2=A0arch/arm/mach-omap1/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
> =C2=A0arch/arm/mach-omap1/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-omap1/board-htcherald.c =C2=A0 =C2=A0 | =C2=A0346=
 ++++++++++++++++++++++++++++-
> =C2=A0arch/arm/mach-omap1/clock_data.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 20 ++
> =C2=A0arch/arm/mach-omap1/htc-bt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0183 +++++++++++++++
> =C2=A0arch/arm/mach-omap1/include/mach/htc-bt.h | =C2=A0 22 ++
> =C2=A0arch/arm/mach-omap1/mux.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +
> =C2=A0arch/arm/mach-omap1/serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A07 +
> =C2=A0arch/arm/plat-omap/include/plat/mux.h =C2=A0 =C2=A0 | =C2=A0 =C2=
=A04 +
> =C2=A09 files changed, 583 insertions(+), 7 deletions(-)
> =C2=A0create mode 100644 arch/arm/mach-omap1/htc-bt.c
> =C2=A0create mode 100644 arch/arm/mach-omap1/include/mach/htc-bt.h
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
