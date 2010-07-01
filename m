From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Enable lm75 and hwmon in OMAP4
Date: Thu, 1 Jul 2010 15:27:22 +0300
Message-ID: <20100701122722.GO2822@atomide.com>
References: <0680EC522D0CC943BC586913CF3768C003B34A6712@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53315 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0GAM1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:27:12 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B34A6712@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Datta, Shubhrajyoti <shubhrajyoti@ti.com> [100617 09:14]:
> Enabling hwmon and lm75 in the omap4 defconfig
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/configs/omap_4430sdp_defconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 arch/arm/configs/omap_4430sdp_defconfig

Again a bad mode change for a while.

Sorry no more defconfig patches until the situation clears out
on what they will be replaced with.

Tony
