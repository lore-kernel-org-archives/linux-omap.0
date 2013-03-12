From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/24] ARM: OMAP2+: Adapt to ehci-omap changes for 3.10
Date: Tue, 12 Mar 2013 09:40:07 -0700
Message-ID: <20130312164007.GZ26093@atomide.com>
References: <1363088606-2692-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363088606-2692-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, b-cousson@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [130312 04:47]:
> Hi Tony,
> 
> These patches provide the SoC side code required to support
> the changes in the OMAP USB Host drivers done in [1], [2] & [3].
... 

>  arch/arm/mach-omap2/board-3430sdp.c                |   97 +++++++++++++++-
>  arch/arm/mach-omap2/board-3630sdp.c                |  100 +++++++++++++++-
>  arch/arm/mach-omap2/board-am3517crane.c            |   95 +++++++++++++--
>  arch/arm/mach-omap2/board-am3517evm.c              |   66 ++++++++++-
>  arch/arm/mach-omap2/board-cm-t35.c                 |   95 ++++++++++++++-
>  arch/arm/mach-omap2/board-cm-t3517.c               |   97 +++++++++++++++-
>  arch/arm/mach-omap2/board-devkit8000.c             |   20 ++--
>  arch/arm/mach-omap2/board-generic.c                |   67 +++++++++++
>  arch/arm/mach-omap2/board-igep0020.c               |  112 ++++++++++++++++---
>  arch/arm/mach-omap2/board-omap3beagle.c            |   93 +++++++++++++--
>  arch/arm/mach-omap2/board-omap3evm.c               |   62 ++++++++--
>  arch/arm/mach-omap2/board-omap3pandora.c           |   52 +++++++--
>  arch/arm/mach-omap2/board-omap3stalker.c           |   52 +++++++-
>  arch/arm/mach-omap2/board-omap3touchbook.c         |   62 +++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c             |  122 ++++++++++++++------
>  arch/arm/mach-omap2/board-overo.c                  |   54 ++++++++-
>  arch/arm/mach-omap2/board-zoom.c                   |   56 ++++++++-

Can't you have some mach-omap2/ehci-common.c that takes care
of the initializiation to avoid this much addition to the
board-*.c files? You may be able to have just a common function
to do it and pass few parameters?

Regards,

Tony
