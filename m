From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH/RFT 0/2] fixes for broken PM init with multi-OMAP
Date: Wed, 10 Mar 2010 12:15:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F0F96@dbde02.ent.ti.com>
References: <1268154241-24788-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36113 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086Ab0CJGpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 01:45:32 -0500
In-Reply-To: <1268154241-24788-1-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Kevin,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> Hilman
> Sent: Tuesday, March 09, 2010 10:34 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH/RFT 0/2] fixes for broken PM init with multi-OMAP
> 
> multi-OMAP builds are broken in various ways due to conditional code.
> Here is a small series of fixes.
> 
> Build tested: omap3_defconfig, omap_4430sdp_defconfig
> Boot tested: omap3_defconfig on OMAP3EVM
> 
Applied this series on l-o master (dc73899a58be5e834b8df3a9049cdb1115acf175)
OMAP3430 SDP boots normal.

> Needs boot testing on OMAP4.
>
OMAP4 also boots with omap3_defconfig after unchecking the reset
unused clock check. This is known and will be fixed soon. 
 
> Applies on current l-o master branch.
> 
> Kevin Hilman (2):
>   OMAP2: cpu_is_omap2*: optimize out unused code.
>   OMAP4: fix temporary hacks that break multi-omap PM
> 
>  arch/arm/mach-omap2/io.c              |   13 ++++++-------
>  arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
