From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: NAND ECC in linux-omap
Date: Wed, 18 Aug 2010 09:44:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab0HREOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 00:14:24 -0400
In-Reply-To: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>



> -----Original Message-----
> From: Cliff Brake [mailto:cliff.brake@gmail.com]
> Sent: Wednesday, August 18, 2010 3:27 AM
> To: Linux OMAP Users; Ghorai, Sukumar
> Subject: NAND ECC in linux-omap
> 
> Hi,
> 
> I'm using the latest pm branch (based on linux-omap I think), and
> running into the following problems.
> 
> The first is my x-loader uses software ECC.  Looking in the omap nand
> driver, I made the following change which gets x-loader/u-boot working
> again:
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 133d515..1593c60 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -7,7 +7,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#define CONFIG_MTD_NAND_OMAP_HWECC
> +//#define CONFIG_MTD_NAND_OMAP_HWECC
> 
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> 
> But, I'm still getting a ton of ECC errors in JFFS2 flash filesystem.
> Does anyone have any suggestions as to where to go from here?  I see
> some patches on the mail lists from Sukumar Ghorai that make HW/SW ECC
> selectable from the board file.
> 
> Thanks,
> Cliff
> 
[Ghorai] 
1. Can you send the git tree link and branch you are referring?
2. I am working to support the NAND BCH and not upstream yet, how you apply this patch in PM branch. 
3. which x-loader and u-boot you are referring? And no x-loader/ u-boot supports the BCH 

> --
> =================
> http://bec-systems.com
