From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: Merging xloader, bootloader and boot environment variables
 partitions into a single partition on NAND
Date: Fri, 21 Jan 2011 11:44:38 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB07B@dbde02.ent.ti.com>
References: <4496F931-8AEF-44B1-B613-E1AE65D081B1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1AUGOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 01:14:47 -0500
In-Reply-To: <4496F931-8AEF-44B1-B613-E1AE65D081B1@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Thursday, January 20, 2011 10:51 PM
> To: linux-omap Mailing List
> Subject: Merging xloader, bootloader and boot environment variables
> partitions into a single partition on NAND
> 
> Hi,
>       I was wondering what the merits and demerits are of having a single
> integrated xloader+bootloader+boot environment variables in a single
> partition in NAND, as opposed to having multiple partitions that hold
> xloader, bootloader and the uboot environment in separate partitions?
[Ghorai] This the way we represent or arrange the nand/flash. 
Current design helps to update x-loader, u-boot, saveen or kernel in different partition(s) from user-space without remember the offset.

> 
> Elvis Dowson
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
