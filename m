From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv5] omap3: Add basic support for 720MHz part
Date: Thu, 3 Feb 2011 17:00:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024880B133@dbde02.ent.ti.com>
References: <1296126687-1846-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48528 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284Ab1BCLaT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 06:30:19 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p13BUFko004063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Feb 2011 05:30:17 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p13BUFYD029536
	for <linux-omap@vger.kernel.org>; Thu, 3 Feb 2011 17:00:15 +0530 (IST)
In-Reply-To: <1296126687-1846-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Thursday, January 27, 2011 4:41 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv5] omap3: Add basic support for 720MHz part
> 
> This patch adds support for speed enhanced variant of OMAP35x
> processors. These parts allow ARM and IVA running at 720MHz
> and 520MHz respectively.
> 
> These parts can be detected at runtime by reading contents of
> PRODID.SKUID[3:0] at 0x4830A20C [1].
> 
> This patch specifically does following:
>  * Add new OPP to omap34xx_opp_def_list[] - disabled by default.
>  * Detect devices capable of running at new OPP.
>  * Enable new OPP only if device supports it.
>  * Check for presence of IVA before attempting to enable the
>    corresponding OPP.
> 
>   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
> 
> It appears from discussions (on this patch) that a variant of
> OMAP3430 supports this OPP but lacks runtime detection. This
> OPP can be enabled for these device by either:
>  1) Setting the bit corresponding to OMAP3_HAS_720MHZ
>     in 'omap3_features'. (Refer changes to id.c)
>  2) Removing check for omap3_has_720mhz() before enabling
>     the OPP. (Refer changes to opp3xxx_data.c)
>  3) Calling opp_enable() for 720MHz/VDD1 and 520MHz/VDD2 in
>     the board file. (Refer changes to opp3xxx_data.c).
>     This should, ideally, be done before omap3_opp_init() is
>     called during device_initcall().
> 
> CAUTION: This should be done for identified parts only.
>          Else, the device could be damaged permanently.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Reviewed-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> 
> Since v4:
>   Updated the commit text addressing comments from
>   Kevin Hilman (khilman@ti.com).
> 

Kevin,

Wanted to check if the decription addresses your comments.

~sanjeev

[snip]...[snip]
