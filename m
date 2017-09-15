From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] dmaengine: edma: Align the memcpy acnt array size with
 the transfer
Date: Fri, 15 Sep 2017 09:47:07 -0700
Message-ID: <20170915164707.GD27343@kroah.com>
References: <20170915072328.7415-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915072328.7415-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 15, 2017 at 10:23:28AM +0300, Peter Ujfalusi wrote:
> ﻿Memory to Memory transfers does not have any special alignment needs
> regarding to acnt array size, but if one of the areas are in memory mapped
> regions (like PCIe memory), we need to make sure that the acnt array size
> is aligned with the mem copy parameters.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/edma.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
