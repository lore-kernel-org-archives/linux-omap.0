From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH v9 00/13] usb: musb: adding multi instance support
Date: Tue, 11 Sep 2012 10:45:44 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9FCB6C@DBDE01.ent.ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <20120911091731.GA18907@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49964 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317Ab2IKKp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 06:45:57 -0400
In-Reply-To: <20120911091731.GA18907@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

> 
> Hi,
> 
> On Fri, Aug 31, 2012 at 04:39:46PM +0530, Ravi Babu wrote:
> > This series of patches adds,
> > a) Multi instances support in musb driver
> > b) DT support for musb_dsps glue layer
> > c) DT support for NOP transceiver
> > 
> > AM33xx and TI81xx has dual musb controller and has two usb 
> PHY of same type.
> > This patch series uses 'phandle' based API 
> > devm_usb_get_phy_by_phandle() to get the PHY of same type. This API 
> > support is being added by Kishon's patch discussed at [1]
> > 
> > The series applies to felipe/master [1] branch
> > 	+ Vaibhav baseport patches on his tree at [4]
> > 	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
> > 	+ Kishon's patch on phandle at [2]
> > 	+ Damodar's recent patch at [3] 
> > 	+ Ajay's & Damodar's patches at [5] and [6] included in 
> this series
> > 
> > 1. http://git.kernel.org/?p=linux/kernel/git/balbi/usb.git;a=summary
> > 2. http://marc.info/?l=linux-usb&m=134070369306112&w=2
> > 3. http://marc.info/?l=linux-usb&m=134200284230689&w=2
> > 4. 
> > 
> https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-stagi
> > ng 5. http://marc.info/?l=linux-usb&m=134200285530701&w=2
> > 6. http://marc.info/?l=linux-usb&m=134208820028625&w=2
> > 
> > Changes from v8:
> > 	- included Sergei's comment, removing underscore in 
> device tree file
> > 	- removed duplicated signoff from patches Changes from v7:
> > 	- patches rebased on felipe/master branch & verified
> > 	- included additional two patches 0001 & 0002 as part 
> of this series
> > 	  which are already submitted [5] & [6] Changes from v6:
> > 	- Removed parent_pdev to get glue and used 
> dev_get_getdrv() as per
> > 	  Felipe's comment
> > 	- use pr_debug() instead of pr_info() as per Felipe's 
> comment Changes 
> > from v5:
> > 	- Removed musb->id as per Felipe's comment
> > 	- used nop_ida as per Felipe's comment Changes from v4:
> > 	- Fixed Felipe's comment for adding EXPORT_SYMBOL_GPL()
> > 	- Fixed Felipe's comment on using dev_set_mask() 
> Changes from v3:
> > 	- Fixed Kishon's comment on removing "id" from phy struct and
> > 	  removing unneeded "#else" part.
> > Changes from v2:
> > 	- Fixed Sergei's comment on not using address prefix in 
> musb_dsps
> > 	  glue and nop transceiver dt dats.
> > 	- Also removed the "ti" string in compatible property 
> for nop data.
> > Changes from v1:
> > 	- Defined musb_ida to manage core ids based on Felipe's comment
> > 	  in [PATCH 01/11]
> 
> I tried appliying this, but this doesn't apply. Please rebase 
> on my musb branch. Unfortunately there's no time anymore to 
> wait otherwise the entire musb branch will miss this merge window.
> 
> I'm sorry

Felipe, patch set is ready, I will re-send the patches shortly by today.

> 
> --
> balbi
> 