From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP MUX framework changes
Date: Thu, 18 Nov 2010 13:29:44 -0800
Message-ID: <20101118212944.GO9264@atomide.com>
References: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
 <20101118175714.GF9264@atomide.com>
 <4CE59443.3000401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38876 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab0KRV3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 16:29:51 -0500
Content-Disposition: inline
In-Reply-To: <4CE59443.3000401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Cousson, Benoit <b-cousson@ti.com> [101118 12:52]:
> Hi Tony,
> 
> On 11/18/2010 6:57 PM, Tony Lindgren wrote:
> >Hi Dan,
> 
> [...]
> 
> >Can you please make this into a separate patch. And instead of
> >indenting the code more, just do something like:
> >
> >	if (!partition)
> >		return -EINVAL;
> 
> Do you want me to merge that in my current OMAP4 series branch?

I got that already pulled, so I'd prefer not to touch that
branch any longer unless we have to. Sounds like this can
be a separate patch.

Regards,

Tony
