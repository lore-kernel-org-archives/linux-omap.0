From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Wed, 4 Aug 2010 16:25:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E68F1F@dbde02.ent.ti.com>
References: <20100803073940.GS12293@atomide.com>
 <1280865564-6456-1-git-send-email-gadiyar@ti.com>
 <20100804103029.GI9881@atomide.com> <20100804105138.GJ9881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49129 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab0HDKzZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:55:25 -0400
In-Reply-To: <20100804105138.GJ9881@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, August 04, 2010 4:22 PM
> To: Gadiyar, Anand
> Cc: linux-omap@vger.kernel.org; Menon, Nishanth; G, Manjunath Kondaiah
> Subject: Re: [PATCH v2] OMAP3630: Add ES1.1 and ES1.2 detection
> 
> * Tony Lindgren <tony@atomide.com> [100804 13:23]:
> > * Anand Gadiyar <gadiyar@ti.com> [100803 22:52]:
> > > Add revision detection for ES1.1 and ES1.2. Set default
> > > revision as ES1.2.
> > > 
> > > Add CHIP_GE_OMAP3630ES1_1 to detect revisions 1.1 and later.
> > > This is needed for at least one feature that is broken in
> > > 3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.
> > > 
> > > Additionally, update some of the CHIP_GE_* macros to use other
> > > macros for ease of maintenance.
> > 
> > Thanks, I've updated it a bit more for the fallthrough handling,
> > here's the updated version.
> 
> That does not even build, here's the patch one more time.
> 

This one doesn't seem to build either :(
The two patches you sent are identical except for the first line,
so maybe you attached the wrong file?

- Anand