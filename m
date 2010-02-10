From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: hsmmc: fix memory leak
Date: Wed, 10 Feb 2010 09:21:31 -0800
Message-ID: <20100210172131.GS21755@atomide.com>
References: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
 <1265808491.2006.226.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0BJRU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 12:20:56 -0500
Content-Disposition: inline
In-Reply-To: <1265808491.2006.226.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, jarkko.lavinen@nokia.com

* Artem Bityutskiy <dedekind1@gmail.com> [100210 05:26]:
> On Mon, 2010-02-08 at 14:33 +0200, Aaro Koskinen wrote:
> > The platform data allocated with kmalloc() will become unreachable once
> > the init is complete, so it should be freed. The problem was discovered
> > by kmemleak.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> You forgot to add:
> 
> Acked-by: Adrian Hunter <adrian.hunter@nokia.com>

Thanks, I'll add that.

Tony
