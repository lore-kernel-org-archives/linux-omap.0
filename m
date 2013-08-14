From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [GIT PULL, FOR LINUX-OMAP] usb: nop phy rename
Date: Wed, 14 Aug 2013 01:39:20 -0700
Message-ID: <20130814083919.GX7656@atomide.com>
References: <20130809142824.GO12041@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130809142824.GO12041@radagast>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [130809 07:35]:
> Hi Tony,
> 
> here's a pull request of one patch to avoid conflicts during the merge
> window.
> 
> Please consider applying to your tree and I'll take this same patch
> upstream.

Thanks, pulling into omap-for-v3.12/usb.

Regards,

Tony
 
> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
> 
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git nop-phy-rename
> 
> for you to fetch changes up to 3fa4d7344be0afebd80382ffeea6b1787cccf971:
> 
>   usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv (2013-08-09 17:26:00 +0300)
> 
> ----------------------------------------------------------------
> Sebastian Andrzej Siewior (1):
>       usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv
> 
>  arch/arm/mach-omap2/board-omap3beagle.c            |  4 +-
>  arch/arm/mach-omap2/board-omap3evm.c               |  4 +-
>  arch/arm/mach-omap2/board-omap3pandora.c           |  2 +-
>  arch/arm/mach-omap2/usb-host.c                     | 10 ++---
>  drivers/usb/dwc3/dwc3-exynos.c                     |  8 ++--
>  drivers/usb/dwc3/dwc3-pci.c                        |  8 ++--
>  drivers/usb/musb/am35x.c                           |  2 +-
>  drivers/usb/musb/blackfin.c                        |  2 +-
>  drivers/usb/musb/da8xx.c                           |  2 +-
>  drivers/usb/musb/davinci.c                         |  2 +-
>  drivers/usb/musb/musb_dsps.c                       |  2 +-
>  drivers/usb/musb/tusb6010.c                        |  2 +-
>  drivers/usb/phy/Makefile                           |  2 +-
>  drivers/usb/phy/{phy-nop.c => phy-generic.c}       | 44 +++++++++++-----------
>  .../usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h}   |  4 +-
>  15 files changed, 49 insertions(+), 49 deletions(-)
>  rename drivers/usb/phy/{phy-nop.c => phy-generic.c} (83%)
>  rename include/linux/usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h} (81%)
> 
> -- 
> balbi


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
