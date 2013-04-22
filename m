From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 14:11:12 +0530
Message-ID: <5174F7A8.7070308@ti.com>
References: <20130419171318.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60463 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037Ab3DVIlY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 04:41:24 -0400
In-Reply-To: <20130419171318.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

Hi,

On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> Hi all,
>
> Here's a list of breakage I've noticed so far while trying to
> use linux next on my pandaboard es. Probably similar issues exist
> on other boards as well.
>
> Ideally we would not have any breakage by the merge window, so
> let's try to get these fixed ASAP:
>
> 1. Serial console broken on panda es booting with DT
>
> The symptoms are dmesg output stopping after few lines
> and only continuing after pressing a key. Does not seem to
> happen on blaze with DT for some reason. And does not happen
> on panda es with legacy booting.
>
> 2. MUSB fails with legacy booting and DT on panda es
>
> With both legacy and DT booting I get something like:
>
> HS USB OTG: no transceiver configured
> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

The dt should work fine with https://patchwork.kernel.org/patch/2423061/.

But non-dt has got a real issue. We were using usb_bind_phy() for 
binding the controller with the PHY (we use device names). But in 
linux-next the device names have changed because of using 
PLATFORM_DEVID_AUTO. We can modify the usb_bind_phy() calls to use the 
new device names, But I suspect the device names can change again. Not 
sure what we can do here :-(

Thanks
Kishon
