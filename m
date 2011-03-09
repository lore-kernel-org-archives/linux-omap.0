From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap: overo: Add regulator for ads7846
Date: Wed, 9 Mar 2011 07:56:21 +0200
Message-ID: <1299650181.2151.0.camel@deskari>
References: <1299341546-17289-1-git-send-email-steve@sakoman.com>
	 <20110308231615.GH26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab1CIF42 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 00:56:28 -0500
In-Reply-To: <20110308231615.GH26463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <steve@sakoman.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-08 at 17:16 -0600, Tony Lindgren wrote:
> * Steve Sakoman <steve@sakoman.com> [110305 08:10]:
> > The ads7846 driver now requires a regulator.  This patch adds the
> > necessary regulator to the overo board file.  Without it, the
> > following error occurs (and the touchscreen will not function):
> > 
> > ads7846 spi1.0: unable to get regulator: -19
> > 
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> > Note: this patch should be applied after the "[PATCH v3 0/2] Add DSS2
> > support on Overo" series.
> 
> Tomi can you please take this one to avoid merge conflicts?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Yes, I can take this. It depends on the Overo board patches in my tree.

 Tomi


