From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Wed, 19 Jun 2013 10:30:22 +0200
Message-ID: <20130619083022.GU7161@zurbaran>
References: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
 <20130619082633.GB22998@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62666 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549Ab3FSIaZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 04:30:25 -0400
Content-Disposition: inline
In-Reply-To: <20130619082633.GB22998@laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, ldewangan@nvidia.com, gg@slimlogic.co.uk

Hi Lee,

On Wed, Jun 19, 2013 at 09:26:33AM +0100, Lee Jones wrote:
> On Mon, 17 Jun 2013, J Keerthy wrote:
> 
> > Remove code which is not necessary for a device tree boot.
> 
> So we're exclusively DT now right?
> 
> > Boot tested on OMAP5-UEVM board.
> > 
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > ---
> >  drivers/mfd/palmas.c |  106 --------------------------------------------------
> >  1 files changed, 0 insertions(+), 106 deletions(-)
> 
> If that's the case, applied with all Acks, thanks.
It's already in mfd-next.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
