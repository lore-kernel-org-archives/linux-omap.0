From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 0/8] staging: tidspbridge - misc fixes
Date: Tue, 26 Oct 2010 17:43:34 +0300
Message-ID: <1288103059-notmuch-felipe.contreras@nokia.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com> <20101026040619.GA8549@suse.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18915 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960Ab0JZOnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 10:43:53 -0400
In-Reply-To: <20101026040619.GA8549@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@suse.de, x0095840@ti.com
Cc: hiroshi.doyu@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

gregkh@suse.de wrote:
> On Mon, Oct 25, 2010 at 07:51:38PM -0500, Fernando Guzman Lugo wrote:
> > This set of patches fix some issues found in lastest tree.
> > 
> > Fernando Guzman Lugo (8):
> >   staging: tidspbridge - remove req_addr from proc_map
> >   staging: tidspbridge - add kconfig parameter for DMM size
> >   staging: tidspbridge - change mmufault tasklet to a workqueue
> >   staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
> >   staging: tidspbridge - use GTP7 for DSP stack dump
> >   staging: tidspbridge - remove disabling twl when printing DSP stack
> >   staging: tidspbridge - fix some issues after iommu patches
> >   staging: tidspbridge - make sync_wait_on_event interruptible
> 
> Are any of these really applicable for .37 after .37-rc1?  Or can they
> wait for .38?

As of right now the dspbridge doesn't work, and there's a mess of
dependencies to get it working.

 - omap iommu: linux-omap pull request has already been sent, and
   there's no target when the omap iommu pull request will be sent...
   right Hiroshi?
 - linux-arm: some patches are needed, and it's not clear if they'll
   make it to .37-rc1, or .37 at all.

So, no, I don't think these patches should considered as of right now.

In fact, these affect mostly iommu, and I think until those other
dependencies are resolved, we should revert back to a previous point
where the driver was actually working.

What is guideline in staging when a driver is broken like this?

Cheers.

-- 
Felipe Contreras
