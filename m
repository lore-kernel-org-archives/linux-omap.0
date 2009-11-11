From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] AM35xx: Clock table updates for AM3505/17
Date: Wed, 11 Nov 2009 13:43:04 -0800
Message-ID: <87iqdg20wn.fsf@deeprootsystems.com>
References: <1257417540-21120-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53250 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbZKKVnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 16:43:03 -0500
Received: by pwi3 with SMTP id 3so938776pwi.21
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 13:43:07 -0800 (PST)
In-Reply-To: <1257417540-21120-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Thu\,  5 Nov 2009 16\:09\:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> AM3505/17 though a OMAP3530 derivative have the following
> main differences
>
> 	- Removal of the following OMAP3 modules
> 		- IVA
> 		- ISP/CAM
> 		- Modem and D2D components (MAD2D, SAD2D)
> 		- USIM
> 		- SSI
> 		- Mailboxes
> 		- USB OTG
> 		- ICR
> 		- MSPRO
> 		- SmartReflex
> 	- SDRC replaced with EMIF4 Controller in the SDRC subsystem
> 	  thus adding support for DDR2 memory devices
> 	- Addition of the following new modules
> 		- Ethernet MAC (CPGMAC)
> 		- CAN Controller (HECC)
> 		- New USB OTG Controller with integrated Phy
> 		- Video Processing Front End (VPFE)
> 		- Additional UART (UART4)
> 	- All security accelerators disabled on GP devices and not to
> 	  be accessed or configured
>
> This patch defines CPU flags for AM3505/17 and update the clock table.
> Clock support for new modules will be added by subsequent patches.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

A question on the approach here, as I'm wondering if this approach is
really needed.

Rather than handling these details in the clock tree, why not handle
the special cases using the feature checks: omap_has_*().  

Kevin

