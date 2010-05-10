From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap iommu: renamed omap3-iommu to omap-iommu
Date: Mon, 10 May 2010 11:56:48 +0100
Message-ID: <20100510105648.GB14337@n2100.arm.linux.org.uk>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com> <p2z94a0d4531005100309v78f4fc0bw7f805f9dceffbcb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37844 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab0EJK5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 06:57:06 -0400
Content-Disposition: inline
In-Reply-To: <p2z94a0d4531005100309v78f4fc0bw7f805f9dceffbcb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 10, 2010 at 01:09:32PM +0300, Felipe Contreras wrote:
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 4b9fc57..7d2cf0f 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -89,10 +89,7 @@ obj-$(CONFIG_OMAP3_EMU)                      += emu.o
> >  obj-$(CONFIG_OMAP_MBOX_FWK)            += mailbox_mach.o
> >  mailbox_mach-objs                      := mailbox.o
> >
> > -iommu-y                                        += iommu2.o
> > -iommu-$(CONFIG_ARCH_OMAP3)             += omap3-iommu.o
> > -
> > -obj-$(CONFIG_OMAP_IOMMU)               += $(iommu-y)
> > +obj-$(CONFIG_OMAP_IOMMU)               := iommu2.o omap-iommu.o
> 
> Hiroshi, these objects have to be always built-in, but if
> CONFIG_OMAP_IOMMU=m, that would not be the case.

The above change is a no-op - which is good for this patch.  If it is
broken after with CONFIG_OMAP_IOMMU=m, then it was broken before the
patch.

If there was a problem here, it should be fixed by a separate patch
(and if it's broken in -rc, then such a patch needs to be sent upstream
as soon as it's validated.)
