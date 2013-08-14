From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/7] phy: omap-usb: Support multiple instances and new
 types
Date: Wed, 14 Aug 2013 10:44:32 +0300
Message-ID: <520B3560.7020004@ti.com>
References: <1375365915-21380-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375365915-21380-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Benoit

Hi Felipe,

Any comments on this series?

cheers,
-roger

On 08/01/2013 05:05 PM, Roger Quadros wrote:
> Hi,
> 
> This patchset does the following:
> 
> * Restructure and add support for new PHY types. We now support the follwing
> four types
> 
>  TYPE1 - if it has otghs_control mailbox register (e.g. on OMAP4)
>  TYPE2 - if it has Power down bit in control_dev_conf register. e.g. USB2 PHY
>  TYPE3 - if it has DPLL and individual Rx & Tx power control. e.g. USB3 PHY or SATA PHY
>  TYPE4 - if it has both power down and power aux registers. e.g. USB2 PHY on DRA7
> 
> * Have only one power control API "omap_control_usb_phy_power()" instead of a
> different one for each PHY type.
> 
> * Get rid of omap_get_control_dev() so that we can support multiple instances
> of the control device. We take advantage of the fact that omap control USB device
> is only present on OMAP4 onwards and hence only supports DT boot. The users
> of control USB device can get a reference to it from the device node's phandle.
> 
> Patches are based on top of v3.11-rc3 with balbi/next on top.
> 
> Smoke tested on OMAP4 panda with MUSB in gadget mode (g_zero).
> 
> You can find the patches in branch
>  usb-control-module
> in git tree
>  git://github.com/rogerq/linux.git
> 
> cheers,
> -roger
> 
> Roger Quadros (7):
>   usb: phy: omap: Add new PHY types and remove
>     omap_control_usb3_phy_power()
>   usb: phy: omap-usb2: Don't use omap_get_control_dev()
>   usb: phy: omap-usb3: Don't use omap_get_control_dev()
>   usb: musb: omap2430: Don't use omap_get_control_dev()
>   usb: phy: omap: get rid of omap_get_control_dev()
>   ARM: dts: omap4: update omap-control-usb nodes
>   ARM: dts: omap5: update omap-control-usb node
> 
>  Documentation/devicetree/bindings/usb/omap-usb.txt |   23 ++--
>  arch/arm/boot/dts/omap4.dtsi                       |   17 ++-
>  arch/arm/boot/dts/omap5.dtsi                       |   18 ++-
>  drivers/usb/musb/omap2430.c                        |   22 +++-
>  drivers/usb/phy/phy-omap-control.c                 |  160 ++++++++++---------
>  drivers/usb/phy/phy-omap-usb2.c                    |   20 ++-
>  drivers/usb/phy/phy-omap-usb3.c                    |   26 +++-
>  include/linux/usb/omap_control_usb.h               |   23 +--
>  8 files changed, 182 insertions(+), 127 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
