From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Thu, 28 May 2009 14:43:03 +0100
Message-ID: <20090528134303.GA20736@n2100.arm.linux.org.uk>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <20090518133241.GH3067@n2100.arm.linux.org.uk> <87my9a8hxf.fsf@deeprootsystems.com> <20090518170656.GJ7042@n2100.arm.linux.org.uk> <87r5yk6hxu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55145 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZE1NnN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 09:43:13 -0400
Content-Disposition: inline
In-Reply-To: <87r5yk6hxu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Tue, May 19, 2009 at 11:55:41AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Mon, May 18, 2009 at 10:00:44AM -0700, Kevin Hilman wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
> >> >> This patch is to sync the core linux-omap PM code with mainline.  This
> >> >> code has evolved and been used for a while the linux-omap tree, but
> >> >> the attempt here is to finally get this into mainline.
> >> >> 
> >> >> Following this will be a series of patches from the 'PM branch' of the
> >> >> linux-omap tree to add full PM hardware support from the linux-omap
> >> >> tree.
> >> >> 
> >> >> Much of this PM core code was written by Jouni Hogander with
> >> >> significant contributions from Paul Walmsley as well as many others
> >> >> from Nokia, Texas Instruments and linux-omap community.
> >> >
> >> > Overall comment, I think we need to rework the idle support code so
> >> > that enable_hlt/disable_hlt can be used even when pm_idle has been
> >> > overridden, rather than OMAP going off and inventing its own mechanisms.
> >> 
> >> Would adding:
> >> 
> >> 	if (hlt_counter)
> >> 		cpu_relax();
> >> 
> >> to the beginning of omap*_pm_idle functions be sufficient?  That will
> >> at least allow the hlt stuff to behave as expected.
> >
> > Yes, but the comment was also directed at the other functions which
> > increment/decrement that atomic_t variable to enable/disable sleep mode.
> >
> 
> Russell,
> 
> Do you have a preference in how to export the hlt_counter to
> platform-specific code?

Sorry, I haven't had time to look at this, and the work I did to change
the idle loop got lost when I last re-built my git tree.

But... your patch isn't what I was meaning.  I was meaning to avoid
calling the idle function (_any_ idle function) if hlt_counter was
non-zero.
