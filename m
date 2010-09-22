From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/9 v3]usb: musb: hwmod and runtime pm support for musb
Date: Wed, 22 Sep 2010 14:41:40 -0700
Message-ID: <87k4md8nhn.fsf@deeprootsystems.com>
References: <1285201596-26216-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201596-26216-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org> (Hema HK's
	message of "Wed, 22 Sep 2010 20:26:36 -0400")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hema HK <hemahk-l0cyMroinI0@public.gmane.org> writes:

> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
> This patch series makes OMAP2PLUS musb Module implemented
> in HWMOD FW way. It also implements musb driver to
> use the runtime pm apis.
>
> PATCH[1/8 v3] and [PATCH 2/8 v3] are the pre-requisites for the hwmod
> support for the usb module.
>
> [PATCH 9/9 v3] Is offmode fix for usb in idle path using runtime 
> pm apis.
>
> As per the OMAP usbotg specification[1] musb sysconfig register
> has to be set to force idle and force standby when not used
> and set smart idle/standby during operation.otherwise core-off
> will be prevented by musb.
>
> [1]: http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
>
> This patch series is created top of "origin/pm-core" and below patch
>
> OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
> [https://patchwork.kernel.org/patch/176172/]
> by Kevin
>
> This patch series is tested on OMAP3630 zoom3, OMAP4430 SDP OMAP2430SDP.
> On OMAP3630 zoom3, off mode is tested on "origin/pm" branch using 
> omap3_pm_defconfig.

Can you report some more details of what was tested: OTG mode?
peripheral mode? if so what drivers?  host mode? if so, what mode? mass
storage? etc.

Did the system still hit full-chip RET (or OFF) in idle?  in suspend?
did USB still work afterwards, etc.

Also, please fix up the subjects of the patches.  Only the drivers/usb
stuff should be prefixed with 'usb: musb:', the OMAP-specific code
should be prefixed with 'OMAP...'

Thanks,

Kevin


> Version History:
> ---------------
> Version v3
>
> Added the patch for adding the hwmod database for OMAP2430.
>
> Re-arranged the patches in such a way that first migrate the musb driver
> to use the runtime pm apis and then added a patch to support offmode in idle path.
> Calling the runtime pm apis before disabling the interupts in the idle path.
>
> Added the #ifdef CONFIG_PM_RUNTIME  check in the musb core driver for calling 
> the runtime PM APIs as non-omap platforms may not have the runtime pm enabled
> and clk_enable/disable should be called for them.
>
> Optimized the context save restore of musb registers only if the next state is
> going to offmode and previous state was offmode.
>
> Addressed few review comments on coding styles.
>
> Some of the links for v2 review comments
> ----------------------------------------
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg34068.html
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32024.html
> http://www.spinics.net/lists/linux-usb/msg35562.html
> http://www.spinics.net/lists/linux-usb/msg35720.html
>
> Vesrion v2:
>
> Fixed review comments.
> Removed the omap_hwmod.h inclusion from musb.h file which was 
> breaking the non-omap platform build.
> Using the runtime pm apis in the idle path(interrupts disabled).
> Added the omap4 hwmod data base.
>
> Version v1:
> initial version of the patch series.
>
> Some of the links for v1
> ------------------------
>
> http://www.spinics.net/lists/linux-usb/msg34570.html
> http://www.spinics.net/lists/linux-omap/msg34568.html
> http://www.spinics.net/lists/linux-usb/msg34544.html
> http://www.spinics.net/lists/linux-usb/msg34540.html
> http://www.spinics.net/lists/linux-usb/msg34589.html
> http://www.spinics.net/lists/linux-usb/msg34554.html
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32973.html
>
>
> Cousson, Benoit (1):
>   usb: musb: HWMOD database structures addition for OMAP4
>
> Hema HK (8):
>   usb: musb: Adding names for IRQs in resource structure
>   usb: musb: Remove board_data parameter from musb_platform_init()
>   usb: musb: HWMOD database structures addition for OMAP3
>   usb: musb: HWMOD database structures addition for OMAP2430
>   usb: musb: Using omap_device_build for musb device registration
>   OMAP: Hwmod api changes
>   usb : musb: Using runtime pm apis for musb.
>   usb : musb: Offmode fix for idle path
>   
>   arch/arm/mach-davinci/usb.c                |    2 +
>   arch/arm/mach-omap2/cpuidle34xx.c          |    1 +
>   arch/arm/mach-omap2/omap_hwmod.c           |   19 ++-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  102 ++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  105 +++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++++++++++++++++
>   arch/arm/mach-omap2/pm34xx.c               |    3 +
>   arch/arm/mach-omap2/usb-musb.c             |  175 ++++++++++++++++++++++------
>   arch/arm/plat-omap/include/plat/usb.h      |    2 +
>   arch/blackfin/mach-bf527/boards/cm_bf527.c |    2 +
>   arch/blackfin/mach-bf527/boards/ezbrd.c    |    2 +
>   arch/blackfin/mach-bf527/boards/ezkit.c    |    2 +
>   arch/blackfin/mach-bf548/boards/cm_bf548.c |    2 +
>   arch/blackfin/mach-bf548/boards/ezkit.c    |    2 +
>   drivers/usb/musb/blackfin.c                |    2 +-
>   drivers/usb/musb/cppi_dma.c                |    2 +-
>   drivers/usb/musb/davinci.c                 |    2 +-
>   drivers/usb/musb/musb_core.c               |   40 ++++++-
>   drivers/usb/musb/musb_core.h               |    2 +-
>   drivers/usb/musb/musbhsdma.c               |    2 +-
>   drivers/usb/musb/omap2430.c                |   63 ++++------
>   drivers/usb/musb/tusb6010.c                |    2 +-
>   include/linux/usb/musb.h                   |   13 ++
>  23 files changed, 560 insertions(+), 86 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
