From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
Date: Tue, 31 May 2011 03:14:55 -0700
Message-ID: <20110531101454.GR11352@atomide.com>
References: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
 <BANLkTin=br7Yw39fnhXbLQg-Wgzym1BXJw@mail.gmail.com>
 <20110418.095915.238185537231006265.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751859Ab1EaKPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 06:15:07 -0400
Content-Disposition: inline
In-Reply-To: <20110418.095915.238185537231006265.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: omar.ramirez@ti.com, linux@arm.linux.org.uk, dacohen@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [110418 00:03]:
> From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
> Subject: Re: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
> Date: Fri, 15 Apr 2011 10:49:42 -0500
> 
> > Hi Hiroshi,
> > 
> > On Fri, Mar 25, 2011 at 3:04 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> >> Commit d038aee24dcd5a2a0d8547f5396f67ae9698ac8e
> >> "omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag",
> >> changes iovmm to receive flags specified by user, however
> >> the upper 16 bits of the flags are wiped by iovmm itself.
> >>
> >> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
> >> map its desired "device addresses".
> >>
> >> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> >> ---
> >>
> >> v2:
> >> Include missing reference (commit and name) to patch in
> >> description.
> > 
> > If no comments, could you ack this patch?
> 
> Tony, please put this in your queue too.

I take that as your ack, will queue into fixes.

Tony
