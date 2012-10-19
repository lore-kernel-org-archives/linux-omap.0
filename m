From: Tony Lindgren <tony@atomide.com>
Subject: Re: Updated status of the removal of plat headers
Date: Fri, 19 Oct 2012 11:25:42 -0700
Message-ID: <20121019182542.GQ4730@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <CALLhW=4nx83M2uuyQB9mq0Eu4Po6yOhoG7M_ozJqMa_WSLwZuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31778 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750945Ab2JSSZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 14:25:45 -0400
Content-Disposition: inline
In-Reply-To: <CALLhW=4nx83M2uuyQB9mq0Eu4Po6yOhoG7M_ozJqMa_WSLwZuQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Omar Ramirez Luna <omar.luna@linaro.org> [121019 10:45]:
> Hi,
> 
> On 16 October 2012 18:00, Tony Lindgren <tony@atomide.com> wrote:
> > Hi all,
> >
> > Here's a quick status update on the removal of remaining
> > #include <plat/*.h> files. Most files are now fixed up, and
> > we only have the following remaining:
> >
> > cpu.h           wrapper only left, will be removed as soon as drivers are fixed
> >
> > dmtimer.h       Jon is fixing this
> >
> > mailbox.h       Omar, are you fixing this?
> 
> Yes, I'm taking this.

OK thanks, a patch against v3.7-rc1 is preferred in case some
driver branches need it too.

Regards,

Tony
