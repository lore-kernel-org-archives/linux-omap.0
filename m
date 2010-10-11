From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: tidspbridge compilation broken
Date: Mon, 11 Oct 2010 09:52:37 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2BA0@dlee06.ent.ti.com>
References: <1286621397.10205.25.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab0JKOwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 10:52:41 -0400
In-Reply-To: <1286621397.10205.25.camel@atlantis.mindbit.ro>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ionut Nicu
> Sent: Saturday, October 09, 2010 5:50 AM
> To: linux-omap@vger.kernel.org
> Subject: tidspbridge compilation broken
> 
> Hi,
> 
> I'm trying to compile the tidspbridge driver from the 
> dspbridge branch of the linux-omap git tree and I stumbled 
> upon a few compilation
> problems:
> 
> 1. First is related to the missing header plat/dsp.h added by 
> the following patch which was not applied to this branch:
> 
> http://marc.info/?l=linux-omap&m=128620861805925&w=2
> 
> 2. The second one is related to the missing header 
> plat/control.h which was moved by a recent commit (81bb9b6) 
> from plat to mach-omap2. The dspbridge driver requires a few 
> defines from that header but as far as I understand, that 
> header file is no longer supposed to be accessible by 
> drivers. Any suggestion on how to fix that in dspbridge?

This will be fixed soon, we are looking for the best solution.

Regards,
Fernando Guzman.

> 
> 3. There's a link error triggered by the new iommu 
> dependency. It's fairly trivial to fix. I will submit a patch 
> for this.
> 
> Thanks,
> Ionut.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 