From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Mon, 29 Oct 2012 05:22:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB5013F@DBDE01.ent.ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <50806B18.1010502@ti.com>
 <alpine.DEB.2.00.1210290518120.30274@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43351 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab2J2FWo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 01:22:44 -0400
In-Reply-To: <alpine.DEB.2.00.1210290518120.30274@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Richard Cochran <richardcochran@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 29, 2012 at 10:49:54, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Fri, 19 Oct 2012, Vaibhav Hiremath wrote:
> 
> > Couple of reasons,
> > 
> > 1. These flags were added for validation, so I expect cpsw driver
> > should work without these flags set. I tested it mounting NFS as rootFS
> > and it works for me.
> > 
> > 2. There is HW bug as far as idle (in turn ocp reset) is concerned, and
> > needs special handling for this. I already have patch for this, which I
> > will submit it to the list.
> > 
> > http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;h=a28da2ac98f173f97dbbb46be1ce0a3879f21a11
> > 
> > 
> > Note: Sorry for long commit description, it was screwed up by someone
> > while git push.
> > 
> > 
> > I have pushed the tested branch to (linux-omap/master + CPSW patches) -
> > https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging
> 
> Just checking on this one.  I don't mean to rush you, but if you have 
> some patches you'd like to see integrated for 3.8 here, it would be good 
> to get them posted before the end of the week.
> 

Paul,

I have just integrated all patches on top of linux-omap/master and testing 
it now. 
Shortly I will submit to the list...


Thanks,
Vaibhav
