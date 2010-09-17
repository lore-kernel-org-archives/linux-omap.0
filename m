From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED
	instead of MT_DEVICE
Date: Fri, 17 Sep 2010 15:48:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C81@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <20100917101602.GC27467@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56078 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab0IQKSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:18:36 -0400
In-Reply-To: <20100917101602.GC27467@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, September 17, 2010 3:46 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED
> instead of MT_DEVICE
> 
> On Fri, Sep 17, 2010 at 03:17:47PM +0530, Santosh Shilimkar wrote:
> > On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> > mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
> >
> > Since the section mapping limitation gets fixed with first
> > patch in this series, the MT_MEMORY_NONCACHED can be used now.
> >
> > Have not tested this, so somebody with Davinci hardware can
> > try this out
> 
> Is this still true?
No it's not anymore.. 
It's already tested on Davinci by Kevin. I missed to remove that
>From commit log.
