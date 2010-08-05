From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] omap3: Remove non-existent config option
Date: Thu, 5 Aug 2010 10:12:11 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D537702@dlee03.ent.ti.com>
References: <1279790027-2509-1-git-send-email-premi@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7ED0D93@dbde02.ent.ti.com>
	<20100804111147.GL9881@atomide.com>
 <20100804.142025.108806991.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48917 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933531Ab0HEPMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 11:12:18 -0400
In-Reply-To: <20100804.142025.108806991.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "Marathe, Yogesh" <yogesh_marathe@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>

Hiroshi,
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Wednesday, August 04, 2010 6:20 AM
> To: tony@atomide.com
> Cc: Marathe, Yogesh; linux-omap@vger.kernel.org; Premi, Sanjeev
> Subject: Re: [PATCH] omap3: Remove non-existent config option
> 
> From: ext Tony Lindgren <tony@atomide.com>
> Subject: Re: [PATCH] omap3: Remove non-existent config option
> Date: Wed, 4 Aug 2010 13:11:47 +0200
> 
> > * Marathe, Yogesh <yogesh_marathe@ti.com> [100803 11:03]:
> >> ping..
> > 
> > Hiroshi ack/nak?
> 
> Nak.
> 
> http://www.spinics.net/lists/linux-omap/msg32869.html
> 
> "tidspbridge" is in staging now.

Can you please elaborate what this means ? 
Yogesh patch enables the IOMMU for BRIDGE by default and we need this as IOMMU is going to get use in 3430.

> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 