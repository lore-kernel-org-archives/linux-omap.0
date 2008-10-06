From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Mon, 6 Oct 2008 11:42:08 -0700
Message-ID: <200810061142.08759.david-b@pacbell.net>
References: <200810010915.46032.david-b@pacbell.net> <200810021350.03739.david-b@pacbell.net> <20081003.092336.243854668.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:25647 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751559AbYJFSmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:42:16 -0400
In-Reply-To: <20081003.092336.243854668.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

On Thursday 02 October 2008, Hiroshi DOYU wrote:
> For some of the above drivers, omap's "functional clock" and
> "interface clock" doesn't make sense. 

Actually, I thought OMAP was pretty consistent about having
both on all modules where it made sense.


> For such device drivers, those 
> clocks may look just a single necessary clock and there's no "one to
> one" correspondence from the omap clock functionality definitions
> ("ick"/"fck") perspective.

They're all OMAP-specific drivers.  They can know that they
need to ask for both clocks.  If perchance only one of them
were actually needed, that would be exceptional ... and the
driver should be able to assume the device was properly
set up, and continue without it.


> I think that this is one of the examples, 
> where the flexibily is required. Since required functionaliies for
> clocks depends on each device drivers, I think that it would give a
> wider solution to let device drivers to define their logical
> clocks(functionality) flexibly(not 1-to-1), rather than statically
> pre-defined standardized functional names, which is the 1-to-1
> correspondence of ick and fck in the TRM with aliasing.

The ICK/FCK example is not IMO persuasive; this is OMAP, so
the assumption can be that all drivers have both.

Having the clocks set up by clk_associate() would suffice
for most devices and drivers.  Are there ones where that's
not enough ... where a device needs more than those "logical"
clock identifiers?

- Dave

