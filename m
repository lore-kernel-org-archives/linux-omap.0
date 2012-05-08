From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/3] omap: mailbox: enable mailbox irq per instance
Date: Tue, 8 May 2012 12:43:41 +0300
Message-ID: <CAK=WgbZBMtn57uHn33OAK_EQizCfiXe2nVHx-4g22vJ7t7DC5Q@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-2-git-send-email-jgutierrez@ti.com> <CAK=WgbY3OaDH9ziavrXG4oM1ztO3mTmL_eoLPOzCHHKQpHn20w@mail.gmail.com>
 <CADVn9RHc4b+hLth5j-1Jr+dv2ePB8W1pGAgQiBSgFKuDycG8pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33995 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab2EHJoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 05:44:03 -0400
Received: by yhmm54 with SMTP id m54so5102810yhm.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 02:44:03 -0700 (PDT)
In-Reply-To: <CADVn9RHc4b+hLth5j-1Jr+dv2ePB8W1pGAgQiBSgFKuDycG8pA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gutierrez, Juan" <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Juan,

On Tue, May 8, 2012 at 1:09 AM, Gutierrez, Juan <jgutierrez@ti.com> wrote:
> Startup it is now only used to enable pm runtime of the whole mbox module.

Btw I really doubt we need to do that in a machine-specific handler,
or whether we really need this startup/shutdown abstraction at all.
But that's not related to your patch of course...

> I think, if request_irq is called from the generic layer, it is kind
> of logical to enable_irq next to it.

I somewhat agree, though I was wondering about the implications for
OMAP1, which didn't seem to enable_irq at startup at all. Not sure
there's much to do here (unless you have some OMAP1 hardware ? :).

Thanks,
Ohad.
