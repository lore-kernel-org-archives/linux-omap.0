From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] staging: iio: tsl2563 ambient light sensor driver
Date: Tue, 10 Nov 2009 16:58:13 +0800
Message-ID: <1257843493.4469.25.camel@rzhang-dt>
References: <1257772468-4004-1-git-send-email-amit.kucheria@verdurent.com>
	 <4AF81FE5.5080102@cam.ac.uk> <20091109142430.GZ1773@smtp.gmail.com>
	 <4AF85ABB.7060406@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbZKJJAt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 04:00:49 -0500
In-Reply-To: <4AF85ABB.7060406@cam.ac.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tue, 2009-11-10 at 02:08 +0800, Jonathan Cameron wrote:
> Amit Kucheria wrote:
> > On 09 Nov 09, Jonathan Cameron wrote:
> >> Hi Amit,
> >>
> >> Normally I'd welcome this in IIO, except that all ambient light sensors are in the
> >> process of moving to the new ALS subsystem.  There are still some issues to resolve
> >> in that subsystem (mainly to do with naming conventions) but hopefully we will
> >> get them sorted out shortly.
> > 
> > Groan! :)
> You have my sympathies on this! Typical that the first other developer to put
> forward a patch for IIO picks the one type of device we are moving out.
> If you do have any comments on IIO as a result of using it please send them
> on.
> > Who will be the subsystem maintainer and is there already a public git
> > tree?
> No git tree as far as I know.  Maintainer is Zhang Rui (Cc'd)
> Zhang, what are your plans wrt to that?  I guess I can put one up with the current
> patches if it is helpful?  We really need to sort out the naming issue as the one
> thing that people have come out against. 
> 
well. I'd prefer a generic name alsX with an extra "name"/"desc" file.

> After that I'm guessing ping Andrew Morton to see if he is willing to handle the push
> to Linus? Or does Zhang want to try doing one directly?
> 
I'll refresh the patch and send to Andrew.

thanks,
rui

> >> I'll take a close look at this sometime over the next few days though.  On a quick
> >> glance at the data sheet, it looks very similar to the tsl2561.  Perhaps we can merge
> >> the drivers? Yours is certainly more complete than the tsl2561 version in IIO so it
> >> would make sense to lift the functional elements in to the code I have for an ALS
> >> driver. I hadn't posted that previously as I hadn't quite worked out how to handle
> >> the various gain related settings. What you have done seems to make sense (from a very
> >> quick look.)
> > 
> > I've got no problem merging the tsl2563 with 2561. I don't have any 2561
> > hardware to check a merged driver though.
> 
> On a reasonably thorough review of data sheets I think the only difference is the
> input voltage range and a few timing parameters.  These two chips even use the same
> addresses.  I'll actually test your driver against the tsl2561 sometime later in the
> week to be sure.  So the merge looks like adding a few more lines to the i2c_device_id
> table.  As a quick comment you would ideally have the tsl2563 and tsl2562 in there
> already.
> > 
> > 
> > Do you think the ALS framework will be finalised before the 2.6.33 merge
> > window (in a few weeks)? If not, I wonder if Greg would take this driver to
> > staging to begin with and I'll modify it to use the ALS subsystem when it
> > settles down.
> I'm certainly happy with that as an option if Greg is willing. In fact,
> adding this with tsl2560-> tsl2563 support and removing the current tsl2561 driver would
> be great (post any reviews over the next couple of days).
> 
> Thanks,
> 
> Jonathan

