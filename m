From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 26 Oct 2012 11:06:28 -0700
Message-ID: <20121026180627.GN11908@atomide.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <20121019160041.GB4730@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EB4B4C7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55481 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965701Ab2JZSGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 14:06:33 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB4B4C7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul@pwsan.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [121026 01:24]:
> On Fri, Oct 19, 2012 at 21:30:41, Tony Lindgren wrote:
> > * Richard Cochran <richardcochran@gmail.com> [121018 23:18]:
> > > On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > > > 
> > > > Another important point is, this driver is also required and used for
> > > > Davinci family of devices (arch/mach/mach-davinci/).
> > > 
> > > That is really beside the point. If the code isn't ready yet, then
> > > don't merge it.
> > > 
> > > When I asked about the beaglebone, I was given the impression that it
> > > will be ready for v3.7-rc1.  But, as I know realize, at the current
> > > rate, it might not even be ready for v3.8.
> > > 
> > > I don't mind waiting, but please make sure that whatever lands into a
> > > release is really, truly working.
> > 
> > Indeed. This has been a problem with many of the TI patches in
> > general. People are working on separate product trees and then produce
> > patches for the mainline kernel that are poorly tested.
> > 
> 
> Tony,
> 
> It may not be true always, as we always work simultaneously and there are 
> high chances that some patches/development is dependent on others from 
> functionality perspective (especially baseport), but still they are 
> independent modules (may be for other devices).
> 
> Lets take a example of AM33xx and OMAP5 here, we started submitting baseport 
> patches to the list (almost 6-8 months now), not all the patches gets 
> accepted together in one shot.
> As you know, when we started pushing AM33xx and OMAP5 baseport patches, we 
> were at the stage where both DT and hwmod was required. First attempt for 
> board file submission did not went through, since we decided to force all 
> new devices migrate to DT, right?

I think you guys have done a pretty good job with the am33xx patches
in general to get the core omap changes merged.
 
> So the criteria initially was, build should not break and submit patches 
> step-by-step.
> 
> Now, with baseport patches submitted to list, individual developer can also 
> start submitting patches to the respective driver's list, making sure that, 
> driver doesn't change irrespective of platform. I do not see anything wrong
> with this, as we always consider driver independent.
> 
> In this particular case, note that, all the patches Richard posted recently 
> are AM33xx SoC integration specific patches only.

Yes now the core omap patches are merged, and people want to use
the devices with mainline kernel. That's usually good news :)

Regards,

Tony
