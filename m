From: Tony Lindgren <tony@atomide.com>
Subject: Re: dspgateway linux-omap branch
Date: Mon, 2 Feb 2009 12:07:44 -0800
Message-ID: <20090202200741.GU7215@atomide.com>
References: <200902020151.12822.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49483 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbZBBUHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 15:07:48 -0500
Content-Disposition: inline
In-Reply-To: <200902020151.12822.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-omap@vger.kernel.org, dspgateway-devel@lists.sourceforge.net

* Siarhei Siamashka <siarhei.siamashka@gmail.com> [090201 15:51]:
> Hello all,
> 
> I wonder about the status of dspgateway branch.
> It does not compile cleanly for n770_defconfig confuguration. Applying patches
> 'USB: omap1 ohci buildfix (otg related)',
> 'drivers/usb/core/hub.c: fix CONFIG_USB_OTG=y build' and
> 'ARM: OMAP: Remove unused platform devices, v3'
> makes it compile, but the resulting kernel does not boot on Nokia 770.
> 
> The same boot problem also affects 'origin/omap-fixes' branch.
> 
> Git HEAD seems to compile and boot fine on Nokia 770, and dspgateway patch can
> be applied to it. But unfortunately 'demo_console' test application does not
> work (dsp task gets loaded or is at least reported to be loaded,
> but 'demo_console' arm side program gets stuck and does not show anything).
> 
> The last kernel version which has dspgateway in more or less working on Nokia
> 770 seems to be 2.6.27-omap1 (aic23 and sound related stuff has problems, but
> can be disabled). Maybe some of the more recent kernels are fine too, but I
> did not find the exact point where it got broken yet.
> 
> Are there any ideas how to bring dspgateway branch into a better shape?

Sounds like these should get fixed if I rebase it onto something else.
Any preferences onto which commit to rebase it on?

Or if you or somebody is interested in maintaining a git branch for the
dspgateway patches, I can just mirror it in the linux-omap tree.

Regards,

Tony
