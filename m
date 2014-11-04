From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: gpmc: Error out if timings fail in
 gpmc_probe_generic_child()
Date: Mon, 3 Nov 2014 17:14:17 -0800
Message-ID: <20141104011417.GN31454@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
 <1413895309-9152-3-git-send-email-rogerq@ti.com>
 <20141104004530.GM31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54502 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365AbaKDBPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2014 20:15:22 -0500
Content-Disposition: inline
In-Reply-To: <20141104004530.GM31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

* Tony Lindgren <tony@atomide.com> [141103 16:48]:
> --- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> +++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> +		gpmc,device-width = <1>;
> +		gpmc,burst-length = <4>;

I've left out the gpmc,burst-length as that produces now
warnings about not being used and does not seem to work if
enabled.

> --- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
> +++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
> +		gpmc,device-width = <1>;
> +		gpmc,burst-length = <4>;

And here too.

Regards,

Tony
