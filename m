From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/7 V2] usb: otg: Adding twl6030-usb transceiver driver
 for
Date: Fri, 10 Dec 2010 12:33:44 +0200
Message-ID: <20101210103344.GE6027@legolas.emea.dhcp.ti.com>
References: <1291964658-7076-1-git-send-email-hemahk@ti.com>
 <20101210102803.GB6027@legolas.emea.dhcp.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101210102803.GB6027-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 12:28:03PM +0200, Felipe Balbi wrote:
>On Fri, Dec 10, 2010 at 12:34:18PM +0530, Hema HK wrote:
>>Adding the twl6030-usb transceiver support for OMAP4 musb driver.
>>
>>OMAP4 supports 2 types of transceiver interface.
>>
>>1. UTMI: The PHY is embedded within OMAP4. The transceiver functionality
>>is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin
>>sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
>>functionality is embedded within the OMAP4430.
>>
>>There is no direct interactions between the MUSB controller and TWL6030
>>chip to communicate the session-valid, session-end and ID-GND events.
>>It has to be done through a software by setting/resetting bits in
>>one of the control module register of OMAP4430 which in turn toggles
>>the appropriate signals to MUSB controller.
>>
>>The internal transceiver has functional clocks and
>>powerdown bits to powerdown the PHY for power saving.
>>
>>Since there is no option available for having 2 transceiver drivers
>>for one USB controller, internal PHY specific APIs are passed through
>>plaform_data function pointers to use in the twl6030-usb transceiver
>>driver.
>>
>>2. ULPI interface is provided for off-chip transceivers.
>>
>>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>---
>>arch/arm/mach-omap2/omap_phy_internal.c |  149 +++++++++
>
>this file will never be compiled.

another comment:

$SUBJECT looks incomplete "Adding twl6030-usb transceiver driver for",
makes me wonder "for what ?!?"

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
