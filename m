From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Thu, 19 Jul 2012 15:48:44 +0530
Message-ID: <CAP05o4+O8FXRjnXtta26rUoZpcMnpZEkdu9+J0xatCyusrjQEw@mail.gmail.com>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59443 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714Ab2GSKSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 06:18:49 -0400
Received: by lbgc1 with SMTP id c1so3854822lbg.29
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 03:18:44 -0700 (PDT)
In-Reply-To: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, balbi@ti.com, Paul Walmsley <paul@pwsan.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, parthab@india.ti.com

On Mon, Jul 16, 2012 at 7:01 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> The TLL (Transceiver Less Link) is an separate IP block, independent of
> the host controller. Basically this TLL operates like USB PHY which allows
> the user to connect two USB transceiver interfaces together directly
> without the use of differential transceivers in omap3 and later chips.
> The TLL configuration is removed from the UHH driver and implemented as
> a seperate platform driver. Now, the UHH driver configures the TLL
> through API's exported by the TLL platform driver.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>
> In v4:
>     - rebased on top of linux kernel version 3.5.rc7
>     - reworked as per the comments given by Paul Walmsley <paul@pwsan.com>
>
> In v3:
>   - rebased on top V3 of Russ dill's patch
>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
>        fixes an issue where the ULPI PHYs were not held in reset
>        while initializing the EHCI controller
>         http://permalink.gmane.org/gmane.linux.usb.general/65988
>
>   - rebased on top of patch
>     OMAP: USB : Fix the EHCI enumeration and core retention issue
>      http://permalink.gmane.org/gmane.linux.usb.general/66239
>
> In V2:
>     - covered review comments from linux omap and usb community
>     - rebased on top Russ dill's patch
>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
>        fixes an issue where the ULPI PHYs were not held in reset
>        while initializing the EHCI controller
>
> Keshava Munegowda (5):
>   ARM: OMAP: Add the USB TLL clocks device name
>   ARM: OMAP: USB: HOST TLL platform driver
>   ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
>   ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
>   ARM: OMAP: Remove older device name of the USB TLL clocks
>
>  arch/arm/mach-omap2/clock3xxx_data.c  |    8 +-
>  arch/arm/mach-omap2/clock44xx_data.c  |    4 +-
>  arch/arm/mach-omap2/usb-host.c        |   31 ++-
>  arch/arm/plat-omap/include/plat/usb.h |    7 +
>  drivers/mfd/Kconfig                   |    2 +-
>  drivers/mfd/Makefile                  |    2 +-
>  drivers/mfd/omap-usb-host.c           |  238 ++---------------
>  drivers/mfd/omap-usb-tll.c            |  471 +++++++++++++++++++++++++++++++++
>  8 files changed, 523 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/mfd/omap-usb-tll.c
>
> --
> 1.7.9.5


Felipe/ Paul
      please let me know if you have any review comments on this v4 series.

regards
keshava
