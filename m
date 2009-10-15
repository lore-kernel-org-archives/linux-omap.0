From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Thu, 15 Oct 2009 17:27:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADBB@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF74A@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB9@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CDA1@dbde02.ent.ti.com>
 <200910151025.30493.peter.ujfalusi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CE36@dbde02.ent.ti.com>,<5A47E75E594F054BAF48C5E4FC4B92AB030A46D070@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40193 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499AbZJOL5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 07:57:51 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A46D070@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
Sent: Thursday, October 15, 2009 1:01 PM
To: Peter Ujfalusi
Cc: Varadarajan, Charu Latha; linux-omap@vger.kernel.org; Syed, Rafiuddin
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg access

Peter/ Santosh,
> > -----Original Message-----
> > From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> > Sent: Thursday, October 15, 2009 12:56 PM
> > To: Shilimkar, Santosh
> > Cc: Varadarajan, Charu Latha; linux-omap@vger.kernel.org; Syed, Rafiuddin
> > Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
> > access
> >
> > On Thursday 15 October 2009 09:10:54 ext Shilimkar, Santosh wrote:
> > > > > > > > -   writew(buf, base + OMAP_MCBSP_REG_DXR1);
> > > > > > > > +   OMAP_MCBSP_WRITE(base, DXR, buf);
> > > > > > >
> > > > > > > Why do you need this? Is writew()/readw() not doing 16 bit
> > > > > > > operations  ?
> > > > > >
> > > > > > The intension is to use 32 bit access and not 16 bit access
> > > > >
> > > > > Use readl() / writel() then.
> > > >
> > > > Yes,  OMAP_MCBSP_WRITE macro makes use of readl() / writel() for OMAP3
> > >
> > > Good!! Then get rid of this macro and directly use kernel standard
> > >  API-       readl() / writel() --
> >
> Well, OMAP1 and OMAP2 still has 16 bit registers in McBSP.
> Please look at this comment from Peter. So please reconsider your patch and decision of changing the signature of the API since it breaks OMAP1 and OMAP2.
OMAP_MCBSP_READ and  OMAP_MCBSP_WRITE macros takes care of the same. 
Please find below the code snippet from mcbsp kernel code. It checks for
the cpu version and accordingly calls raw_writew/raw_writel.
------------- Code snippet from arch/arm/plat-omap/mcbsp.c-------------------------------
void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
{
        if (cpu_class_is_omap1() || cpu_is_omap2420())
                __raw_writew((u16)val, io_base + reg);
        else
                __raw_writel(val, io_base + reg);
}

int omap_mcbsp_read(void __iomem *io_base, u16 reg)
{
        if (cpu_class_is_omap1() || cpu_is_omap2420())
                return __raw_readw(io_base + reg);
        else
                return __raw_readl(io_base + reg);
}

#define OMAP_MCBSP_READ(base, reg) \
                        omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
#define OMAP_MCBSP_WRITE(base, reg, val) \
                        omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
---------------- End of Code snippet from arch/arm/plat-omap/mcbsp.c-------------------------
-Charulatha