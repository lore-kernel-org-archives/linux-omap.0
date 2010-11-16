From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] OMAP: mux: Add support for control module split in
 several partitions
Date: Tue, 16 Nov 2010 09:37:03 -0800
Message-ID: <20101116173703.GU9264@atomide.com>
References: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
 <1289511321-18532-3-git-send-email-b-cousson@ti.com>
 <20101115200316.GK9264@atomide.com>
 <4CE1AA4A.10602@ti.com>
 <20101116164149.GQ9264@atomide.com>
 <4CE2B951.2070609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31052 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab0KPRhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 12:37:18 -0500
Content-Disposition: inline
In-Reply-To: <4CE2B951.2070609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [101116 08:53]:
> Hi Tony,
> 
> On 11/16/2010 5:41 PM, Tony Lindgren wrote:
> >* Cousson, Benoit<b-cousson@ti.com>  [101115 13:36]:
> >>Hi Tony,
> >>
> >>On 11/15/2010 9:03 PM, Tony Lindgren wrote:
> >>>* Benoit Cousson<b-cousson@ti.com>   [101111 13:26]:
> >>>>Starting on OMAP4, the pin mux configuration is located in two
> >>>>different partitions of the control module (CODE_PAD and WKUP_PAD).
> >>>>The first one is inside the core power domain whereas the second
> >>>>one is inside the wakeup.
> >>>>- Add the capability to add any number of partition during board init
> >>>>time depending of Soc partitioning.
> >>>>- Add some init flags as well in order to avoid explicit Soc version
> >>>>check inside the mux core code.
> >>>>- Add a comment with mux0 mode on top of omap_mux/board/<partition>
> >>>>if the current mux mode is not the default one.
> >>>
> >>>Here's one more patch that I'd like to merge into this patch to avoid
> >>>repeating the partition for each mux entry.
> >>
> >>The memory vendors will not like you ;-)
> >>
> >>>Assuming no more comments, I'll queue these for 2.6.38 merge window.
> >>
> >>I'll update the series and re-post tomorrow.
> >
> >Thanks, no need to post them again, I already have them queued
> >locally, they will hit for-next and linux-omap master today.
> 
> OK, but I already did it because there is a checkpatch issue in your
> first patch and I received another patch from Dan to add __func__ in
> the pr_xxx macros.
> I can repost, or you can get the update in my GIT (ctrl-wip/mux-omap4-v4).

OK, if they're changed maybe repost the whole series one more time,
and then I'll merge in your branch assuming no more comments.
 
> >BTW, next time you do a git branch, please base it on Linus recent
> >-rc tag instead of linux-omap master branch. We don't want the
> >history of linux-omap master branch merged to the mainline tree..
> 
> Euh, this is what I already did for this series. Quoting myself:
> 
> "The series is based on mainline (2.6.37-rc1) and is available here:
> git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v3"
> 
> Did I messed up something?

No, mux-omap4-v4 branch looks OK. I guess what I tried pulling
was something older.

Regards,

Tony
