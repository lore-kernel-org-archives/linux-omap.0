From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: I2C: Fix omap_register_i2c_bus() return value on
 success
Date: Fri, 4 Nov 2011 17:19:38 -0700
Message-ID: <20111105001937.GL31337@atomide.com>
References: <1320234843-29115-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42810 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab1KEATj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:19:39 -0400
Content-Disposition: inline
In-Reply-To: <1320234843-29115-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [111102 04:19]:
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -165,7 +165,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
>  			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
>  	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
>  
> -	return PTR_ERR(od);
> +	return PTR_RET(od);
>  }
>  #else
>  static inline int omap2_i2c_add_bus(int bus_id)

Thanks applying into fixes after updating it to return pdev instead
of od as below.

Tony


From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 2 Nov 2011 12:54:03 +0100
Subject: [PATCH] ARM: OMAP: I2C: Fix omap_register_i2c_bus() return value on success

Commit 4d17aeb1c5b2375769446d13012a98e6d265ec13 ("OMAP: I2C: split
device registration and convert OMAP2+ to omap_device") makes
omap2_i2c_add_bus() return a pointer to an omap_device instead on
success instead of 0.

This breaks the omap_register_i2c_bus() ABI and results in the igep0020
board code detecting an I2C bus registration error when there is none.

Fix the problem by using PTR_RET() instead of PTR_ERR() in
omap2_i2c_add_bus().

Reported-by: Alexander Kinzer <a.kinzer@plusoptix.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[tony@atomide.com: updated to return pdev instead of od]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -184,7 +184,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 			NULL, 0, 0);
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
 
-	return PTR_ERR(pdev);
+	return PTR_RET(pdev);
 }
 #else
 static inline int omap2_i2c_add_bus(int bus_id)
