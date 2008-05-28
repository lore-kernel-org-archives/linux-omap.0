From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.26rc4 build error
Date: Wed, 28 May 2008 08:43:51 -0700
Message-ID: <20080528154351.GX8845@atomide.com>
References: <9EEF473D-AA5F-49C0-875E-2D2676DCDC7C@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53294 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYE1Pnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 11:43:55 -0400
Content-Disposition: inline
In-Reply-To: <9EEF473D-AA5F-49C0-875E-2D2676DCDC7C@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

Hi,

* Koen Kooi <k.kooi@student.utwente.nl> [080528 08:06]:
> Hi,
> 
> I tried building git HEAD today to get some 2.6.26rc4 goodness, but  
> stumpled upon:
> 
>    CC      arch/arm/mach-omap2/mcbsp.o
> arch/arm/mach-omap2/mcbsp.c:78: error: implicit declaration of  
> function 'IO_ADDRESS'
> arch/arm/mach-omap2/mcbsp.c:78: error: initializer element is not  
> constant
> arch/arm/mach-omap2/mcbsp.c:78: error: (near initialization for  
> 'omap2_mcbsp_pdata[0].virt_base')
> arch/arm/mach-omap2/mcbsp.c:87: error: initializer element is not  
> constant
> arch/arm/mach-omap2/mcbsp.c:87: error: (near initialization for  
> 'omap2_mcbsp_pdata[1].virt_base')
> 
> I suspect that's caused by Eduardos "MCBSP: Tranform into platform  
> driver" patches and 0001-ASoC-OMAP-Add-basic-support-for-OMAP34xx-in- 
> McBSP.patch
> 
> Does anyone have updated patches for those?

Sounds like you need to #include <linux/io.h> from mcbsp.c.

Based on the fact that it's at mach-omap2/mcbsp.o, I guess you're
trying out the unmerged mcbsp patches?

Tony
