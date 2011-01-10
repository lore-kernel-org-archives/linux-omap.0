From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes
Date: Mon, 10 Jan 2011 11:04:37 -0800
Message-ID: <20110110190436.GE4957@atomide.com>
References: <1294441282-17986-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34228 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1AJTEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 14:04:42 -0500
Content-Disposition: inline
In-Reply-To: <1294441282-17986-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

* Nishanth Menon <nm@ti.com> [110107 15:00]:
> Hi,
> As discussed in the threads:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> http://marc.info/?t=121540030800004&r=1&w=2
> 
> here is the split up series with commit message after discussion:
> http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21
> 
> Koen Kooi (3):
>   omap3: beaglexm: fix EHCI power up GPIO dir
>   omap3: beaglexm: fix DVI reset GPIO
>   omap3: beaglexm: fix power on of DVI

Dropping the earlier versions from omap-fixes, I want to get the
build fixes in ASAP. These can wait a bit until Aaro's comments
are addressed.

Regards,

Tony
