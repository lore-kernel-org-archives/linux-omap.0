From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] USB: twl4030: Enable USB regulators before enabling
 USB charging
Date: Fri, 20 Nov 2009 10:37:55 +0200
Message-ID: <20091120083755.GC8387@nokia.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20932 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZKTIkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 03:40:06 -0500
Content-Disposition: inline
In-Reply-To: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 19, 2009 at 07:34:55PM +0100, ext Aguilar Pena, Leed wrote:
>For TWL family of power management ICs, USB charging works only
>when USB regulators are in enabled state: 3v1, 1v5, 1v8
>
>On a USB cable attach, twl4030_phy_resume(twl) function enables
>the regulators. Enable USB charging, only after all regulators
>are enabled.
>
>Its observed that enabling USB charging before regulators are
>enabled, causes USB charging to fail.
>
>Tested on: Zoom2: omap3430: ES3.1 + TWL5030
>Needs T2-MADC and T2-BCI drivers which are still not upstreamed.
>
>Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
>Acked-by: Vikram Pandita <vikram.pandita@ti.com>
>Acked-by: Anand Gadiyar <gadiyar@ti.com>
>Acked-by: Nishanth Menon <nm@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

this should go to linux-usb, please Cc Greg KH and David Brownell.

-- 
balbi
