From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Thu, 10 Oct 2013 09:20:15 -0700
Message-ID: <20131010162015.GC29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [131010 09:19]:
> On Thu, Oct 10, 2013 at 6:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Roger Quadros <rogerq@ti.com> [131010 06:32]:
> >>
> >> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
> >> while the system is still running and only the EHCI controller is runtime suspended.
> >>
> >> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
> >> whenever the pad wakeup_enable bit is changed.
> >
> > Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
> > pcs_irq_handle() like the comments there suggest? At least for me that keeps
> > the wake-up interrupts continuously running on omap3 instead of just idle modes.
> 
> If the rearm() function is calling this _reconfigure_io_chain my comments
> on the fact that this is something that should be handled by the pin
> control driver still apply I think ....

Yes, except that the reconfigure_io_chain registers are in the PRM module, not in
the SCM module where the pinctrl registers are.. And that shared PRM interrupt is
used mostly for the internal domain wake-ups, so we should keep that in the PRM
driver.

Regards,

Tony
