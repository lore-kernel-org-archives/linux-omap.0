From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings
 in OFF mode
Date: Mon, 21 May 2012 12:01:18 +0300
Message-ID: <1337590878.28274.0.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
	 <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
	 <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
	 <87mx56227d.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43602 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2EUJBc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:01:32 -0400
In-Reply-To: <87mx56227d.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

On Thu, 2012-05-17 at 09:37 -0700, Kevin Hilman wrote:
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> > On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
> > <santosh.shilimkar@ti.com> wrote:
> >> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> >>> Tero Kristo <t-kristo@ti.com> writes:
> >>>
> >>>> From: Rajendra Nayak <rnayak@ti.com>
> >>>>
> >>>> SAR/ROM code restores only CORE DPLL to its original state
> >>>> post wakeup from OFF mode.
> >>>> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
> >>>> are saved and restored here during an OFF transition.
> >>>>
> >>>> [nm@ti.com: minor cleanups]
> >>>> Signed-off-by: Nishanth Menon <nm@ti.com>
> >>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>>
> >>> Some general comments:
> >>>
> >>> - the register dump/print doesn't belong here.  If needed, should be a
> >>>  debug feature if needed.
> >>>
> >>> - Rather than hooking into omap4_enter_lowpower(), should use
> >>>  the cluster PM enter/exit notifier chain.
> >>>
> >> This is again specific to device OFF only and not related to CPU
> >> cluster state as such. So I don't think notifiers should be used here.
> >>
> >> O.w even when we attempt just MPU OSWR C-state, all these functions will
> >> get called in notifier chain.
> >>
> > Just a thought, we can have a separate notifier chain for device OFF. It can
> > allow use to get rid of 'enable_off_mode" kind of flags and can be
> > used by many drivers too.
> 
> Yes, I like this idea.
> 
> It allows a much cleaner collection of all the activities needed for
> device off.

I can just read the device next state off in the notifier func.

-Tero


