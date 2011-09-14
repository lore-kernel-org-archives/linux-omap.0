From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3505 revisions?
Date: Wed, 14 Sep 2011 05:46:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109140541260.27954@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB59302575A0074@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37499 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab1INLqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 07:46:08 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A0074@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "notasas@gmail.com" <notasas@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sanjeev,

On Wed, 14 Sep 2011, Premi, Sanjeev wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com] 
> > 
> > Am looking at your commit 4cac6018, which touches 
> > arch/arm/mach-omap2/id.c.  That commit implements SoC 
> > detection for the 
> > 3505 in a different way than the implementations for other 
> > OMAP2+ devices: 
> > it doesn't enumerate the possible TAP revisions for OMAP3505. 
> >  The TRM 
> 
> In the function omap3_check_revision(), the revision is being
> extracted from the TAP register for AM3505/AM3517 devices thru
> same code used for OMAP34xx registers.
> 
> OR, Am I missing something?

Sorry, my original message was not clear.  In omap3_check_revision(), it 
does this for 3517/3505:

		omap_revision = OMAP3505_REV(rev);

but for other chips, it does something like this:

		omap_revision = OMAP3430_REV_ES3_1_2;

The main point being that, with the latter, all of the possible values for 
omap_revision for OMAP3430 are known.

But after I sent that message, I realized that some of the duplicate 
testing code in omap3_cpuinfo() did enumerate revisions for 3517/3505: 
ES1.0 and ES1.1.  So I've used that instead in the patch series that I 
sent.  If there are others beyond those two, please let us know...

Thanks for the quick response.


- Paul
