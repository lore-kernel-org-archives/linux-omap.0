From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection for OMAP4460
Date: Thu, 26 May 2011 14:03:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D177F64@dbde02.ent.ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
 <1306375016-707-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51361 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1EZIeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 04:34:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4Q8Xu49003464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:33:59 -0500
In-Reply-To: <1306375016-707-2-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "V, Aneesh" <aneesh@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, May 26, 2011 7:27 AM
> To: linux-omap
> Cc: V, Aneesh; Menon, Nishanth
> Subject: [RFC][PATCH 1/9] OMAP: ID: introduce chip detection 
> for OMAP4460
> 
> From: Aneesh V <aneesh@ti.com>
> 
> Add support for detecting the latest in the OMAP4 family: OMAP4460
> Among other changes, the new chip also can support 1.5GHz A9s,
> 1080p stereoscopic 3D and 12 MP stereo (dual camera). In addition,
> we have changes to OPPs supported, clock tree etc, hence having a
> chip detection is required.
> 
> Starting from OMAP4460 ES1.0, we are moving from HAWKEYE to 
> Ramp system
> for chip identification. Since the bit offsets are the same, 
> just rename
> the variable for dual use.
> 
> For more details on OMAP4460, see
> Highlights:
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?c
> ontentId=53243&navigationId=12843&templateId=6123
> Public TRM is available here as usual:
> http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?t
> emplateId=6123&navigationId=12667
> 
> [nm@ti.com: cleanups and introduction of ramp system]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   19 ++++++++++++++-----
>  arch/arm/plat-omap/include/plat/cpu.h |   12 ++++++++++++
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2537090..724be0a 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -331,7 +331,7 @@ static void __init omap3_check_revision(void)
>  static void __init omap4_check_revision(void)
>  {
>  	u32 idcode;
> -	u16 hawkeye;
> +	u16 hawkeye_ramp;

[sp] Why is this change required?

>  	u8 rev;
>  

~sanjeev

[snip]...[snip]
