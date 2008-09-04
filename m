From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 18:06:15 -0700
Message-ID: <200809031806.15522.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200809031506.00261.david-b@pacbell.net> <20080903225654.GO19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:23368 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752557AbYIDBGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 21:06:18 -0400
In-Reply-To: <20080903225654.GO19980@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On Wednesday 03 September 2008, Russell King - ARM Linux wrote:
> On Wed, Sep 03, 2008 at 03:05:59PM -0700, David Brownell wrote:
> > According to Mr. Grep, there are at least 10 ARMs that work
> > like that [__arch_ioremap] in mainline.  Maybe Russell can
> > recommend one of them as a preferred model.
> 
> As I've been trying to say, I see this as a separate issue for the near
> future.  At the moment, I'm trying to concentrate on one aspect only.

OK ... if you think that's a "near future" thing, great!  I think
most bad usage in this area came from:

	- Intentional "performance hacks", achieving what can
	  better be done with an arch_ioremap and fixed mappings;

	- Recently introduced goofage;

	- Accidents/misunderstandings.

Those latter two will become much less common when GCC starts to
report errors which previously required a separate "sparse" run.


> That is, getting OMAP to the point that we're using the compiler to
> warn us when we do something silly, like passing a virtual address
> to a function which takes a physical address, and fixing the places
> which are currently wrong.

Yeah.  I did a pass like that over a lot of OMAP1 drivers a few years
back (before OMAP2/OMAP3); "sparse" was a big help.  If we're now ready
to have GCC tell us that stuff, that's a lot better.

- Dave
