From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Wed, 23 Feb 2011 14:58:18 -0800
Message-ID: <20110223225817.GD30316@atomide.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
 <4D50FF42.1070401@ti.com>
 <4D5F33E3.7000501@ti.com>
 <20110219053111.GA6991@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43255 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab1BWW6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 17:58:23 -0500
Content-Disposition: inline
In-Reply-To: <20110219053111.GA6991@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [110218 21:29]:
> Hi Shubhrajyoti,
> 
> On Sat, Feb 19, 2011 at 08:37:15AM +0530, Shubhrajyoti wrote:
> > Hello Dmitry,
> > If there are no further comments.
> > Can it be queued?
> 
> I normally try not to merge board code leaving it to arch owner. Can we
> at least get arch/board maintainer ACKs on this?

The omap4 hwmod data should be now queued so that patch needs
to be refreshed to just uncomment omap44xx_kbd_hwmod entry
in what we have queued up in the omap tree.

To avoid conflicts there it's probably best that I take the
arch/arm/*omap*/* patches.

Patch 3/3 should not do anything until the hwmod changes
are merged, so Dmitry can you please take that one?

Regards,

Tony
