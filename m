From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: omapzoom tree broken?
Date: Thu, 11 Sep 2008 15:50:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A252B5F@dbde02.ent.ti.com>
References: <20080909175929.GK8894@flint.arm.linux.org.uk>
 <1f11a5490809091137r66a9d91cl850ad6e034fe5844@mail.gmail.com>
 <20080909185415.GM8894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40333 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbYIKKVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 06:21:08 -0400
In-Reply-To: <20080909185415.GM8894@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ashwin Bihari <abihari@gmail.com>


Russell

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Russell
> King - ARM Linux
> Sent: Wednesday, September 10, 2008 12:24 AM
> To: Ashwin Bihari
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omapzoom tree broken?
> 
> > >
> > > Could we have it accessible via git the protocol please, rather than
> > > http?
> >
> > Russell,
> >
> > I just pulled the omapzoom tree for the first time and it had no
> > problems in the "git clone". Perhaps something to do with fetching
> > into an existing repo?
> 
> Looks like the pack index was corrupted; removing the one it just fetched
> and repulling has made it happier.
> 
> However, it's made me unhappier.  Again, can we please have it accessible
> via the git protocol.  

Yes TI is looking into the option of enabling GIT protocol for the zoom tree.

>Or at least can whoever looks after that tree avoid
> repacking it except maybe once a month?

Yes I will take care not to repack often, till git protocol is available.

> 
> Why?  I don't want to have to keep on fetching 300 odd MB of pack files
> every time I pull from this tree.  10 minutes into my current pull and
> I only have 80MB... another 220MB to go.  IOW, 45 minutes for a pull.
> 
> This really isn't practical.

Agreed.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

