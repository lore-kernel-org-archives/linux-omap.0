From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCHv5 0/4] iovmm: fixes for iovmm module
Date: Mon, 25 Oct 2010 13:49:04 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F4936A90@dlee06.ent.ti.com>
References: <1288032731-541-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288032731-541-1-git-send-email-x0095840@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>
Cc: "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



Please discard this set of patches I will send them again with
The correct prefix (omap) to avoid confusion with other
Iommu componets.

Sorry for the noise.

Regards,
Fernando.

> -----Original Message-----
> From: Guzman Lugo, Fernando 
> Sent: Monday, October 25, 2010 1:52 PM
> To: Hiroshi.DOYU@nokia.com
> Cc: felipe.contreras@nokia.com; tony@atomide.com; 
> linux-kernel@vger.kernel.org; andy.shevchenko@gmail.com; 
> linux-omap@vger.kernel.org; Guzman Lugo, Fernando
> Subject: [PATCHv5 0/4] iovmm: fixes for iovmm module
> 
> Version 5:
> * Changes in "iommu: create new api to set valid da range"
>   - Change range variables to platform data structure.
> 
> Version 4:
> * Changes in "iommu: create new api to set valid da range"
>   - Validate range for fixed address.
>   - Change way of change boundaries to avoid possible overflow
>     instead of style :
>        start + bytes >= end     which start + end can overflow
>     use style:
>        end - start < bytes
> 
> Version 3:
> * change patch 2 base on Felipe Contreras' comments,
>   now it uses min_t and I deleted some blank lines.
> * patch "create new api to set valid da range" is base on
>   "iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF"
>   patch and on Hiroshi's comments and now it is added to
>   this set.
> 
> Version 2:
> * Removed "iovmm: fixes for iovmm module" that patch was already
>   sent.
> * Modified "iovmm: fix roundup for next area and end check for the
>   last area" patch, base on Davin Cohen's comments and rename it
>   to a proper name that describes what it is doing now.
> 
> *** BLURB HERE ***
> 
> Fernando Guzman Lugo (4):
>   iovmm: no gap checking for fixed address
>   iovmm: add superpages support to fixed da address
>   iovmm: replace __iounmap with omap_iounmap
>   iommu: create new api to set valid da range
> 
>  arch/arm/plat-omap/include/plat/iommu.h |    3 +
>  arch/arm/plat-omap/iommu.c              |   33 ++++++++++++
>  arch/arm/plat-omap/iovmm.c              |   84 
> ++++++++++++++++++-------------
>  3 files changed, 85 insertions(+), 35 deletions(-)
> 
> 