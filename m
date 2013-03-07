From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/4] USB: OMAP: Tahvo USB transceiver driver
Date: Thu, 7 Mar 2013 08:20:35 -0800
Message-ID: <20130307162034.GX11806@atomide.com>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-5-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17862 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759164Ab3CGRSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 12:18:22 -0500
Content-Disposition: inline
In-Reply-To: <1362667221-30659-5-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

* Aaro Koskinen <aaro.koskinen@iki.fi> [130307 06:44]:
> +#include <mach/usb.h>

We should be getting rid of the plat and mach includes for
drivers for omap1 also, so let's not make it harder by adding
more of it. We should have just the following:

include/linux/platform_data/usb-omap.h	this contains just minimal pdata
include/linux/usb/something.h		if needed and cannot be local to driver

Regards,

Tony
