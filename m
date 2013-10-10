From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Thu, 10 Oct 2013 09:23:15 -0700
Message-ID: <20131010162314.GD29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131010160018.GA29913@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131010 09:09]:
> * Roger Quadros <rogerq@ti.com> [131010 06:32]:
> > 
> > I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
> > while the system is still running and only the EHCI controller is runtime suspended.
> > 
> > It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
> > whenever the pad wakeup_enable bit is changed.
> 
> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
> pcs_irq_handle() like the comments there suggest? At least for me that keeps
> the wake-up interrupts continuously running on omap3 instead of just idle modes.
> 
> Now on omap4, I've noticed the wake up interrupts are on all the time based on tests
> with the serial driver.

Oh, and if you're runtime suspending EHCI only, and if the EHCI module has
wake-up registers, it should be able to wake EHCI from retention on it's own
without a need for the io chain at all.

At least the serial driver does that if it's internal wake-up registers are
configured right. But for off-idle, the serial driver needs the io chain wake-up
events.

Regards,

Tony
