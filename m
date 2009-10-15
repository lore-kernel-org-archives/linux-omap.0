From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Thu, 15 Oct 2009 13:00:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CE36@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF74A@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB9@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CDA1@dbde02.ent.ti.com>
 <200910151025.30493.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766AbZJOHbc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 03:31:32 -0400
In-Reply-To: <200910151025.30493.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Varadarajan, Charu Latha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

Charu,
> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Thursday, October 15, 2009 12:56 PM
> To: Shilimkar, Santosh
> Cc: Varadarajan, Charu Latha; linux-omap@vger.kernel.org; Syed, Rafiuddin
> Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
> access
> 
> On Thursday 15 October 2009 09:10:54 ext Shilimkar, Santosh wrote:
> > > > > > > -   writew(buf, base + OMAP_MCBSP_REG_DXR1);
> > > > > > > +   OMAP_MCBSP_WRITE(base, DXR, buf);
> > > > > >
> > > > > > Why do you need this? Is writew()/readw() not doing 16 bit
> > > > > > operations  ?
> > > > >
> > > > > The intension is to use 32 bit access and not 16 bit access
> > > >
> > > > Use readl() / writel() then.
> > >
> > > Yes,  OMAP_MCBSP_WRITE macro makes use of readl() / writel() for OMAP3
> >
> > Good!! Then get rid of this macro and directly use kernel standard
> >  API-	readl() / writel() --
> 
> Well, OMAP1 and OMAP2 still has 16 bit registers in McBSP.
Please look at this comment from Peter. So please reconsider your patch and decision of changing the signature of the API since it breaks OMAP1 and OMAP2.

Regards,
Santosh
