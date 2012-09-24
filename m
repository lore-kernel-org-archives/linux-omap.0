From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v4 1/2] backlight: Add TPS65217 WLED driver
Date: Mon, 24 Sep 2012 23:58:05 +0200
Message-ID: <20120924215805.GH28670@sortiz-mobl>
References: <20120924202528.GE26600@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56638 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2IXV6M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 17:58:12 -0400
Content-Disposition: inline
In-Reply-To: <20120924202528.GE26600@darwin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, "Koen Kooi <koen@dominion.thruhere.net>, linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Matthias,

On Mon, Sep 24, 2012 at 10:25:28PM +0200, Matthias Kaehlcke wrote:
> The TPS65217 chip contains a boost converter and current sinks which can be
> used to drive LEDs for use as backlights. Expose this functionality via the
> backlight API.
> 
> Tested on an AM335x based custom board with a single WLED string, using
> different values for ISEL and FDIM (though it would be hard to tell the
> difference except for the value in WLEDCTRL1). Both instantiation through the
> device tree and by passing platform data have been tested. Testing has been
> done with an Androidized 3.2 kernel from the rowboat project. Koen Kooi
> reported the driver to be working on a Beaglebone board with LCD3 cape
> 
> This patch is based on the mfd branch (20120924)
> 
> Changes since v3:
> 
>  * split in two patches, one for the driver another for adding the mfd
>    subdevice
>  * renamed variable "on" to "is_enabled" and changed type to boolean
> 
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> ---
>  drivers/video/backlight/Kconfig       |    7 +
>  drivers/video/backlight/Makefile      |    1 +
>  drivers/video/backlight/tps65217_bl.c |  352 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65217.h          |   18 ++
>  4 files changed, 378 insertions(+)
>  create mode 100644 drivers/video/backlight/tps65217_bl.c
Applied as well, although it could go through Richard's tree. Having his
review would be nice anyway.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
