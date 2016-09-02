From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] phy: omap-usb2: Fixes for v4.9
Date: Fri, 2 Sep 2016 17:47:39 +0530
Message-ID: <57C96DE3.6030907@ti.com>
References: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471942661-1728-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 23 August 2016 02:27 PM, Roger Quadros wrote:
> Hi Kishon & Tony,
> 
> Here are some fixes found in the TI vendor tree for omap-usb2 PHY
> and are important for upstream. Please queue for -next if OK. Thanks.

merged the phy patches to linux-phy -next

Thanks
Kishon
> 
> The 3rd patch should probably go via Tony's SoC DT tree.
> 
> cheers,
> -roger
> 
> Sekhar Nori (3):
>   phy: omap-usb2: support suspend/resume
>   dt-bindings: phy: ti: add documentation for ti,dra7x-usb2
>   ARM: dts: dra7: workaround silicon limitation i845
> 
>  Documentation/devicetree/bindings/phy/ti-phy.txt |   2 +
>  arch/arm/boot/dts/dra7.dtsi                      |   2 +-
>  drivers/phy/phy-omap-usb2.c                      | 100 +++++++++++------------
>  3 files changed, 49 insertions(+), 55 deletions(-)
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
