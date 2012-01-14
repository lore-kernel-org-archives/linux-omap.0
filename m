From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 18:28:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201131828010.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <87hazzquhb.fsf@ti.com> <87lipbp6uq.fsf@ti.com> <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com> <alpine.DEB.2.00.1201131606310.3659@utopia.booyaka.com> <20120114121726.5da0949c@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46458 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab2ANB2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 20:28:14 -0500
In-Reply-To: <20120114121726.5da0949c@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: govindraj.raja@ti.com, Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, linux-omap@vger.kernel.org

On Sat, 14 Jan 2012, NeilBrown wrote:

> On Fri, 13 Jan 2012 16:34:06 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> 
> > 
> > So ideally this formula should change the "8" depending on the number of 
> > data bits, whether there is a parity bit, and on the number of stop bits.  
> > The real formula to determine the number of bits per byte should be 
> > something like:
> > 
> >     bits_per_byte = number of data bits + 1 bit if parity is used + number 
> >                     of stop bits
>                      + 1 for the start bit.

Indeed...


- Paul
