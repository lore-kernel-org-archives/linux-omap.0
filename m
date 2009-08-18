From: "Madhusudhan" <madhu.cr@ti.com>
Subject: FW: [patch 4/9] mmc: add the new linux-mmc mailing list to MAINTAINERS
Date: Tue, 18 Aug 2009 17:31:33 -0500
Message-ID: <003d01ca2053$a3d1f1e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbZHRWbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 18:31:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, jarkko.lavinen@nokia.com
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]
> Sent: Tuesday, August 18, 2009 5:17 PM
> To: Madhusudhan
> Cc: torvalds@linux-foundation.org; HaraldWelte@viatech.com;
> JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-mmc@vger.kernel.org;
> manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> saschasommer@freenet.de
> Subject: Re: [patch 4/9] mmc: add the new linux-mmc mailing list to
> MAINTAINERS
> 
> On Tue, 18 Aug 2009 17:08:40 -0500
> "Madhusudhan" <madhu.cr@ti.com> wrote:
> 
> >
> >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > owner@vger.kernel.org] On Behalf Of akpm@linux-foundation.org
> > > Sent: Tuesday, August 18, 2009 4:11 PM
> > > To: torvalds@linux-foundation.org
> > > Cc: akpm@linux-foundation.org; HaraldWelte@viatech.com;
> > > JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> > > ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-
> mmc@vger.kernel.org;
> > > manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> > > saschasommer@freenet.de
> > > Subject: [patch 4/9] mmc: add the new linux-mmc mailing list to
> > > MAINTAINERS
> > >
> > > From: Andrew Morton <akpm@linux-foundation.org>
> > >
> > > There are a number of individual MMC drivers listed in MAINTAINERS.  I
> > > didn't modify those records.  Perhaps I should have.
> > >
> > Does this mean that the individual MMC drivers list needs to be changed
> to
> > linux-mmc@vger.kernel.org?
> >
> > For e.g. the OMAP MMC support currently listed as
> >
> > L:     linux-omap@vger.kernel.org
> >
> > Should now be changed as below?
> >
> > L:     linux-mmc@vger.kernel.org
> 
> I don't know - that's why I cc'ed all you guys.  If you think that
> linux-mmc should be mentioned in your driver's MAINTAINERS record then
> please raise a patch to make that change.
> 
Hi Tony, Jarkko,

What is your opinion?

The patch I posted earlier today to linux-mmc@vger.kernel.org list for HSMMC
updation did not make this change to the list name. If you guys agree with
this change I can post it back combining the HS MMC entry. 

Regards,
Madhu
> 
> 


