From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 1/2] staging: iio: tsl2563 ambient light sensor driver
Date: Mon, 9 Nov 2009 16:24:30 +0200
Message-ID: <20091109142430.GZ1773@smtp.gmail.com>
References: <1257772468-4004-1-git-send-email-amit.kucheria@verdurent.com>
 <4AF81FE5.5080102@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755666AbZKIOYp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AF81FE5.5080102@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09 Nov 09, Jonathan Cameron wrote:
> Hi Amit,
> 
> Normally I'd welcome this in IIO, except that all ambient light sensors are in the
> process of moving to the new ALS subsystem.  There are still some issues to resolve
> in that subsystem (mainly to do with naming conventions) but hopefully we will
> get them sorted out shortly.

Groan! :) Who will be the subsystem maintainer and is there already a public git
tree?

> I'll take a close look at this sometime over the next few days though.  On a quick
> glance at the data sheet, it looks very similar to the tsl2561.  Perhaps we can merge
> the drivers? Yours is certainly more complete than the tsl2561 version in IIO so it
> would make sense to lift the functional elements in to the code I have for an ALS
> driver. I hadn't posted that previously as I hadn't quite worked out how to handle
> the various gain related settings. What you have done seems to make sense (from a very
> quick look.)

I've got no problem merging the tsl2563 with 2561. I don't have any 2561
hardware to check a merged driver though.


Do you think the ALS framework will be finalised before the 2.6.33 merge
window (in a few weeks)? If not, I wonder if Greg would take this driver to
staging to begin with and I'll modify it to use the ALS subsystem when it
settles down.

Regards,
Amit
