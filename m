From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/11] OMAP3: PM: Ensure MUSB block can idle when driver not loaded
Date: Mon, 18 May 2009 07:50:32 -0700
Message-ID: <87fxf2bh3b.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
	<20090518131611.GG3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:53344 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZEROug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 10:50:36 -0400
Received: by pxi29 with SMTP id 29so1983167pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 07:50:37 -0700 (PDT)
In-Reply-To: <20090518131611.GG3067@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 14\:16\:11 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Tony Lindgren <tony@atomide.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, May 15, 2009 at 11:40:48AM -0700, Kevin Hilman wrote:
>> Otherwise, bootloaders may leave MUSB in a state which prevents
>> retention.
>
> Hmm, so what happens if a boot loader has touched this MUSB thing, but
> the kernel which is being run doesn't have CONFIG_USB_MUSB_SOC enabled?

Then the OMAP will not be able to hit retention.

That Makefile change happened after this series was initially made.
I think we should change the Makefile back to always compile usb-musb.c
and move the #ifdef CONFIG_USB_MUSB_SOC into usb-musb.c

Tony, any objections?

Kevin
