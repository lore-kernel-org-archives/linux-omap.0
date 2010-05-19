From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Wed, 19 May 2010 10:54:05 +0200
Message-ID: <4BF3A72D.3080501@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39216 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab0ESIyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 04:54:12 -0400
In-Reply-To: <1274194260-16401-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On 5/18/2010 4:50 PM, Charulatha V wrote:
> This patch series implements GPIO module in platform device model.
> It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
>
> This patch series is created on "origin/pm-wip/runtime".
>
> This patch series is tested on OMAP3430 SDP board. It would be of
> great help if someone could test the same on OMAP1 and OMAP2 boards.

What about OMAP4? Didn't you test it on SDP or Blaze?

Benoit

> Charulatha V (11):
>    OMAP: GPIO: Modify init() in preparation for platform device
>      implementation
>    OMAP: GPIO: Include platform_data structure for GPIO
>    OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
>    OMAP: GPIO: Introduce support for OMAP16xx chip GPIO init
>    OMAP: GPIO: Introduce support for OMAP7xx chip GPIO init
>    OMAP: GPIO: add GPIO hwmods structures for OMAP3
>    OMAP: GPIO: add GPIO hwmods structures for OMAP242X
>    OMAP: GPIO: add GPIO hwmods structures for OMAP243X
>    OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
>    OMAP: GPIO: Implement GPIO as a platform device
>    OMAP: GPIO: Remove omap_gpio_init()
>
>   arch/arm/mach-omap1/Makefile               |    6 +
>   arch/arm/mach-omap1/board-ams-delta.c      |    1 -
>   arch/arm/mach-omap1/board-fsample.c        |    1 -
>   arch/arm/mach-omap1/board-h2.c             |    1 -
>   arch/arm/mach-omap1/board-h3.c             |    1 -
>   arch/arm/mach-omap1/board-htcherald.c      |    1 -
>   arch/arm/mach-omap1/board-innovator.c      |    1 -
>   arch/arm/mach-omap1/board-nokia770.c       |    1 -
>   arch/arm/mach-omap1/board-osk.c            |    1 -
>   arch/arm/mach-omap1/board-palmte.c         |    1 -
>   arch/arm/mach-omap1/board-palmz71.c        |    1 -
>   arch/arm/mach-omap1/board-perseus2.c       |    1 -
>   arch/arm/mach-omap1/board-sx1.c            |    1 -
>   arch/arm/mach-omap1/board-voiceblue.c      |    1 -
>   arch/arm/mach-omap1/clock_data.c           |    2 +-
>   arch/arm/mach-omap1/gpio15xx.c             |  104 +++++
>   arch/arm/mach-omap1/gpio16xx.c             |  202 +++++++++
>   arch/arm/mach-omap1/gpio7xx.c              |  266 ++++++++++++
>   arch/arm/mach-omap2/Makefile               |    2 +-
>   arch/arm/mach-omap2/board-2430sdp.c        |    1 -
>   arch/arm/mach-omap2/board-3430sdp.c        |    1 -
>   arch/arm/mach-omap2/board-3630sdp.c        |    1 -
>   arch/arm/mach-omap2/board-4430sdp.c        |    1 -
>   arch/arm/mach-omap2/board-am3517evm.c      |    1 -
>   arch/arm/mach-omap2/board-apollon.c        |    1 -
>   arch/arm/mach-omap2/board-cm-t35.c         |    1 -
>   arch/arm/mach-omap2/board-devkit8000.c     |    1 -
>   arch/arm/mach-omap2/board-h4.c             |    1 -
>   arch/arm/mach-omap2/board-igep0020.c       |    1 -
>   arch/arm/mach-omap2/board-ldp.c            |    1 -
>   arch/arm/mach-omap2/board-n8x0.c           |    1 -
>   arch/arm/mach-omap2/board-omap3beagle.c    |    1 -
>   arch/arm/mach-omap2/board-omap3evm.c       |    1 -
>   arch/arm/mach-omap2/board-omap3pandora.c   |    1 -
>   arch/arm/mach-omap2/board-omap3touchbook.c |    1 -
>   arch/arm/mach-omap2/board-overo.c          |    1 -
>   arch/arm/mach-omap2/board-rx51.c           |    1 -
>   arch/arm/mach-omap2/board-zoom2.c          |    1 -
>   arch/arm/mach-omap2/board-zoom3.c          |    1 -
>   arch/arm/mach-omap2/clock2420_data.c       |   10 +-
>   arch/arm/mach-omap2/clock2430_data.c       |   14 +-
>   arch/arm/mach-omap2/clock3xxx_data.c       |   24 +-
>   arch/arm/mach-omap2/clock44xx_data.c       |   24 +-
>   arch/arm/mach-omap2/gpio.c                 |  113 +++++
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |  222 ++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  270 ++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  357 ++++++++++++++++-
>   arch/arm/plat-omap/gpio.c                  |  622 ++++++++++------------------
>   arch/arm/plat-omap/include/plat/gpio.h     |   84 ++++-
>   49 files changed, 1886 insertions(+), 469 deletions(-)
>   create mode 100644 arch/arm/mach-omap1/gpio15xx.c
>   create mode 100644 arch/arm/mach-omap1/gpio16xx.c
>   create mode 100644 arch/arm/mach-omap1/gpio7xx.c
>   create mode 100644 arch/arm/mach-omap2/gpio.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

