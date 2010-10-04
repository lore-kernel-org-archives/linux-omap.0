From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Mon, 4 Oct 2010 11:53:18 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C8C2@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <20101004084317.725009ef.jhnikula@gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C865@dbde02.ent.ti.com>
 <201010040915.27745.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41042 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab0JDGXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 02:23:34 -0400
In-Reply-To: <201010040915.27745.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>




> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] 
> Sent: Monday, October 04, 2010 11:45 AM
> To: G, Manjunath Kondaiah
> Cc: Jarkko Nikula; Tony Lindgren; linux-omap@vger.kernel.org; 
> Liam Girdwood
> Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable 
> bit setting for omap24xx
> 
> On Monday 04 October 2010 08:55:46 ext G, Manjunath Kondaiah wrote:
> > 
> > 2/2 is applicable for all omap2plus except omap4. So far 2/2 
> > workaround is not used with TI internal trees.
> > 
> > > We experimented that also on 2420 and it seemed to help but since 
> > > the lockup was unrecovable I went thinking if 2420 has 
> also another 
> > > issue what original workaround was trying to fix and buffering 
> > > disable was needed there.
> > 
> > I don't have any data for 2420. Based on your observation, it is 
> > better to disable buffering for 2420.
> 
> Does the same errata number applies to OMAP2 and OMAP3 as well?
No errata numbers numbers used with TI errata documents till omap2430.
Errata numbers avaialable from omap3430 onwards.

> For OMAP3 the errata number is i541, but I do not know the 
> iXYZ number for OMAP2 class.

Being said that no errata numbers for omap2 class, it's ok to use
omap3 errata numbers for common errata(like your patch 2/2)

-Manjunath




