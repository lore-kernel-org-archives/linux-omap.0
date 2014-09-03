From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone*: Fix model name and update
 compatibility information
Date: Wed, 3 Sep 2014 14:45:59 -0700
Message-ID: <20140903214558.GN11766@atomide.com>
References: <1409760190-17275-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29166 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbaICVqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 17:46:06 -0400
Content-Disposition: inline
In-Reply-To: <1409760190-17275-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tom Rini <trini@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140903 09:03]:
> Beaglebone white and beaglebone black differ in tiny little aspects.
> This is the reason why we maintain seperate dts for these platforms.
> However, there is no real way to decode from dtb which platform it is
> since compatible and model name are the same for both platforms.
> 
> Fix this so that beaglebone black and beaglebone are identifiable,
> while maintaining compatibility for older zImages which might use old
> beaglebone compatible flag for black as well.
> 
> Reported-by: Tom Rini <trini@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks applying into omap-for-v3.18/fixes-not-urgent.

Regards,

Tony
