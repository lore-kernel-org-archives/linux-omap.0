From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC: WL1271 DC supprot on OMAP3EVM 0/5]
Date: Wed, 13 Oct 2010 13:54:30 +0200
Message-ID: <AANLkTinusH4eA1DsUekuA17GRkyy9TK14JJQcZfz4wqk@mail.gmail.com>
References: <1286967439-705-1-git-send-email-csanjay@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36099 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0JMLyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Oct 2010 07:54:51 -0400
In-Reply-To: <1286967439-705-1-git-send-email-csanjay@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: csanjay@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org

Hi Sanjay,

On Wed, Oct 13, 2010 at 12:57 PM,  <csanjay@mistralsolutions.com> wrote=
:
> Sanjay Kumar Champati (5):
> =A0ARM: Supported MMC 2 features for OMAP3EVM
> =A0ARM: Supported for Standard SDIO driver on OMAP3EVM for WL1271 DC
> =A0ARM: Supported for BT enable on OMAP3EVM for WL1271 DC
> =A0ARM: Added ALSA audio support for WL1271 DC over the PCM interface
> =A0 =A0(OMAP37XX)
> =A0Supported BT and WLAN configuration for WL1271 over the OMAP37XX

There are many things to say here but maybe the most important one is
that it seems you are trying to push changes that are only relevant
for an out-of-tree driver, and such changes will never be accepted.

Why don't you try out the mainline wl1271 driver on your board and
come back with the necessary changes for that ?

Thanks,
Ohad.


>
> =A0arch/arm/configs/omap3_evm_defconfig | =A0 27 +++++++-
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 28 ++++++++-
> =A0arch/arm/mach-omap2/mmc-twl4030.c =A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-omap2/mmc-twl4030.h =A0 =A0| =A0 =A02 +
> =A0drivers/bluetooth/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
> =A0drivers/char/tty_io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0110 ++++=
++++++++++++++++++++++++++++++
> =A0drivers/mmc/core/sdio_ops.c =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++-
> =A0drivers/net/wireless/Kconfig =A0 =A0 =A0 =A0 | =A0 11 ++++
> =A0sound/soc/omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ++
> =A0sound/soc/omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0sound/soc/omap/omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 81 ++++++++=
++++++++++++++++-
> =A0sound/soc/omap/wl1271bt.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 59 ++++++++=
++++++++++
> =A0sound/soc/omap/wl1271bt.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 16 +++++
> =A013 files changed, 350 insertions(+), 7 deletions(-)
> =A0create mode 100644 sound/soc/omap/wl1271bt.c
> =A0create mode 100644 sound/soc/omap/wl1271bt.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
