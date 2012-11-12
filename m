From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] musb regression fixes for v3.7-rc4
Date: Mon, 12 Nov 2012 16:22:17 +0000
Message-ID: <201211121622.17616.arnd@arndb.de>
References: <20121109223939.GZ6801@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60599 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2KLQWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 11:22:21 -0500
In-Reply-To: <20121109223939.GZ6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 09 November 2012, Tony Lindgren wrote:
> This series fixes an annoying regression to make MUSB working
> on omap4 again. Although it's getting rather late for these
> changes for the -rc cycle, it is important as many devices
> are using MUSB for charging and connectivity.
> 
> With the USB PHY changes, MUSB started using the newly added
> drivers/usb/phy/omap-usb2.c driver introduced by commit
> 657b306a (usb: phy: add a new driver for omap usb2 phy)
> that is using the newly introduced drivers/bus/omap-ocp2scp.c
> introduced by commit 26a84b3e (drivers: bus: add a new driver
> for omap-ocp2scp).
> 
> These changes allowed dropping a lot of PHY related code from
> arch/arm/mach-omap2/omap_phy_internal.c and have it live in
> the device driver like it should with commit c9e4412a (arm: omap:
> phy: remove unused functions from omap-phy-internal.c).
> 
> However, MUSB on omap4 broke with these changes for legacy
> platform data boot, and now only works with device tree for
> omap4. Unfortunately we are still few critical bindings away
> from being able to make omap4 usbale with device tree.
> 
> Fix the regression properly by adding platform data support
> to the ocp2scp driver so we can avoid adding back the driver
> code to arch/arm/mach-omap2.
> 

Applied to fixes branch, will send this soon.

	Arnd
