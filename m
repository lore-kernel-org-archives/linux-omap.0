From: Matt Porter <mporter@ti.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 19 Oct 2012 12:32:37 -0400
Message-ID: <20121019163237.GG25164@beef>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <20121019160041.GB4730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44044 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab2JSQbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 12:31:14 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so914724iea.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 09:31:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121019160041.GB4730@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 19, 2012 at 09:00:41AM -0700, Tony Lindgren wrote:
> * Richard Cochran <richardcochran@gmail.com> [121018 23:18]:
> > On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > > 
> > > Another important point is, this driver is also required and used for
> > > Davinci family of devices (arch/mach/mach-davinci/).
> > 
> > That is really beside the point. If the code isn't ready yet, then
> > don't merge it.
> > 
> > When I asked about the beaglebone, I was given the impression that it
> > will be ready for v3.7-rc1.  But, as I know realize, at the current
> > rate, it might not even be ready for v3.8.
> > 
> > I don't mind waiting, but please make sure that whatever lands into a
> > release is really, truly working.
> 
> Indeed. This has been a problem with many of the TI patches in
> general. People are working on separate product trees and then produce
> patches for the mainline kernel that are poorly tested.
> 
> The requirement should be: Do your patch on an omap board then send the
> patch from your omap board after booting your board with the patch :)

s/should be/is/

I fixed that for you. :) That's always been the requirement for the
kernel, period. There's also a lot of dead/unused code in the davinci
driver world too...so omap isn't alone with this phenomenon.

-Matt
