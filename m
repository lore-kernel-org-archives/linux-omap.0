From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] omap: Fix linker error in
 drivers/video/omap/lcd_2430sdp.c
Date: Mon, 28 Feb 2011 17:39:28 -0800
Message-ID: <20110301013928.GL20560@atomide.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
 <1298232248-347-1-git-send-email-jhnikula@gmail.com>
 <20110224212644.GN20560@atomide.com>
 <20110228164715.e34a965e.jhnikula@gmail.com>
 <1298905757.9809.135.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18178 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab1CABjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 20:39:36 -0500
Content-Disposition: inline
In-Reply-To: <1298905757.9809.135.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110228 07:07]:
> 
> Well, it's a bit ugly, but I'm fine with it. It's for the old omapfb,
> which hopefully nobody uses anymore (right =), and there's no simple way
> to make it modular and neat.

How about let's make mach-omap2 boards all use the new code?
That way the old code can be omap1 only.

Regards,

Tony
