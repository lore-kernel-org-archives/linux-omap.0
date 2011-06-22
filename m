From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the default behavior
 of LDO's
Date: Wed, 22 Jun 2011 16:48:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D626714@dbde02.ent.ti.com>
References: <1308702281-12665-1-git-send-email-girishsg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41472 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1FVLSO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 07:18:14 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MBIADK030111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 06:18:13 -0500
In-Reply-To: <1308702281-12665-1-git-send-email-girishsg@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Ghongdemath, Girish
> Sent: Wednesday, June 22, 2011 5:55 AM
> To: linux-omap
> Cc: Ghongdemath, Girish
> Subject: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the 
> default behavior of LDO's
> 
> TWL6030 below table shows the default state each LDO's can
> be put into.
> 

[sp] Can you point to the relevant document instead of drawing
     the full table here?

> 	
> +---------------------------------------------------------------+
> 	| LDO 	|	Usage		|	state		
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VANA 	| sources internal	| Always ON		
> 	|
> 	|	| analog voltage	|			
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VAUX1	| eMMC			| MMC Driver needs to 
> handle	|
> 	|	|			|  			
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VAUX2	| A/V switch		| Driver needs to 
> handle	|
> 	
> +---------------------------------------------------------------+
> 	| VAUX3 | 5MP CAMp		| Driver needs to 
> handle	|
> 	
> +---------------------------------------------------------------+
> 	| VCXIO	| supplies DPLL's	| Can be put OFF when 
> OMAP hits	|
> 	|	|			| OFF mode.		
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VDAC	| HDMI, CDC chip	| Always ON		
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VMMC	| MMC			| Driver needs to 
> handle	|
> 	
> +---------------------------------------------------------------+
> 	| VPP	| VPP pins of OMAP	| Used while burning 
> fuses in 	|
> 	|	|			| OMAP. This can be 
> turned OFF 	|
> 	|	|			| by default when 
> kernel comes 	|
> 	|	|			| up.			
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VRTC	| VBRTC/RTC		| Always ON		
> 	|
> 	
> +---------------------------------------------------------------+
> 	| VUSB	| USB OTG pins		| Driver needs to 
> handle	|
> 	
> +---------------------------------------------------------------+
> 	| VUSIM	| VDDS_SIM, SIM cage	| Driver needs to 
> handle.	|
> 	
> +---------------------------------------------------------------+
> 	| CLK32K| 32KHz o/p clk		| WIFI/BT/FM/GPS driver 
> needs	|
> 	|	|			| to handle		
> 	|
> 	
> +---------------------------------------------------------------+
> 

[snip]...[snip]

~sanjeev
