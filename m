From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH V3 0/5] ARM: OMAP: TLL driver implementation for USB host driver
Date: Mon, 2 Jul 2012 20:35:11 +0530
Message-ID: <CAP05o4+bUbywZ-4O0rsdnM1P0jFJMsh-kdYCMfFEk-X7fhsZ8A@mail.gmail.com>
References: <1341241305-414-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34925 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab2GBPFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 11:05:17 -0400
Received: by lbbgj3 with SMTP id gj3so8337477lbb.11
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 08:05:11 -0700 (PDT)
In-Reply-To: <1341241305-414-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, paul@pwsan.com, b-cousson@ti.com, sshtylyov@mvista.com, tony@atomide.com

On Mon, Jul 2, 2012 at 8:31 PM, Keshava Munegowda <keshava_mgowda@ti.com> wrote:
> The TLL configuration is removed from the UHH driver and implemented as
> a seperate platform driver. Now, the UHH driver configures the TLL
> through API's exported by the TLL platform driver. The TLL is an
> has independent hardware mod structure for in OMAP3 and later chips,
> hence an dedicated platform driver is created.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
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
>
> Keshava Munegowda (5):
>   ARM: OMAP: USB: HOST TLL platform driver
>   ARM: OMAP: USB: Build the USB HOST TLL omap device
>   ARM: OMAP: USB: Remove TLL specific code
>   ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
>   ARM: OMAP: change the USB TLL clocks device name
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

Hi Paul and Tony
  since Felipe Balbi is on vacation , Can I get your ack by please?
This is good candidate to v3.5 kernel.

paul,
   Just to remind you that, in last ELC Europe , we discussed about the
design of split of UHH and TLL drivers. This series does the same.

regards
keshava
