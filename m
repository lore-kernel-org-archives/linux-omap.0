From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 16:24:01 -0700
Message-ID: <20081016232400.GD15820@atomide.com>
References: <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com> <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com> <20081016205743.GS15820@atomide.com> <e5e6ade50810161507y4a5ac9d6m9754169575dfbdda@mail.gmail.com> <20081016221053.GZ15820@atomide.com> <e5e6ade50810161515h6c050ab2k1657e1e3a12edd6c@mail.gmail.com> <20081016225222.GA15820@atomide.com> <20081016225905.GB15820@atomide.com> <20081016230203.GC15820@atomide.com> <e5e6ade50810161620k29cbc356i3f92fa80771ffec4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51581 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905AbYJPXYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 19:24:05 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810161620k29cbc356i3f92fa80771ffec4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Rick Bronson <rick@efn.org>

* Nathan Monson <nmonson@gmail.com> [081016 16:20]:
> On Thu, Oct 16, 2008 at 4:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Well with this one I eventually got one -33 error, but not a series of
> > them.
> >
> > This is with Lauri's patch and this patch applied.
> 
> With this patch alone, or with this patch plus your earlier patch, I
> still get a dead kernel printing an endless series of the -33 errors.
> 
> With Lauri's patch alone, I can run the DSP all day.  I still get a
> fairly steady stream of -33s errors, but the kernel never gets stuck
> in a loop and the DSP continues working.
> 
> With the S-O patch, everything works.  No errors.

OK, time to push the SO patch, can you reply with your Signed-off-by
for that?

Thanks,

Tony
