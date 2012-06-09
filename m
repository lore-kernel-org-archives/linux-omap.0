From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [CFT 11/11] Add feature removal of old OMAP private DMA
	implementation
Date: Sat, 9 Jun 2012 09:32:17 +0100
Message-ID: <20120609083217.GA11404@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk> <4FD24657.5020207@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55240 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2FIIc3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jun 2012 04:32:29 -0400
Content-Disposition: inline
In-Reply-To: <4FD24657.5020207@landley.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-doc@vger.kernel.org

On Fri, Jun 08, 2012 at 01:37:11PM -0500, Rob Landley wrote:
> On 06/07/2012 06:09 AM, Russell King wrote:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  Documentation/feature-removal-schedule.txt |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> > index 56000b3..1f7ba35 100644
> > --- a/Documentation/feature-removal-schedule.txt
> > +++ b/Documentation/feature-removal-schedule.txt
> > @@ -612,3 +612,14 @@ When:	June 2013
> >  Why:	Unsupported/unmaintained/unused since 2.6
> >  
> >  ----------------------------
> > +
> > +What:	OMAP private DMA implementation
> > +When:	2013
> > +Why:	We have a DMA engine implementation; all users should be updated
> > +	to use this rather than persisting with the old APIs.  The old APIs
> > +	block merging the old DMA engine implementation into the DMA
> > +	engine driver.
> > +Who:	Russell King <linux@arm.linux.org.uk>,
> > +	Santosh Shilimkar <santosh.shilimkar@ti.com>
> > +
> > +----------------------------
> 
> Whose tree do feature-removal-schedule patches go in through?
> 
> (They're not really documentation, they're design coordination/logistics.)

I don't think there is any specific tree.

It would also be silly to split it from this patch set; if it were to be
split, and there would need to be coordination with the rest of the patch
set to ensure this change didn't go in without the rest - that would not
make sense.
