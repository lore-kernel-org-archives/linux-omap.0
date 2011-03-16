From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 19:50:17 +0530
Message-ID: <20110316142017.GB10385@m-desktop>
References: <20110314192538.GH7258@atomide.com>
 <20110316140710.GA10385@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46727 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362Ab1CPOWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 10:22:44 -0400
Received: by mail-yi0-f42.google.com with SMTP id 21so1029948yic.15
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 07:22:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316140710.GA10385@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, Mar 16, 2011 at 07:37:10PM +0530, G, Manjunath Kondaiah wrote:
> On Mon, Mar 14, 2011 at 12:25:38PM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > I've applied few random fix like patches today into omap-for-linus
> > but that's it for this merge window.
> > 
> > So let's do some testing with with Stephen's for-next and
> > omap-for-linus and start queueing up fixes for the -rc cycle.
> omap-for-linus boots on:
> OMAP3430-Zoom2
> OMAP3630-Zoom3
> OMAP4430-Blaze
> 
> With OMAP3 and OMAP4 disabled, it boots successfully on:
> OMAP2420-H4
> OMAP2430-SDP

Also boots on OMAP1710-H3

-Manjunath

> 
> -Manjunath
> 
> > 
> > I've also moved all the patchwork.kernel.org patches into
> > archived-v2.6.39 bundle and marked them as archived:
> > 
> > https://patchwork.kernel.org/user/bundle/1381/
> > 
> > You can still find the patches there if you click on Filters
> > and changed Archived from No to Both.
> > 
> > Looks like there's one smartreflex patch that does not seem
> > to exist in patchwork though.. So that one is still lurking
> > around on the patchwork list of patches until the issue has
> > been fixed in patchwork.kernel.org.
> > 
> > Cheers,
> > 
> > Tony
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
