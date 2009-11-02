From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] New mux code for 34xx
Date: Mon, 2 Nov 2009 10:56:49 -0800
Message-ID: <20091102185649.GC6692@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <4AED6321.7020002@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63259 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbZKBS4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 13:56:46 -0500
Content-Disposition: inline
In-Reply-To: <4AED6321.7020002@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, mike.rapoport@gmail.com

* Mike Rapoport <mike@compulab.co.il> [091101 02:29]:
> Hi Tony,
> 
> Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's an initial version of the new mux code to play with.
> > Big thanks to Paul & Benoit for the 34xx mux data!
> 
> I've tried your patches, they seem to work just fine on CM-T35.

OK cool.
 
> > To try out the new code, compile a kernel with CONFIG_OMAP_MUX
> > and CONFIG_DEBUG_FS and these patches. The series is also
> > availabe in the l-o git in mux branch.
> 
> [ snip ]
> 
> > 
> > Comments welcome as always.
> 
> There are some comments on patches 2 (Add new style pin multiplexing code for
> omap3) and 3 (Add new style pin multiplexing data for 34xx). No nitpicking for
> now, but checkpatch.pl is unhappy with the patchset :)

OK, will run checkpatch.pl --strict on them. Thanks for the
comments!

Regards,

Tony
