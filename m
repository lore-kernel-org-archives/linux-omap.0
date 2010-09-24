From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 05/11] omap3: Remove non-existent config option
Date: Fri, 24 Sep 2010 20:47:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
 <AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab0IXPRU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:17:20 -0400
In-Reply-To: <AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Marathe, Yogesh" <yogesh_marathe@ti.com>

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
> Sent: Friday, September 24, 2010 3:31 PM
> To: Tony Lindgren
> Cc: linux-arm-kernel@lists.infradead.org; 
> linux-omap@vger.kernel.org; Premi, Sanjeev; Marathe, Yogesh
> Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
> 
> On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren 
> <tony@atomide.com> wrote:
> > From: Yogesh Marathe <yogesh_marathe@ti.com>
> >
> > The definition of "iva2" device in iommu_device
> > is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> > this option is not defined in KConfig.
> >
> > This patch removes the wrapper and makes "iva2"
> > available as another iommu_device.
> 
> NAK.
> 
> This would break tidspbridge's MMU. This was discussed before:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=58305
> 
> When tidspbridge has migrated to iommu, then it should define
> CONFIG_MPU_BRIDGE_IOMMU.

Felipe,

  Can you go through earlier discussion on this patch
  http://marc.info/?l=linux-omap&m=127979007623260&w=2

  I believe these concerns were discussed. I am unable to
  open the gmane thread (getting 504) - so can't be sure
  if Hiroshi had referred to same discussion.

~sanjeev
> 
> -- 
> Felipe Contreras
> 