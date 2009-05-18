From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 18:06:56 +0100
Message-ID: <20090518170656.GJ7042@n2100.arm.linux.org.uk>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <20090518133241.GH3067@n2100.arm.linux.org.uk> <87my9a8hxf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53022 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZERRHI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 13:07:08 -0400
Content-Disposition: inline
In-Reply-To: <87my9a8hxf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Mon, May 18, 2009 at 10:00:44AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
> >> This patch is to sync the core linux-omap PM code with mainline.  This
> >> code has evolved and been used for a while the linux-omap tree, but
> >> the attempt here is to finally get this into mainline.
> >> 
> >> Following this will be a series of patches from the 'PM branch' of the
> >> linux-omap tree to add full PM hardware support from the linux-omap
> >> tree.
> >> 
> >> Much of this PM core code was written by Jouni Hogander with
> >> significant contributions from Paul Walmsley as well as many others
> >> from Nokia, Texas Instruments and linux-omap community.
> >
> > Overall comment, I think we need to rework the idle support code so
> > that enable_hlt/disable_hlt can be used even when pm_idle has been
> > overridden, rather than OMAP going off and inventing its own mechanisms.
> 
> Would adding:
> 
> 	if (hlt_counter)
> 		cpu_relax();
> 
> to the beginning of omap*_pm_idle functions be sufficient?  That will
> at least allow the hlt stuff to behave as expected.

Yes, but the comment was also directed at the other functions which
increment/decrement that atomic_t variable to enable/disable sleep mode.

> The only thing the OMAP /sys/power/sleep_while_idle hook adds to this
> functionality is the ability to control this from sysfs.
> 
> Any objections to /sys/power/enable_hlt?

That seems to be rather dangerous, even with your atomic based code which
bugs if the count goes below zero.

The problem here is that such an interface is extremely fragile.  Consider
what happens if a program disables HLT, and then gets killed off for some
reason.  How does this reference get balanced again?

I think a better solution would be a char device driver which has to be
kept open as long as a reference is held.  When userspace closes it (be
that because the program has exited, been killed, etc) you can drop any
pending references.
