From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7 V2] usb: otg: Adding twl6030-usb transceiver driver
 for
Date: Fri, 10 Dec 2010 12:28:03 +0200
Message-ID: <20101210102803.GB6027@legolas.emea.dhcp.ti.com>
References: <1291964658-7076-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45471 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754994Ab0LJK2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 05:28:08 -0500
Content-Disposition: inline
In-Reply-To: <1291964658-7076-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

On Fri, Dec 10, 2010 at 12:34:18PM +0530, Hema HK wrote:
>Adding the twl6030-usb transceiver support for OMAP4 musb driver.
>
>OMAP4 supports 2 types of transceiver interface.
>
>1. UTMI: The PHY is embedded within OMAP4. The transceiver functionality
>is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin
>sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
>functionality is embedded within the OMAP4430.
>
>There is no direct interactions between the MUSB controller and TWL6030
>chip to communicate the session-valid, session-end and ID-GND events.
>It has to be done through a software by setting/resetting bits in
>one of the control module register of OMAP4430 which in turn toggles
>the appropriate signals to MUSB controller.
>
>The internal transceiver has functional clocks and
>powerdown bits to powerdown the PHY for power saving.
>
>Since there is no option available for having 2 transceiver drivers
>for one USB controller, internal PHY specific APIs are passed through
>plaform_data function pointers to use in the twl6030-usb transceiver
>driver.
>
>2. ULPI interface is provided for off-chip transceivers.
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: David Brownell <dbrownell@users.sourceforge.net>
>---
> arch/arm/mach-omap2/omap_phy_internal.c |  149 +++++++++

this file will never be compiled.

-- 
balbi
