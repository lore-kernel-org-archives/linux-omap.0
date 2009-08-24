From: Tony Lindgren <tony@atomide.com>
Subject: Re: FW: [patch 4/9] mmc: add the new linux-mmc mailing list to
	MAINTAINERS
Date: Mon, 24 Aug 2009 17:05:35 +0300
Message-ID: <20090824140534.GF5165@atomide.com>
References: <003d01ca2053$a3d1f1e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64874 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbZHXOFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:05:39 -0400
Content-Disposition: inline
In-Reply-To: <003d01ca2053$a3d1f1e0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: jarkko.lavinen@nokia.com, linux-omap@vger.kernel.org

Hi,

* Madhusudhan <madhu.cr@ti.com> [090819 01:31]:
> 
> 
> > -----Original Message-----
> > From: Andrew Morton [mailto:akpm@linux-foundation.org]
> > Sent: Tuesday, August 18, 2009 5:17 PM
> > To: Madhusudhan
> > Cc: torvalds@linux-foundation.org; HaraldWelte@viatech.com;
> > JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> > ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-mmc@vger.kernel.org;
> > manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> > saschasommer@freenet.de
> > Subject: Re: [patch 4/9] mmc: add the new linux-mmc mailing list to
> > MAINTAINERS
> > 
> > On Tue, 18 Aug 2009 17:08:40 -0500
> > "Madhusudhan" <madhu.cr@ti.com> wrote:
> > 
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > owner@vger.kernel.org] On Behalf Of akpm@linux-foundation.org
> > > > Sent: Tuesday, August 18, 2009 4:11 PM
> > > > To: torvalds@linux-foundation.org
> > > > Cc: akpm@linux-foundation.org; HaraldWelte@viatech.com;
> > > > JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> > > > ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-
> > mmc@vger.kernel.org;
> > > > manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> > > > saschasommer@freenet.de
> > > > Subject: [patch 4/9] mmc: add the new linux-mmc mailing list to
> > > > MAINTAINERS
> > > >
> > > > From: Andrew Morton <akpm@linux-foundation.org>
> > > >
> > > > There are a number of individual MMC drivers listed in MAINTAINERS.  I
> > > > didn't modify those records.  Perhaps I should have.
> > > >
> > > Does this mean that the individual MMC drivers list needs to be changed
> > to
> > > linux-mmc@vger.kernel.org?
> > >
> > > For e.g. the OMAP MMC support currently listed as
> > >
> > > L:     linux-omap@vger.kernel.org
> > >
> > > Should now be changed as below?
> > >
> > > L:     linux-mmc@vger.kernel.org
> > 
> > I don't know - that's why I cc'ed all you guys.  If you think that
> > linux-mmc should be mentioned in your driver's MAINTAINERS record then
> > please raise a patch to make that change.
> > 
> Hi Tony, Jarkko,
> 
> What is your opinion?
> 
> The patch I posted earlier today to linux-mmc@vger.kernel.org list for HSMMC
> updation did not make this change to the list name. If you guys agree with
> this change I can post it back combining the HS MMC entry. 

I suggest you have two L entries, linux-mmc and linux-omap lists both so the
omap people can easily follow the dicussion without having to separately
subscribe to all the driver lists.

Tony
