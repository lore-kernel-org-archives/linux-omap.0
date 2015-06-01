From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Mon, 1 Jun 2015 10:12:09 -0700
Message-ID: <20150601171209.GW30984@atomide.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
 <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
 <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55089 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbFARMM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 13:12:12 -0400
Content-Disposition: inline
In-Reply-To: <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

* Robert Nelson <robertcnelson@gmail.com> [150531 19:20]:
> On Sun, May 31, 2015 at 7:20 PM, Matthijs van Duin
> <matthijsvanduin@gmail.com> wrote:
> > Sorry for the late response, I only just noticed this since I wasn't CC'd.
> >
> > This "fix" was not ever Reported-By or Tested-By me as it claims. It
> > is in fact wrong: &rtc { system-power-controller; } needs to be
> > present for every variety of beaglebone (more generally every design
> > with a TPS65217 whose PWR_EN is connected to the PMIC_POWER_EN pin of
> > an AM335x).
> >
> > Without a system-power-controller, the kernel has no way of turning
> > off the system and shutdown will leave the system halted instead.
> >
> > The previously posted fix, which added  &tps {
> > ti,pmic-shutdown-controller; }  was correct, and ensures that a
> > poweroff makes the pmic enter "OFF-state" rather than "SLEEP-state"
> > (aka RTC-only sleep).
> 
> Sorry Matthijs, (and everyone else)
> 
> That's my fault for completely screwing up this patch..

Hmm OK. So do we now have a situation in the mainline that can
potentially cause hardware damage?

It seems we don't need to revert anything, just apply Matthijs'
new patch?

Regards,

Tony
