From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: dts: omap3-igep0020: use SMSC9221 timings
Date: Fri, 25 Apr 2014 09:30:33 -0700
Message-ID: <20140425163033.GC20807@atomide.com>
References: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65435 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbaDYQai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2014 12:30:38 -0400
Content-Disposition: inline
In-Reply-To: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140424 09:54]:
> The IGEPv2 board has a SMSC LAN9221i ethernet chip and not a
> SMSC LAN911x connected to the GPMC. Each chip needs different
> timings in order to operate correctly so is wrong to include
> omap-gpmc-smsc911x.dtsi instead of omap-gpmc-smsc9221.dtsi.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Hi Tony,
> 
> I see no performance difference when measuring network throughput using
> iperf(1) but this change is the correct one nonetheless since if we later
> better adjust the timings it will already include the right dtsi.

Yes, let's fix this as wrong timings can cause memory corruption.
Applying into omap-for-v3.15/fixes-v2.

Tony
