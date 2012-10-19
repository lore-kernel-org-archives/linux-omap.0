From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: Updated status of the removal of plat headers
Date: Fri, 19 Oct 2012 12:43:44 -0500
Message-ID: <CALLhW=4nx83M2uuyQB9mq0Eu4Po6yOhoG7M_ozJqMa_WSLwZuQ@mail.gmail.com>
References: <20121016230040.GP15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43327 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab2JSRnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 13:43:45 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so754742vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 10:43:45 -0700 (PDT)
In-Reply-To: <20121016230040.GP15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On 16 October 2012 18:00, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Here's a quick status update on the removal of remaining
> #include <plat/*.h> files. Most files are now fixed up, and
> we only have the following remaining:
>
> cpu.h           wrapper only left, will be removed as soon as drivers are fixed
>
> dmtimer.h       Jon is fixing this
>
> mailbox.h       Omar, are you fixing this?

Yes, I'm taking this.

Regards,

Omar
