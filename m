From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Date: Wed, 23 Mar 2011 09:46:02 +0200
Message-ID: <1300866362.2613.5.camel@deskari>
References: <1300701083.2891.77.camel@deskari>
	 <AANLkTimSoaxGhjbgMx6b3duAV75HwO0S+=1mJhOnEvvD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab1CWHqM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 03:46:12 -0400
In-Reply-To: <AANLkTimSoaxGhjbgMx6b3duAV75HwO0S+=1mJhOnEvvD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-22 at 13:49 -0500, Felipe Contreras wrote:
> On Mon, Mar 21, 2011 at 11:51 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Here are OMAP display subsystem patches for 2.6.39 merge window. Quite a
> > bit of them, and many changes also in arch/arm/mach-omap2, which
> > unfortunately couldn't go through Tony's linux-omap tree due to
> > dependencies on DSS driver code.
> 
> What about this one?
> http://article.gmane.org/gmane.linux.ports.arm.omap/44975

I seem to have missed that one. But I think that should go through
Tony's tree to avoid conflicts. Tony?

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



