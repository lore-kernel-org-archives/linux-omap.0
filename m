From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 11/12] USB: ehci-omap: Try to get PHY even if not in PHY
 mode
Date: Thu, 14 Mar 2013 11:08:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1303141107420.1983-100000@iolanthe.rowland.org>
References: <20130314140832.GH26080@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130314140832.GH26080@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org, b-cousson@ti.com, mark.rutland@arm.com, Kernel development list <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On Thu, 14 Mar 2013, Felipe Balbi wrote:

> > >  		if (IS_ERR(phy) || !phy) {
> > > +			/* Don't bail out if PHY is not absolutely necessary */
> > > +			if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY)
> > > +				continue;
> > > +
> > >  			ret = IS_ERR(phy) ? PTR_ERR(phy) : -ENODEV;
> > >  			dev_err(dev, "Can't get PHY device for port %d: %d\n",
> > >  					i, ret);
> > 
> > Felipe, this is a strange interface.  Why do we sometimes get an 
> > error-pointer and sometimes get just NULL?  Why not always an 
> > error-pointer?
> 
> looks like we get NULL when PHY layer is disabled. Sounds like an
> oversight to me. Do you want to send a patch, or do I cook one and put
> yourself as Reported-by ?

You're more familiar with that code.  "Reported-by" is good enough for 
me.  :-)

Alan Stern
