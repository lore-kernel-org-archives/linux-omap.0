From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: beagle hangs in uart3 disabling clocks
Date: Sun, 3 Oct 2010 22:57:46 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0JCR1x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Oct 2010 13:27:53 -0400
In-Reply-To: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ming Lei
> Sent: Sunday, October 03, 2010 2:34 PM
> To: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: beagle hangs in uart3 disabling clocks
> 
> Hi,
> 
> I just tested pm branch of tony's linux-omap-2.6 tree, and found my
> beagle will hang in uart3 disabling clocks, follows the log info:
> 
> 
[snip]..[snip]

> 
> Texas Instruments X-Loader 1.41
> Starting OS Bootloader...
> 
> 
> U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)
> 
> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
> OMAP3 Beagle Board + LPDDR/NAND
> DRAM:  128 MB
> NAND:

Lei,

Couldn't help noticing the version information for x-loader and
u-boot. Both seem to be quite old...

Could you try update both? May be, there is a dependency...

~sanjeev

> 
> 
> -- 
> Lei Ming
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 