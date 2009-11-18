From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] FIX OMAP3:McBSP poll read and write for OMAP3
Date: Wed, 18 Nov 2009 09:52:43 -0800
Message-ID: <20091118175243.GM29266@atomide.com>
References: <20091112211111.GE24837@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BBB94B71@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60928 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbZKRRwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 12:52:40 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BBB94B71@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

* Varadarajan, Charu Latha <charu@ti.com> [091118 00:58]:
>  
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com] 
> >Sent: Friday, November 13, 2009 2:41 AM
> >To: Varadarajan, Charu Latha
> >Cc: linux-omap@vger.kernel.org; Syed, Rafiuddin
> >Subject: Re: [PATCH V2] FIX OMAP3:McBSP poll read and write for OMAP3
> >
> >* charu@ti.com <charu@ti.com> [091019 23:41]:
> >> omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
> >> McBSP registers as 16-bit registers.
> >> 
> >> In OMAP3, McBSP registers (DRR_REG and DXR_REG) are limited to
> >> 32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
> >> not allowed and can corrupt register content.
> >> 
> >> This patch adds omap3_mcbsp_pollwrite and
> >> omap3_mcbsp_pollread functions for OMAP3 cpu, inorder to
> >> perform 32 bit access of above mentioned McBSP registers.
> >
> >How about making the functions generic, I don't think we want
> >to have separate omap1_mcbsp_pollread, omap2_mcbsp_pollread,
> >omap3_mcbsp_pollread..
> >
> >If it's not obvious how to implement it for some omap, just
> >return an error based on the CPU type.
> 
> 
> My v1 patch handles this in a single generic API. 
> [http://www.spinics.net/lists/linux-omap/msg19074.html and
> http://patchwork.kernel.org/patch/53631/]

Well first of all we don't have any references to this function
in our tree. Second, we have:

#define OMAP_MCBSP_REG_DRR2	0x00
#define OMAP_MCBSP_REG_DRR1	0x02
#define OMAP_MCBSP_REG_DXR2	0x04
#define OMAP_MCBSP_REG_DXR1	0x06

Meaning that both DRR and DXR are 32-bits in length. And based
on that it seems that at least omap_mcbsp_pollwrite is broken
if it supports only one 16-bit write instead of 16 + 16 bits
that the hardware seems to support.

> As per the review comments received for v1 patch, v2 patch is 
> modified to have new API "omap3_mcbsp_pollread/write" in 
> addition to "omap_mcbsp_pollread/write" APIs. 

That does not make much sense based on the fact that the
hardware has 32-bits for DRR and DXR. 
 
> Review comments for V1 mentioned that API signartures should not be 
> changed from 16bit to 32 bit input parameters. 
> If the API needs to be made generic, API signature has to be 
> modified as given below (as in patch v1):
> -int omap_mcbsp_pollread(unsigned int id, u16 *buf)
> +int omap_mcbsp_pollread(unsigned int id, u32 *buf)
> 
> If agreed for this generic API change, I shall post v3 patch
> which would handle cputypes dynamically inside the API

To me it smells like the all drivers using the the
omap_mcbsp_pollread/write are broken legacy drivers.
So maybe we should just remove these two functions?

If we really want to keep these around, we should review
the drivers using these functions. And if we end up keeping
these functions around, I like the first patch better, except
it does not seem to support DRR2 and DXR2 on older hardware,
so that's broken too.

IMHO, we should rather set up this driver as a proper
bus driver as suggested by Paul in a related thread.

Regards,

Tony
