From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
Date: Mon, 16 May 2011 09:56:18 +0200
Message-ID: <20110516075618.GC2429@pengutronix.de>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60475 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1EPH4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 03:56:23 -0400
Content-Disposition: inline
In-Reply-To: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Vladimir,

On Mon, May 16, 2011 at 12:45:56AM +0300, Vladimir Zapolskiy wrote:
> This change shows a possibility to utilize C preprocessor to remove
> redundant data from clock definitions for OMAP4 architecture.
> 
> If the change is evaluated as a positive one, the same approach could
> be applied in reducing LOCs from other files, which contain monotonous
> data enumeration.
> 
> Vladimir Zapolskiy (2):
>   OMAP4: clock data: shrink clock data utilizing preprocessor.
>   OMAP4: clock data: shrink more clock data.
> 
>  arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>  1 files changed, 848 insertions(+), 2465 deletions(-)

While the diffstat shows a huge saving in loc I suggest to delay this
until we have common clock code merged so that we don't have to
completely rework these files again in the near future.

This has been said before, I just wanted to add my +1 on this opinion.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
