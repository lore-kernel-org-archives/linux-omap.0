From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7 v2] OMAP2430: hwmod data: Add McSPI
Date: Sun, 2 Jan 2011 21:00:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101022039040.29630@utopia.booyaka.com>
References: <33236.10.24.255.18.1291212082.squirrel@dbdmail.itg.ti.com> <20101230190320.GA2713@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52382 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1ACEAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Jan 2011 23:00:41 -0500
In-Reply-To: <20101230190320.GA2713@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Cousson@dbdmail.itg.ti.com, Benoit <b-cousson@ti.com>, Charulatha V <charu@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Thu, 30 Dec 2010, Grant Likely wrote:

> On Wed, Dec 01, 2010 at 07:31:22PM +0530, Govindraj.R wrote:
> > From: Charulatha V <charu@ti.com>
> > 
> > Update the 2430 hwmod data file with McSPI info.
> > 
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> 
> Hmmm; this patch is virtually identical to the first patch in this
> series which adds 2420 hwmod support.  I see a large block of
> identical data with minor differences.  Surely support for these two
> chips can share the common blocks of data.

Yes, that's probably worth doing at some point, particularly for the chips 
that don't have auto-generated SoC data (OMAP2420/2430/3xxx).  It's 
probably possible also for the auto-generated SoC data but will require 
some major changes to the auto-generation scripts.

In the medium term, Thomas's upcoming conditional section patches should 
reduce the runtime memory usage for hwmod data unrelated to the 
currently-booted SoC down to zero.


- Paul
