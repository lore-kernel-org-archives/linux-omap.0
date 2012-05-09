From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: twl6040: Add regulator support for VIO, V2V1
 supplies
Date: Wed, 9 May 2012 22:02:06 +0200
Message-ID: <20120509200206.GA17206@sortiz-mobl>
References: <1335966882-19897-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24451 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2EITw2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 15:52:28 -0400
Content-Disposition: inline
In-Reply-To: <1335966882-19897-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Peter,

On Wed, May 02, 2012 at 04:54:42PM +0300, Peter Ujfalusi wrote:
> twl6040 has three power supply source:
> VBAT needs to be connected to VBAT, VIO, and V2V1.
> Add regulator support for the VIO, V2V1 supplies.
> Initially handle the two supply together with bulk commands.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/twl6040-core.c  |   33 +++++++++++++++++++++++++++++----
>  include/linux/mfd/twl6040.h |    2 ++
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> Hi Samuel,
> 
> The runtime dependencies for this patch has been sent to linux-omap list:
> http://marc.info/?l=linux-omap&m=133596645010228&w=2
> http://marc.info/?l=linux-omap&m=133596645610232&w=2
> http://marc.info/?l=linux-omap&m=133596644310224&w=2
> http://marc.info/?l=linux-omap&m=133596643310220&w=2
> 
> Alone this patch does not cause compile time regression but in runtime it needs
> the arch/arm/mach-omap2 patches.
> I try to avoid cross tree issues as much as I can and I'm happy if these will
> come together in linux-next (and finally in 3.5).
I applied this one to my nfc-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
