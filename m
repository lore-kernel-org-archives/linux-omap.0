From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Booting 3.9.0-rc2 on Beaglebone ?
Date: Wed, 20 Mar 2013 08:35:38 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC2A7D1@DBDE01.ent.ti.com>
References: <513F9394.6010306@mimc.co.uk>
 <20130319183347.GF16413@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49431 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3CTIfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 04:35:44 -0400
In-Reply-To: <20130319183347.GF16413@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, March 20, 2013 12:04 AM
> To: Mark Jackson
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Booting 3.9.0-rc2 on Beaglebone ?
> 
> Hi,
> 
> * Mark Jackson <mpfj-list@mimc.co.uk> [130312 13:48]:
> > I'm struggling to get the latest kernel git to load on my beaglebone.
> >
> > Error: unrecognized/unsupported machine ID (r1 = 0x00000e05).
> >
> > I guess I'm missing some vital step ?
> 
> We're changing the mainline kernel tree to use device tree
> based booting only.
> 
> So you need to either upgrade your bootloader to support device
> tree based booting, or enable CONFIG_ARM_APPENDED_DTB and
> ARM_ATAG_DTB_COMPAT in your .config and build u-image manually
> with the .dtb appended to the zImage. Doing make dtbs will generate
> you the am335x-bone.dtb to append.
> 

This might help you - 
https://github.com/hvaibhav/am335x-linux/wiki/How-To-Use-Upstream-Tree

Thanks,
Vaibhav
