From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic
 board
Date: Mon, 26 Sep 2011 14:37:51 -0700
Message-ID: <20110926213750.GG6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-8-git-send-email-b-cousson@ti.com>
 <20110923230845.GD6324@atomide.com>
 <4E80717A.3040502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752329Ab1IZVhz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 17:37:55 -0400
Content-Disposition: inline
In-Reply-To: <4E80717A.3040502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

* Cousson, Benoit <b-cousson@ti.com> [110926 05:01]:
> On 9/24/2011 1:08 AM, Tony Lindgren wrote:
> >* Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
> >>Re-cycle the original board-generic file to support Device Tree
> >>for every OMAP2+ variants.
> >>Note: Since it is a completely new content in the existing file
> >>I removed the original copyright.
> >
> >I'd suggest just keeping it, maybe just update the comments
> >accordingly?
> 
> Do you mean keeping it and adding the comment? Or removing it and
> adding the comment?

Maybe just update the comment accordingly for DT?
 
> >That's because Copyrights in general just don't "disappear".
> 
> OK, maybe, but I thought it is weird to keep an old copyright just
> because we re-use an already existing file since the content is
> different.

Yeah.. But it's still a good idea not to mess with the copyrights
as as you would need permissions from the copyright holders.

Regards,

Tony
