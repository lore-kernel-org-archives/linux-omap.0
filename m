From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD
 structure
Date: Mon, 21 Mar 2011 16:23:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3B8CA7@dbde02.ent.ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
 <1300493932-17362-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48406 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab1CUKyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 06:54:02 -0400
In-Reply-To: <1300493932-17362-3-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsely <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hilman, Kevin
> Sent: Saturday, March 19, 2011 5:49 AM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsely; Cousson, Benoit
> Subject: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets 
> into VDD structure
> 
> Eliminate need for global variables for the various PRM 
> module offsets by
> making them part of the VDD structure.
> 
> Eventually, these will likely be moved again, or more likely removed,
> but for now just getting rid of them as global variabes so that the
> voltage domain initialization can be cleaned up.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

[sp] This is almost what I intended to do in the clean-up patches
     posted earlier; but for few differences.

     Putting them here as well.

[snip...snip]

> diff --git a/arch/arm/mach-omap2/voltage.h 
> b/arch/arm/mach-omap2/voltage.h
> index e9f5408..44edc1e 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -133,6 +133,9 @@ struct omap_vdd_info {
>  	struct dentry *debug_dir;
>  	u32 curr_volt;
>  	bool vp_enabled;
> +
> +	s16 prm_mod;
> +	s16 prm_irqst_mod;

[sp] Can we match the type with the functions these are eventually
     passed to?

     Also, prm_mod is "comstant" for the silicon.

     Shouldn't it be a local static instead. Else, same value is
     repeated for each vdd.

~sanjeev

[snip...snip]
