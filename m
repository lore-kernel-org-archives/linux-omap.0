From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
 instead of values
Date: Fri, 25 Feb 2011 13:10:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251309060.6198@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com> <8dcdd90dcde5ddefc02b08dc2faf9169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932804Ab1BYUKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 15:10:12 -0500
In-Reply-To: <8dcdd90dcde5ddefc02b08dc2faf9169@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 8 Feb 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, February 08, 2011 7:16 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
> > rnayak@ti.com; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 3/9] omap4: powerdomain: Use intended
> > PWRSTS_* flags instead of values
> >
> > On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
> >
> > > IVAHD and ABE power domain logic state is populated using directly
> > > value instead of the capability flags.
> > >
> > > Fix the same.
> > >
> > > This was getting generated due to a bug 'gen_logicst' macro
> > > in powerdomain autogen script bug which is fixed as well.
> >
> > Should we try to get this one into the -rc series, since it is a
> > bug-fix ?
> >
> Make sense.

Upon further reflection, I don't think that this is needed for 2.6.38-rc, 
so will queue it for .39 instead.


- Paul
