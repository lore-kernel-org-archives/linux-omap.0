From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] AM35xx: Add clock support for new modules on
 AM35xx
Date: Fri, 5 Feb 2010 13:19:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002051317120.18110@utopia.booyaka.com>
References: <1264666832-18600-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42676 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab0BEUTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 15:19:09 -0500
In-Reply-To: <1264666832-18600-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 28 Jan 2010, Ranjith Lohithakshan wrote:

> This patch adds clock support for the following AM35xx modules
> 	- Ethernet MAC
> 	- CAN Controller (HECC)
> 	- New MUSB OTG Controller with integrated Phy
> 	- Video Processing Front End (VPFE)
> 	- Additional UART (UART4)
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Once you've verified the previous patch in this series, this patch will be 
queued for 2.6.34.


- Paul
