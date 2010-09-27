From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 27 Sep 2010 13:06:48 -0700
Message-ID: <20100927200647.GA4211@atomide.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <1285319748-28976-2-git-send-email-b-cousson@ti.com>
 <20100925002228.GP4211@atomide.com>
 <20100927154611.GT4211@atomide.com>
 <4CA0D33C.303@ti.com>
 <20100927173604.GY4211@atomide.com>
 <4CA0F883.3030302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60571 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927Ab0I0UGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 16:06:42 -0400
Content-Disposition: inline
In-Reply-To: <4CA0F883.3030302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [100927 12:54]:
>
> >OK cool, let me know if I can help with something.
> 
> Thanks, but that should be fine for moment. I think I should have
> the updated version before the end of the week.

OK
 
> Just one clarification, I don't think we have to use two different
> macros in that case. The names are already unique across partition
> today, so we can use only macro like for previous OMAP.

OK
 
> I'm just glad I don't have to re-write these 231 entries per ES manually :-)

:)
 
> I'll give it a try, and keep you inform if I have any un-expected
> issue with that approach.

OK

Tony
