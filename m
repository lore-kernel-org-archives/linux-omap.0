From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
Date: Tue, 14 Dec 2010 18:12:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141811380.15971@utopia.booyaka.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com> <4D05D586.6090408@ti.com> <AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com> <alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43940 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0LOBM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:12:27 -0500
In-Reply-To: <alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Omar

On Tue, 14 Dec 2010, Paul Walmsley wrote:

> - In your driver-to-core-OMAP integration code in arch/arm/*omap*, call 
> omap_hwmod_get_mpu_rt_va(), and pass that to the driver via an entry in 
> the struct platform_data.

One brief note here - this should have been more clear:

- In your driver-to-core-OMAP integration code in arch/arm/*omap*, call 
  omap_hwmod_get_mpu_rt_va(), and pass the virtual address that it returns 
  to the driver via an entry in the struct platform_data.


- Paul
