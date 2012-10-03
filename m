From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP4460/PandaES: hang during resume
Date: Wed, 3 Oct 2012 13:33:04 +0530
Message-ID: <CAMQu2gy7jdsiEenoE_GkpHRj2CGoySMS7LCo-PrfN-76hn02Vg@mail.gmail.com>
References: <87txuc4fd1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:47239 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755740Ab2JCID0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 04:03:26 -0400
Received: by vcbfo13 with SMTP id fo13so7923510vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 01:03:25 -0700 (PDT)
In-Reply-To: <87txuc4fd1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Oct 3, 2012 at 5:05 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Santosh, Tero,
>
> I just added my 4460/PandaES to my board farm for automated PM testing
> and see that basic suspend/resume tests don't work in mainline.  It
> fails on v3.6 and linux-next,arm-soc/for-next.
>
> Adding 'no_console_suspend' to the cmdline shows me that wakeup event is
> happening so the hang is somewhere during resume.  I haven't dug any
> deeper than that.
>
> This works fine on 4430/Panda.  Do you know of anything else we're
> missing in mainline for a basic suspend/resume test on 4430?
>
OMAP4460 has one ROM code BUG which impacts MPUSS OSWR.
I suspect you are missing that Errata WA.
You need a patch [1] which is in Tero's CORE RET series.

Regards
Santosh

[1] https://patchwork.kernel.org/patch/1216671/
