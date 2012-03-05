From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] ARM: OMAP: fix iommu, not mailbox
Date: Mon, 5 Mar 2012 15:39:58 +0100
Message-ID: <20120305143957.GK10684@amd.com>
References: <1330855271-28820-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:6368 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964867Ab2CEOkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 09:40:11 -0500
Content-Disposition: inline
In-Reply-To: <1330855271-28820-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>

On Sun, Mar 04, 2012 at 12:01:11PM +0200, Ohad Ben-Cohen wrote:
> For some weird (freudian?) reason, commit 435792d "ARM: OMAP: make
> iommu subsys_initcall to fix builtin omap3isp" unintentionally changed
> the mailbox's initcall instead of the iommu's.
> 
> Fix that.

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

