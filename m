From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Mon, 18 Aug 2008 13:22:47 +0300 (EEST)
Message-ID: <20080818.132247.239771130.Hiroshi.DOYU@nokia.com>
References: <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
	<20080818091305.GA23078@kos.to>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65294 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbYHRKXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 06:23:31 -0400
In-Reply-To: <20080818091305.GA23078@kos.to>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: riku.voipio@iki.fi
Cc: r-woodruff2@ti.com, felipe.contreras@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, soni.trilok@gmail.com, h-kanigeri2@ti.com, x00omar@ti.com, grgupta@ti.com, felipe.contreras@nokia.com, vpasam@ti.com

From: "ext Riku Voipio" <riku.voipio@iki.fi>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 12:13:05 +0300

> On Fri, Aug 15, 2008 at 03:16:29PM -0500, Woodruff, Richard wrote:
> > Checkpatch.pl is just a guide.  Completely changing code for the tool isn't probably a good idea. It might even get you severally flamed on LKML :)  The recent threads are informative (ok to read, bad to be in).
> 
> > Incidentally, when I asked the person working these changes, they had reported 0 functional errors had been fixed by the checkpatch changes.  A lot of the noise was typedef reduction.
> 
> I don't think completly fair complaint.
> 
> checkpatch.pl is only meant to check that patches comply to the kernel
> Coding style. For a huge project such as Linux kernel, all code must
> be written in uniform style. DSP bridge has probably been written
> following TI's internal codingstyle documents, and as a first step
> it needs to be converted to follow the Linux codingstyle.
> 
> checkpatch not a static analysing tool, which would be
> neccessary for uncovering functional errors. For that we have sparse,
> and mainline kernel gets regularry checked with the coverity scanner.
> 
> Focusing on checkpatch errors is a bit deceptive. It is
> perfectly possible to be "checkpatch clean" yet the code
> has lots of issues left. For example checkpatch cannot tell
> that CSL_Strlen() can be replaced with strlen() from kernel.

Yes, this is also the another point to be fixed.
Homebrewed APIs(sync, list, clk) in bridge should be replaced by
kernel APIs. Some of them are enhaced with some debug trace features,
but if these features are really necessary, they should be
implmemented in Linux kernel APIs or shold be in the more upper layer
of bridge to check.

Probably you can also find other trivial things in:

       Documentation/CodingStyle
       Documentation/SubmitChecklist
       Documentation/SubmittingPatches

       Hiroshi DOYU

