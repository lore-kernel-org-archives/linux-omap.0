From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH] Board changes for tmp105 temperature sensor
Date: Thu, 1 Jul 2010 15:17:12 +0300
Message-ID: <20100701121711.GM2822@atomide.com>
References: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54897 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab0GAMRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:17:03 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

* Datta, Shubhrajyoti <shubhrajyoti@ti.com> [100615 17:40]:
> Adding board configuration for the tmp105
> temperature sensor. The interface to the sensor
> is I2C.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/board-4430sdp.c

Please be careful with the mode changes.

Tony
