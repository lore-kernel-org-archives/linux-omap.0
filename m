From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: OMAP2+: hwmod: Add a new flag to handle hwmods
 left enabled at init
Date: Fri, 16 Dec 2011 10:16:26 -0800
Message-ID: <20111216181626.GC32251@atomide.com>
References: <alpine.DEB.2.00.1112160544470.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28619 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760178Ab1LPSQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 13:16:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160544470.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, rnayak@ti.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

* Paul Walmsley <paul@pwsan.com> [111216 04:18]:
> 
> From: Rajendra Nayak <rnayak@ti.com>
> 
> An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hwmod framework throws a WARN() about
> the device being already in enabled state.
> 
> Fix this by introducing a new internal flag '_HWMOD_SKIP_ENABLE' to
> identify such devices/hwmods. When the device/hwmod is requested to be
> enabled (the first time) by its driver/user, nothing except the
> mux-enable is needed. The mux data is board specific and is
> unavailable during initial enable() of the device, done by the
> framework as part of setup().
> 
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: use a flag rather than a state; updated commit message;
>  edited some documentation]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Thanks I'll apply this into uart branch so I can pull Kevin's
changes on top of it.

Regards,

Tony
