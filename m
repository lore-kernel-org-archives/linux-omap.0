From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v2] mfd: Palmas: Remove code which is not necessary for
 a device tree boot
Date: Mon, 17 Jun 2013 15:50:23 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EC14A@DBDE04.ent.ti.com>
References: <1371469678-8464-1-git-send-email-j-keerthy@ti.com>
 <20130617131035.GM7998@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab3FQPum convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 11:50:42 -0400
In-Reply-To: <20130617131035.GM7998@zurbaran>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Samuel Ortiz
> Sent: Monday, June 17, 2013 6:41 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; ldewangan@nvidia.com;
> gg@slimlogic.co.uk
> Subject: Re: [PATCH v2] mfd: Palmas: Remove code which is not necessary
> for a device tree boot
> 
> Hi,
> 
> On Mon, Jun 17, 2013 at 05:17:58PM +0530, J Keerthy wrote:
> > Remove code which is not necessary for a device tree boot.
> >
> > Boot tested on OMAP5-UEVM board.
> >
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > Acked-by: Laxman Dewangan  <ldewangan@nvidia.com>
> > Acked-by: Graeme Gregory <gg@slimlogic.co.uk>
> > ---
> >  drivers/mfd/palmas.c |  106
> > --------------------------------------------------
> >  1 files changed, 0 insertions(+), 106 deletions(-)
> Applied to mfd-next, thanks.

Thanks Samuel!

> 
> Cheers,
> Samuel.
> 
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
