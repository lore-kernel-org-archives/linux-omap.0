From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/8 V3] usb: otg: TWL6030: OMAP4430: musb & transceiver
 driver support for OMAP4
Date: Fri, 10 Dec 2010 15:11:20 +0200
Message-ID: <20101210131120.GM6027@legolas.emea.dhcp.ti.com>
References: <1291983874-13903-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291983874-13903-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 05:54:34PM +0530, Hema HK wrote:
>This patch series has the support for TWL6030-usb
>transceiver driver and changes in the musb driver to make it functional
>with OMAP4430.
>
>OMAP4 musb support UTMI and ULPI transceiver interfaces.
>
>In UTMI mode, the transceiver functionality is split between
>the TWL6030 PMIC chip and OMAP4 embedded PHY.
>The TWL6030 transceiver driver code is under otg folder and
>internal UTMI PHY specific code changes are defined under
>mach-omap2 directory and functions are passed through platform_data
>structure.
>
>This patch series is based on V2.6.37-rc4 + [1]+[2]
>
>[1] http://www.listware.net/201011/linux-usb/
>65625-patch-resend-v3-usb-musb-do-not-use-dma-for-control-transfers.html
>
>[2] Felipe's musb-reorg patch series.
>	http://gitorious.org/usb/usb/commits/musb-hw
>
>Tested musb device and host mode functionality with OMAP4430SDP
>and OMAP3630 ZOOM3.
>
>Limitation: In OTG and Host only mode, when the device is connected
>during boot will not be detected.
>Need connect the device only after the boot. Or disconnect and connect
>it back if it connected during boot.
>Fix for this will be submitted later.
>
>Version History:
>-------------------
>Version3 changes:
>- Rearranged the patches to avoid the git bisect failure.
>
>Version 2 changes:
>- Removed the dependency on the atomic notifier patches from Arnaud.
>- Fixed review comments from Felipe and Sergei.
>- Modified the vbus_set function to set timeout when musb is not configured
>as A device.

This series is applied but I still have to test, so I could still drop
heh.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
