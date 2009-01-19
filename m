From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 12:53:57 +0000
Message-ID: <20090119125356.GA17861@n2100.arm.linux.org.uk>
References: <1232360583.6481.92.camel@tubuntu> <20090119110116.GA15007@n2100.arm.linux.org.uk> <1232368054.6481.110.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758851AbZASMyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 07:54:14 -0500
Content-Disposition: inline
In-Reply-To: <1232368054.6481.110.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Jan 19, 2009 at 02:27:34PM +0200, Tomi Valkeinen wrote:
> On Mon, 2009-01-19 at 11:01 +0000, ext Russell King - ARM Linux wrote:
> > On Mon, Jan 19, 2009 at 12:23:03PM +0200, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> > > with iounmap(). It looks like iounmap() does not properly free large
> > > areas. Below is a test which fails for me in 6-7 loops.
> > > 
> > > OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> > > generic ARM code. I looked at the ioremap code and for larger areas the
> > > code uses area sections, and I believe the bug is somewhere there. 
> > 
> > In unmap_area_sections(), try changing:
> > 
> >         unsigned long addr = virt, end = virt + (size & ~SZ_1M);
> > 
> > to
> > 
> >         unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
> 
> This didn't help. I Added two debug prints, not sure if it means
> anything but the size on the second unmap is not the same as in the
> previous ones.

If you read the comments on unmap_area_sections, you'd understand why
this is.

> remap_area_sections(virt=d2000000, size=1000000, end=d3000000, pfn=70000)
> unmap_area_sections(virt=d2000000, size=1000000, end=d3000000)
> ioremapped to d2000000
> unmap_area_sections(virt=d2000000, size=1001000, end=d3000000)

Yes, so changing that line results in 'end' being the correct 0x1000000
bytes greater than 'virt', as can be seen from the above.  Before this
change, end would've been 0xd3001000 which is incorrect.

Now, if there's something else wrong, please be more expansive about it.
Please given an exact description of the failure you're seeing.  (I'm
not going to be able to try your test program for several days.)
