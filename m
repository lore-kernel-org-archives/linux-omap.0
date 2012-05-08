From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4-alt 0/6] GPMC driver migrate one
Date: Tue, 8 May 2012 14:36:26 -0700
Message-ID: <20120508213625.GG5088@atomide.com>
References: <cover.1335941443.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2EHVg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:36:28 -0400
Content-Disposition: inline
In-Reply-To: <cover.1335941443.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org

* Afzal Mohammed <afzal@ti.com> [120502 02:05]:
> Hi Tony,
> 
> As you would have already seen, v4 of GPMC driver conversion has been
> posted (this is v4-alt). I undertand the risk involved in converting
> all board files to use new interface in a single patch series. But to
> have a decent set of patches, I feel this is required. But this may
> bring us to a point where GPMC may not work on some boards.
> 
> To resolve this and as per your earlier question on whether old along
> with new interface can be made to work parallely, here is suggestion
> from my end to deal with it.

I think this is the only way to keep this all building and booting
for each patch in the series, no? If so, then we should select this
option. The first patch should be broken up into more readable patches,
it seems that you can do that without breaking things.
 
> Please let me know whether you are fine in taking patch series
> as in v4 (that converts all boards at once, with further revisions
> based on review comments).

It seems that there are still some pending comments and we need to
have the hwmod entries merged first by Paul.

Regards,

Tony
