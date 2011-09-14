From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP3505 revisions?
Date: Wed, 14 Sep 2011 16:59:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A0074@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756456Ab1INL3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 07:29:43 -0400
In-Reply-To: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "notasas@gmail.com" <notasas@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Tuesday, September 13, 2011 11:33 PM
> To: Premi, Sanjeev
> Cc: notasas@gmail.com; tony@atomide.com; linux-omap@vger.kernel.org
> Subject: OMAP3505 revisions?
> 
> 
> Hi Sanjeev
> 
> Am looking at your commit 4cac6018, which touches 
> arch/arm/mach-omap2/id.c.  That commit implements SoC 
> detection for the 
> 3505 in a different way than the implementations for other 
> OMAP2+ devices: 
> it doesn't enumerate the possible TAP revisions for OMAP3505. 
>  The TRM 

Paul,

In the function omap3_check_revision(), the revision is being
extracted from the TAP register for AM3505/AM3517 devices thru
same code used for OMAP34xx registers.

OR, Am I missing something?

~sanjeev

> doesn't seem to list those, either.  And unfortunately that 
> is blocking 
> some of the omap_chip removal work.
> 
> Could you send me a list of the possible revision values for the 
> 3505/3517, along with mappings to ES levels, please?



> 
> thanks
> 
> - Paul
> 