From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/11] OMAP3: PM: Ensure MUSB block can idle when
	driver not loaded
Date: Mon, 18 May 2009 08:04:24 -0700
Message-ID: <20090518150423.GP19742@atomide.com>
References: <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com> <20090518131611.GG3067@n2100.arm.linux.org.uk> <87fxf2bh3b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59884 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZERPEg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 11:04:36 -0400
Content-Disposition: inline
In-Reply-To: <87fxf2bh3b.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

* Kevin Hilman <khilman@deeprootsystems.com> [090518 07:50]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Fri, May 15, 2009 at 11:40:48AM -0700, Kevin Hilman wrote:
> >> Otherwise, bootloaders may leave MUSB in a state which prevents
> >> retention.
> >
> > Hmm, so what happens if a boot loader has touched this MUSB thing, but
> > the kernel which is being run doesn't have CONFIG_USB_MUSB_SOC enabled?
> 
> Then the OMAP will not be able to hit retention.
> 
> That Makefile change happened after this series was initially made.
> I think we should change the Makefile back to always compile usb-musb.c
> and move the #ifdef CONFIG_USB_MUSB_SOC into usb-musb.c
> 
> Tony, any objections?

Sounds good to me, I like patches that make things behave in a predictable
way.

We already have enough of these mysterious problems where "the same kernel
behaves in a different way on my board" when some registers are only
tweaked in the bootloader.

Regards,

Tony
