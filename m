From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Tue, 11 Mar 2014 10:48:11 +0200
Message-ID: <531ECDCB.4060700@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393510711-4697-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lee,

On 02/27/2014 04:18 PM, Roger Quadros wrote:
> Hi,
> 
> This patchset brings up USB Host ports and Ethernet port on
> the OMAP5 uEVM board.
> 
> It also does some cleanup with respect to DT clock binding
> for the mfd/omap-usb-host driver.
> 
> Please queue these for -next.
> 
> Lee,
> 
> I've folded some platform data dependent patches with mfd patches
> so that they don't break functionality when applied individually.
> You can safely pull in all MFD patches (1 to 6).
> 
> Tony & Benoit,
> 
> Can you please accept patches 7, 8 and 9?

Tony has already picked up 7,8 and 9 through omap-soc tree.

Since you acked most patches except 5 and 6, are you fine if Tony takes
all the patches 1 to 4 in this series via omap-soc tree?

What about patches 5 and 6?

cheers,
-roger

> 
> Thanks.
> 
> Tested on:
>  - OMAP5 uEVM
>  - Pandaboard ES Rev. B1
>  - Beagleboard-XM Rev C2 (DT + Legacy)
>  - Beagleboard Rev C4 (DT + Legacy)
> 
> Changelog:
> 
> v9:
> - Folded dependent platform data patches into MFD patches.
> 
> v8:
> - Addressed review comments and split patch
>   "mfd: omap-usb-host: Get clocks based on hardware revision"
> - Removed unnecessary usb host dummy clocks on OMAP3
> - Removed unnecessary clock alias "ehci_logic_fck" for OMAP3
> - Rebased on 3.14-rc3
> 
> v7:
> - Rebased on 3.14-rc2
> - Removed incompatible ids from DT files and examples
> 
> v6:
> - Initialized clocks to -ENODEV and split patch 3.
> 
> v5:
> - Expose all clocks in the DT binding document for mfd:omap-usb-host
> and mfd:omap-usb-tll
> 
> v4:
> - Updated DT binding document for clock binding
> 
> v3:
> - Rebased on top of 3.13-rc7
> 
> cheers,
> -roger
> 
> ---
> Roger Quadros (9):
>   mfd: omap-usb-host: Get clocks based on hardware revision
>   mfd: omap-usb-host: Always fail on clk_get() error
>   mfd: omap-usb-host: Use proper clock name instead of alias
>   mfd: omap-usb-host: Use clock names as per function for reference
>     clocks
>   mfd: omap-usb-host: Update DT clock binding information
>   mfd: omap-usb-tll: Update DT clock binding information
>   ARM: OMAP2+: Remove legacy_init_ehci_clk()
>   ARM: dts: OMAP2+: Get rid of incompatible ids for USB host nodes
>   usb: omap: dts: Update DT binding example usage
> 
>  .../devicetree/bindings/mfd/omap-usb-host.txt      |  23 ++++
>  .../devicetree/bindings/mfd/omap-usb-tll.txt       |  10 ++
>  .../devicetree/bindings/usb/ehci-omap.txt          |   2 +-
>  .../devicetree/bindings/usb/ohci-omap3.txt         |   2 +-
>  arch/arm/boot/dts/omap3.dtsi                       |   4 +-
>  arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
>  arch/arm/boot/dts/omap4.dtsi                       |  10 +-
>  arch/arm/boot/dts/omap5-uevm.dts                   |   8 +-
>  arch/arm/boot/dts/omap5.dtsi                       |  10 +-
>  arch/arm/mach-omap2/cclock3xxx_data.c              |   4 -
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 --
>  arch/arm/mach-omap2/pdata-quirks.c                 |  16 ---
>  drivers/clk/ti/clk-3xxx.c                          |   4 -
>  drivers/mfd/omap-usb-host.c                        | 116 ++++++++++++++-------
>  14 files changed, 135 insertions(+), 88 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
