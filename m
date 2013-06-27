From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Thu, 27 Jun 2013 07:45:35 -0700
Message-ID: <20130627144535.GK5523@atomide.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
 <20130625065811.GZ5523@atomide.com>
 <51CAEA90.90200@ti.com>
 <CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
 <51CC45D3.2000305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51CC45D3.2000305@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@linaro.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130627 07:12]:
> 
> As you can see, from 12 pins only 3 pins need to be reconfigured
> while switching from "active"->"idle" states and back (and as I
> mentioned above for OMAP "idle" == "sleep" now).
> 
> Regarding "OFF" state:
> OMAP mux HW defines special state for unused pins which is selected
> by default after reset and need to be selected when device isn't
> used, for example:
> _MUXMODE - Functional multiplexing selection for pad
> 0x0: Select usbb1_hsic_data
> 0x3: Select gpio_96
> 0x7: Select safe_mode <<--- pin unused

The off mode bits can be enabled continuously, the mux hardware
automatically sets them. So sounds like you don't need any
separate "idle" "sleep" and "off" states, the following should
do:

"default" (or "static")	static pins that don't need to be touched
			after consumer driver probe

"active"		dynamic pins that are not a subset of
			"default" needed for runtime; these pins
			are the same as "idle" below, but with
			different muxing or pinconf device
			runtime

"idle"			dynamic pins that are not a subset of
			"default" needed for various idle modes;
			these pins are the same as "active" above,
			but with different muxing or pinconf for
			various idle states

Can you please confirm that these named modes are enough for
your needs?

If your hardware does not have specific off mode bits, then
I can understand that you may need one mor state "off".

Regards,

Tony
