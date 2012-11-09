From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
Date: Fri, 9 Nov 2012 13:10:52 -0800
Message-ID: <20121109211052.GS6801@atomide.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
 <20121109162259.GO6801@atomide.com>
 <509D2F77.6090702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:23034 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752689Ab2KIVKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 16:10:55 -0500
Content-Disposition: inline
In-Reply-To: <509D2F77.6090702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121109 08:31]:
> 
> On 11/09/2012 10:22 AM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [121109 08:21]:
> >> If the header soc.h is included more than once in a source (for example
> >> once directly by the source file and once indirectly by another header
> >> file), then the compiler will generate redefintion errors for the macros
> >> in soc.h. Prevent this by only allowing the content in soc.h to be
> >> included once.
> >>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> >> ---
> >>
> >> Please note that I ran into this problem when rebasing my dmtimer fixes
> >> series [1] on Tony's Linux-OMAP master branch. I am including plat/cpu.h
> >> in dmtimer.h and I found several other files including dmtimer.h are also
> >> including soc.h and so generate a lot of errors.
> >>
> >> [1] http://marc.info/?l=linux-omap&m=135231490218361&w=2
> > 
> > As these headers are private to mach-omap2, I'd rather not allow including
> > them more than once so we can eventually clean up the includes further.
> > 
> > We should include the headers directly where used, except for the
> > legacy board-*.c files that will be going away anyways.
> > 
> > Including the files directly should fix this easily, if not let me
> > know.
> 
> The alternative fix is to ensure anyone including dmtimer.h also
> includes soc.h. However, I did not know if we should have such a
> dependency. If you are ok with that then that is what I will do for now.
> It is not a massive change.

Do you mean anything under mach-omap2/*.c including dmtimer.h also
needs to also include soc.h? If sounds OK to me as long as we don't
need to include soc.h outside mach-omap2.

Regards,

Tony
