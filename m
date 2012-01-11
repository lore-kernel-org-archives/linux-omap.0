From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Wed, 11 Jan 2012 06:29:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com> <4EEB086A.2050607@ti.com> <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
 <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51864 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab2AKN3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 08:29:08 -0500
In-Reply-To: <4F0D26DF.1020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, ben-linux@fluff.org

On Wed, 11 Jan 2012, Shubhrajyoti wrote:

> On Tuesday 10 January 2012 08:56 PM, Kevin Hilman wrote:
> > "Datta, Shubhrajyoti" <shubhrajyoti@ti.com> writes:
> >
> >> On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
> >> <shubhrajyoti@ti.com> wrote:
> >>>
> >>> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
> >>>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
> >>>>
> >>>>> This patch either needs to be acked by Ben with a note that it's okay for
> >>>>> us to merge through the OMAP tree, or needs to be merged by Ben during the
> >>>>> 3.4 merge window, after patches 1-3 have reached the mainline tree.
> >>>> I agree.
> >>>> Ben do you have any comments .
> >>>
> >> If there are no further comments can this be merged also ?
> > As Benoit mentioned earlier, the addition of new pdata fields will cause
> > problems with the DT support already queued for v3.3.
> >
> > This series should be reworked on top of the DT support which Ben has
> > now queued for v3.3 (my branch: for_3.3/i2c/misc)
> 
> Yes will rework it.

Depending on what you plan to do, you'll probably need to coordinate this 
with Tony also.  He's already pulled some of the patches from this series 
into his i2c branch.

The real question is how you plan to handle the device reset function, 
given that the driver should compile on a non-OMAP build (meaning that you 
can't call omap_device*() functions from the driver directly), nor should 
the driver touch the SYSCONFIG register directly.


- Paul
