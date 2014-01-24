From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library
 returns -ENODEV/-ENXIO
Date: Fri, 24 Jan 2014 19:39:12 +0530
Message-ID: <52E27408.8060808@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com> <1390299099-14764-1-git-send-email-kishon@ti.com> <20140121144725.GF30451@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140121144725.GF30451@saruman.home>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: george.cherian@ti.com, heikki.krogerus@linux.intel.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 21 January 2014 08:17 PM, Felipe Balbi wrote:
> On Tue, Jan 21, 2014 at 03:41:38PM +0530, Kishon Vijay Abraham I wrote:
>> Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
>> do not return from probe if the USB PHY library returns -ENODEV as that
> 
> this isn't correct, they all have PHYs, some of them might not be
> controllable.

right, but we use USB PHY library only for controllable PHYs (apart from using
nop).
> 
>> indicates the platform does not have PHY.
> 
> not really, that indicates the current platform tried to grab a PHY and
> the PHY doesn't exist. If there's anybody with a non-controllable PHY
> and someone gives me a really good reason for not using the generic
> no-op PHY, then we should add a flag and we could:
> 
> 	if (!likely(dwc->flags & DWC3_USB2PHY_DRIVER_NOT_NEEDED))
> 		dwc3_grab_phys(dwc);
> 
> But I really want to see the argument against using no-op. As far as I
> could see, everybody needs a PHY driver one way or another, some
> platforms just haven't sent any PHY driver upstream and have their own
> hacked up solution to avoid using the PHY layer.

I was trying to address Heikki concerns in my previous version [1] where I used
quirks to identify if the platform does not have PHY.

[1] -> https://lkml.org/lkml/2013/12/5/32

Thanks
Kishon
