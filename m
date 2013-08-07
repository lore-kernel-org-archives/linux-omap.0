From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] pdev: Fix platform device resource linking
Date: Wed, 7 Aug 2013 09:27:24 +0100
Message-ID: <20130807082723.GI23053@n2100.arm.linux.org.uk>
References: <1375775624-12250-1-git-send-email-panto@antoniou-consulting.com> <1375775624-12250-2-git-send-email-panto@antoniou-consulting.com> <20130806093601.GB27889@kroah.com> <311C42C3-6544-4058-ABE9-F9FAE72DD5CA@antoniou-consulting.com> <20130806101527.GB29283@kroah.com> <20130806101914.GH23053@n2100.arm.linux.org.uk> <20130807055700.GD5304@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40658 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3HGI1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 04:27:43 -0400
Content-Disposition: inline
In-Reply-To: <20130807055700.GD5304@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Coussno <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 07, 2013 at 02:57:00PM +0900, Greg Kroah-Hartman wrote:
> On Tue, Aug 06, 2013 at 11:19:14AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 06, 2013 at 06:15:27PM +0800, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 06, 2013 at 12:45:42PM +0300, Pantelis Antoniou wrote:
> > > > What would it take to move all this into driver core?
> > > 
> > > What specifically would you move into there?
> > 
> > A variable to hold the streaming dma_mask, so that its in struct device
> > rather than having to be separate.  Yes, we can keep the pointer in there
> > too, because that appears to convey meaning in the kernel today - whether
> > the device can do DMA or not.
> > 
> > A NULL dma_mask pointer already means it can't and dma_set_mask() always
> > fails.  A non-NULL dma_mask pointer means the driver can use
> > dma_set_mask() to set an appropriate mask.
> 
> Ok, that sounds fine to me, for some reason I thought I said yes to this
> a long time ago, did no one ever send me a patch for it?

Apparantly not.  I'll see what I can do, and I'll add it to my dma-masks
series, probably below most of the existing patches that are already
there.
