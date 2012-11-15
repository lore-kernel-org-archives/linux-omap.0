From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
Date: Thu, 15 Nov 2012 14:43:23 -0800
Message-ID: <20121115224323.GD16377@kroah.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-8-git-send-email-jon-hunter@ti.com>
 <50A3BE85.5000804@ti.com>
 <CALLhW=5wiTd9u0PorwDH_68K7XRS8_ajDSDOLB7x8F2qvtJvaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:63347 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab2KOWn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 17:43:27 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so862386dak.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 14:43:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALLhW=5wiTd9u0PorwDH_68K7XRS8_ajDSDOLB7x8F2qvtJvaA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 15, 2012 at 02:42:13PM -0600, Omar Ramirez Luna wrote:
> Hi Jon,
> 
> On 14 November 2012 09:53, Jon Hunter <jon-hunter@ti.com> wrote:
> >> diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
> >> index 3d28b23..6aea6f1 100644
> >> --- a/drivers/staging/tidspbridge/core/ue_deh.c
> >> +++ b/drivers/staging/tidspbridge/core/ue_deh.c
> >> @@ -19,7 +19,6 @@
> >>
> >>  #include <linux/kernel.h>
> >>  #include <linux/interrupt.h>
> >> -#include <plat/dmtimer.h>
> >>
> >>  #include <dspbridge/dbdefs.h>
> >>  #include <dspbridge/dspdeh.h>
> >
> > Hi Omar, I should have had you in copy on this one. Are you ok with the
> > removal of the above dmtimer.h include? It does not appear that this
> > file needs to include dmtimer.h.
> 
> Indeed, we don't use it here.
> 
> > Is it ok for this to go through Tony's tree? If so, care to ACK?
> 
> Looks fine to me, but I believe you will want to let Greg know if this
> patch will bypass staging tree.

That's fine with me for such trivial stuff.

greg k-h
