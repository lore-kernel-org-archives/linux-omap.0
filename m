From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Fri, 21 Sep 2012 23:33:52 +0200
Message-ID: <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com> <1346943430-18236-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41562 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087Ab2IUVed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 17:34:33 -0400
In-Reply-To: <1346943430-18236-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

2012/9/6 Kishon Vijay Abraham I <kishon@ti.com>:
> All the PHY configuration other than VBUS, ID GND and OTG SRP are removed
> from twl6030. The phy configurations are taken care by the dedicated
> usb2 phy driver. So twl6030 is made as comparator driver for VBUS and
> ID detection.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

USB doesn't work on pandaboard on linux-next, and bisection shows this
patch.  Unfortunately, I can't provide a dmesg log because USB is the
only way I currently have to get one out(!), but presumably it's because
this omap-usb2 device is never registered?  Looks like this breaks
non-dt USB on pandaboard; is that intended?

(I see that current linux-next doesn't have USB support even in
 pandaboard DT, but I see patches for that on the lists)
