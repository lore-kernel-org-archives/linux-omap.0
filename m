From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Mon, 17 Jun 2013 15:10:35 +0200
Message-ID: <20130617131035.GM7998@zurbaran>
References: <1371469678-8464-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34460 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab3FQNKj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 09:10:39 -0400
Content-Disposition: inline
In-Reply-To: <1371469678-8464-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, ldewangan@nvidia.com, gg@slimlogic.co.uk

Hi,

On Mon, Jun 17, 2013 at 05:17:58PM +0530, J Keerthy wrote:
> Remove code which is not necessary for a device tree boot.
> 
> Boot tested on OMAP5-UEVM board.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Acked-by: Laxman Dewangan  <ldewangan@nvidia.com>
> Acked-by: Graeme Gregory <gg@slimlogic.co.uk>
> ---
>  drivers/mfd/palmas.c |  106 --------------------------------------------------
>  1 files changed, 0 insertions(+), 106 deletions(-)
Applied to mfd-next, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
