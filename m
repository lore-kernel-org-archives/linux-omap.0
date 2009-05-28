From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: linux-next: manual merge of the omap tree with the arm tree
Date: Thu, 28 May 2009 11:55:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE3927@dbde02.ent.ti.com>
References: <20090528143138.2de9ad37.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58146 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbZE1GZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 02:25:35 -0400
In-Reply-To: <20090528143138.2de9ad37.sfr@canb.auug.org.au>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>


> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au] 
> Sent: Thursday, May 28, 2009 10:02 AM
> To: Tony Lindgren; linux-omap@vger.kernel.org
> Cc: linux-next@vger.kernel.org; linux-kernel@vger.kernel.org; 
> Russell King; Shilimkar, Santosh
> Subject: linux-next: manual merge of the omap tree with the arm tree
> 
> Hi all,
> 
> Today's linux-next merge of the omap tree got a conflict in
> arch/arm/Makefile between commit 
> b4175b89921fefb2f352472fa6dccb0fc4fb37d9
> ("[ARM] sort machine- and plat- by CONFIG* name") from the 
> arm tree and
> commit 68394eae0fc4e801fc2ae33055b24a9754669a7b ("ARM: OMAP4: 
> Add support
> for 4430 SDP") from the omap tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --cc arch/arm/Makefile
> index e97c21b,676d10d..0000000
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@@ -99,72 -99,65 +99,73 @@@ CHECKFLAGS	+= -D__arm_
>   #Default value
>   head-y		:= arch/arm/kernel/head$(MMUEXT).o 
> arch/arm/kernel/init_task.o
>   textofs-y	:= 0x00008000
 - machine-$(CONFIG_ARCH_W90X900)    := w90x900
>  +
>  +# Machine directory name.  This list is sorted alphanumerically
>  +# by CONFIG_* macro name.
>  +machine-$(CONFIG_ARCH_AAEC2000)		:= aaec2000
>  +machine-$(CONFIG_ARCH_AT91)		:= at91
>  +machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
>  +machine-$(CONFIG_ARCH_DAVINCI)		:= davinci
>  +machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
>  +machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
>  +machine-$(CONFIG_ARCH_GEMINI)		:= gemini
>  +machine-$(CONFIG_ARCH_H720X)		:= h720x
>  +machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
>  +machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
>  +machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
>  +machine-$(CONFIG_ARCH_IOP33X)		:= iop33x
>  +machine-$(CONFIG_ARCH_IXP2000)		:= ixp2000
>  +machine-$(CONFIG_ARCH_IXP23XX)		:= ixp23xx
>  +machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
>  +machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
>  +machine-$(CONFIG_ARCH_KS8695)		:= ks8695
>  +machine-$(CONFIG_ARCH_L7200)		:= l7200
>  +machine-$(CONFIG_ARCH_LH7A40X)		:= lh7a40x
>  +machine-$(CONFIG_ARCH_LOKI) 		:= loki
>  +machine-$(CONFIG_ARCH_MMP)		:= mmp
>  +machine-$(CONFIG_ARCH_MSM)		:= msm
>  +machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
>  +machine-$(CONFIG_ARCH_MX1)		:= mx1
>  +machine-$(CONFIG_ARCH_MX2)		:= mx2
>  +machine-$(CONFIG_ARCH_MX3)		:= mx3
>  +machine-$(CONFIG_ARCH_NETX)		:= netx
>  +machine-$(CONFIG_ARCH_NS9XXX)		:= ns9xxx
>  +machine-$(CONFIG_ARCH_OMAP1)		:= omap1
>  +machine-$(CONFIG_ARCH_OMAP2)		:= omap2
>  +machine-$(CONFIG_ARCH_OMAP3)		:= omap2
> ++machine-$(CONFIG_ARCH_OMAP4)		:= omap2

++ Is this really ok ?

>  +machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
>  +machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
>  +machine-$(CONFIG_ARCH_PXA)		:= pxa

