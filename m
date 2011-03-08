From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: PM: Set static dependency between MPUSS and
 EMIF
Date: Tue, 8 Mar 2011 16:22:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081619500.15132@utopia.booyaka.com>
References: <1299596946-31334-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50218 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab1CHXWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:22:53 -0500
In-Reply-To: <1299596946-31334-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 8 Mar 2011, Santosh Shilimkar wrote:

> As per OMAP4430 TRM, the dynamic dependency between MEMIF and MPUSS
> clockdomains is enable by default. Refer register CM_MPU_DYNAMICDEP
> description for details.
> 
> But it doesn't seems to work as expected and MPUSS doesn't wakeup
> from off-mode if the static dependency is not set between MPUSS and
> EMIF clockdomains. i.e CM_MPU_STATICDEP.MEMIF_STATDEP = 0
> 
> The issue is under investigation with hardware team.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

Nice work!

Kevin, you want to take this one?

My only comment is that it might be nice to add a pr_info("OMAP4 
PM: Temporary static dependency added between EMIF and MPUSS");
in there to reduce the risk that the issue will be forgotten...

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
