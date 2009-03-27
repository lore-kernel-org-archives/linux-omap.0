From: Tony Lindgren <tony@atomide.com>
Subject: Re: tidspbridge git repository
Date: Fri, 27 Mar 2009 09:50:44 -0700
Message-ID: <20090327165043.GB18109@atomide.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com> <20090323194711.GI29546@atomide.com> <49CCCF4E.2010708@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64290 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbZC0Quq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 12:50:46 -0400
Content-Disposition: inline
In-Reply-To: <49CCCF4E.2010708@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Nishanth Menon <nm@ti.com>

* Ameya Palande <ameya.palande@nokia.com> [090327 06:06]:
> Hi Tony,
> 
> ext Tony Lindgren wrote:
> > * ameya.palande@nokia.com <ameya.palande@nokia.com> [090323 00:42]:
> >> Hi Tony,
> >>
> >> I have collected latest patches for tidspbridge at:
> >> git://gitorious.org/tidspbridge/mainline.git 
> >>
> >> Branch is: tidspbridge
> >>
> >> It is based on your pm branch.
> >> Can you pull it to your tidspbridge branch?
> > 
> > What dependencies are there to the PM branch?
> > 
> > To me it sounds like you should rebase your tidspbridge branch
> > against the mainline kernel as the drivers should be arch
> > independent.
> > 
> > If something is missing from the mainline kernel to rebase and
> > compile tidspbridge against the mainline, we need to fix those
> > issues.
> > 
> > Regards,
> > 
> > Tony
> 
> I have rebased tidspbridge patches on top of current pm branch.
> Currently bridge depends on some pm features which are not yet in
> mainline.

Can you please describe what those dependencies are? We should fix
those so we don't have dependencies.
 
> But at least now it can be compiled for your latest pm branch which
> I guess is in turn based on 2.6.29
> 
> Here is the git URL:
> git://gitorious.org/tidspbridge/mainline.git
> 
> Branch is: tidspbridge-2.6.29-pm

The thing is that in order to do the development in parallel, we want
to base all the branches against the mainline kernel. Otherwise we'll
have unnecessary dependencies between the branches.

Tony
