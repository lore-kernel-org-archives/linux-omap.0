From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Tue, 13 Jan 2009 12:06:40 +0200
Message-ID: <20090113100633.GA7344@atomide.com>
References: <1231837724.13843.128.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60177 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZAMKGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 05:06:43 -0500
Content-Disposition: inline
In-Reply-To: <1231837724.13843.128.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

* Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090113 11:11]:
> > Can you please repost your first version of the patch?
> 
> Please. This V1 patch is good if one wishes to provide the fclk
> for McBSP from the MCBSP_CLKS. Then the fclk from the per can be turned
> off. With the V2 patch it's not that straightforward at all.

I guess the V1 patch is the one at:

http://marc.info/?l=linux-omap&m=122588610400970&w=2

But it needs to be refreshed to apply so let's wait for Stanley to
repost it.

Tony

