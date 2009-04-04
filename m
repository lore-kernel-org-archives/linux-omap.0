From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Fri, 3 Apr 2009 17:05:31 -0700
Message-ID: <20090404000531.GE8840@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com> <20090226140450.GB8595@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FB102A76@dbde02.ent.ti.com> <20090403085335.GA3759@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54940 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759893AbZDDAFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:05:37 -0400
Content-Disposition: inline
In-Reply-To: <20090403085335.GA3759@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Mark Brown <broonie@sirena.org.uk> [090403 01:53]:
> On Fri, Apr 03, 2009 at 01:33:58PM +0530, Aggarwal, Anuj wrote:
> 
> > I could not find the commit in linux-OMAP git where the init data is 
> > passed as a parameter to the regulator_register(). I am dependent 
> > on this commit for my TPS65023 regulator driver and could not push 
> > my patch without the commit being in l-o.
> 
> > Any idea when this would be available in l-o?
> 
> I can't speak for the OMAP tree but the patch should appear in
> 2.6.30-rc1 so presumably it'll get merged into OMAP some time after that
> is released.

Sounds good to me.

Tony
