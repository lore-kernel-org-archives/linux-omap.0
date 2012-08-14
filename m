From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Tue, 14 Aug 2012 04:22:31 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA11EE3@DBDE01.ent.ti.com>
References: <1344870365-11645-1-git-send-email-anilkumar@ti.com>
 <20120813152354.GB5745@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58080 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab2HNEWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 00:22:49 -0400
In-Reply-To: <20120813152354.GB5745@kroah.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Greg,

On Mon, Aug 13, 2012 at 20:53:54, Greg KH wrote:
> On Mon, Aug 13, 2012 at 08:36:05PM +0530, AnilKumar Ch wrote:
> > Regulator platform data handling was mistakenly added to MFD
> > driver. So we will see build errors if we compile MFD drivers
> > without CONFIG_REGULATOR. This patch moves regulator platform
> > data handling from TPS65217 MFD driver to regulator driver.
> > 
> > This makes MFD driver independent of REGULATOR framework so
> > build error is fixed if CONFIG_REGULATOR is not set.
> > 
> > drivers/built-in.o: In function `tps65217_probe':
> > tps65217.c:(.devinit.text+0x13e37): undefined reference
> > to `of_regulator_match'
> > 
> > This patch also fix allocation size of tps65217 platform data.
> > Current implementation allocates a struct tps65217_board for each
> > regulator specified in the device tree. But the structure itself
> > provides array of regulators so one instance of it is sufficient.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > This patch is tested on BeagleBone with regulator device node
> > additions. And this is based on mfd/master.
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 

My bad, I will take care from next time onwards.

Thanks
AnilKumar 
