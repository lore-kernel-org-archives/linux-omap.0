From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] arm-soc: OMAP USB Host cleanup for 3.9
Date: Thu, 14 Feb 2013 08:48:08 -0800
Message-ID: <20130214164808.GZ7144@atomide.com>
References: <511CD215.8080005@ti.com>
 <511CD2CE.2020802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <511CD2CE.2020802@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "Balbi, Felipe" <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [130214 04:08]:
> Hi Tony,
> 
> This is the ARM-soc part of the OMAP USB Host cleanup series for 3.9.
> It is based on 3.8-rc6 + usbhost17-common that I sent earlier.
> 
> Please pull. Thanks.

Thanks for reworking this series! I'll pull this.

Regards,

Tony
 
> The following changes since commit 7f07863ec60f7d3dbeec5aff881ea074db3925ed:
> 
>   ARM: OMAP: Consolidate OMAP USB-HS platform data (part 1/3) (2013-02-13 13:22:34 +0200)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost17-for-arm-soc
> 
> Roger Quadros (1):
>       ARM: OMAP: Consolidate OMAP USB-HS platform data (part 3/3)
> 
>  arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
>  arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
>  arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
>  arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
>  arch/arm/mach-omap2/board-igep0020.c       |    4 +-
>  arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
>  arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
>  arch/arm/mach-omap2/board-overo.c          |    2 +-
>  arch/arm/mach-omap2/board-zoom.c           |    2 +-
>  arch/arm/mach-omap2/usb-host.c             |   29 ++++-----------------------
>  arch/arm/mach-omap2/usb.h                  |   20 +------------------
>  18 files changed, 23 insertions(+), 60 deletions(-)
> 
> --
> cheers,
> -roger
