From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.12-rc3
Date: Wed, 9 Oct 2013 14:26:24 -0700
Message-ID: <20131009212624.GG8313@atomide.com>
References: <20131008220324.GV8313@atomide.com>
 <87d2netbvh.fsf@linaro.org>
 <20131009205127.GF8313@atomide.com>
 <CAGa+x85i5OXA2cNEAT+hZC-c01xq8ZwTbb4kse=Vw9pS6_i1Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34745 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3JIV0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 17:26:31 -0400
Content-Disposition: inline
In-Reply-To: <CAGa+x85i5OXA2cNEAT+hZC-c01xq8ZwTbb4kse=Vw9pS6_i1Rw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@linaro.org> [131009 14:17]:
> On Wed, Oct 9, 2013 at 1:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Kevin Hilman <khilman@linaro.org> [131009 13:50]:
> >>
> >> FWIW, my automated boot is doing only DT boots on all the OMAP
> >> platforms.  However, it's only testing basic boot so far so there's not
> >> a whole lot of driver testing yet (but it's coming soon.)
> >
> > OK cool. For omap3, off-idle with DT needs the pending
> > pinctrl-single patches, and some yet unknown way of mapping
> > wake-up events to device interrupts. But after that you
> > can also do some PM related tests potentially :)
> 
> Yeah, a review/test of that series is already my TODO list.

Thanks, I would appreciate it if you could give it a quick try
so we can make sure it does not cause regressions for the
legacy booting.

For the DT based booting, you need to currently seprately
do a request_irq on the wake-up interrupts, I have a test
driver that does that that I can email to you if you need
it.

Regards,

Tony
