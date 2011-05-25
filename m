From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] ARM: OMAP: L3 interconnect: Error reporting cleanups
Date: Wed, 25 May 2011 11:43:11 -0700
Message-ID: <20110525184311.GA1116@google.com>
References: <20110525025021.GA8460@google.com>
 <4DDCAB44.2060006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:55227 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1EYSnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 14:43:18 -0400
Content-Disposition: inline
In-Reply-To: <4DDCAB44.2060006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, May 25, 2011 at 12:39:56PM +0530, Santosh Shilimkar wrote:
> Tod,
> On 5/25/2011 8:20 AM, Todd Poynor wrote:
> >* Move variable declarations from header file and make these static
> >   (the entire header file should probably go away).
> >
> Infact the intial version posted on the list had all these structures
> in C file. After some comments on the list we moved them to header file.
> Let's not move it again.

I searched (a little) but didn't find the feedback that led to this.
Tell me more?  Defining variables (not externs, not even statics) in
header files is usually frowned upon.

> 
> >* Define L3 TARG instance offsets, and read/write STDERRLOG registers
> >   relative to those offsets, rather than defining STDERRLOG_MAIN
> >   instance offsets and accessing other registers via offsets from
> >   that register.
> >
> >* Use ffs() to find error source from the L3_FLAGMUX_REGERRn
> >   register.
> >
> >* Remove extra l3_base[] entry.
> >
> >* Modify L3 custom error message for consistency with standard
> >   error message.
> >
> These changes are ok.
> 
> >* Fixup indentation in one spot.
> >
> This code indentations needs more fixing and I have patch to
> clean that up. Your change is already part of that patch.
>

OK.
 
> 
> >---
> >  arch/arm/mach-omap2/omap_l3_noc.c |  122 +++++++++++++++++++++++++++++++------
> >  arch/arm/mach-omap2/omap_l3_noc.h |   88 +-------------------------
> >  2 files changed, 106 insertions(+), 104 deletions(-)
> >
> Can you update your patch with above. I will add that along with other
> L3 clean-up patch.
> 
> Thanks
> 
> regards
> Santosh
