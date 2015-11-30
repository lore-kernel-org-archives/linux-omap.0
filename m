From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
Date: Mon, 30 Nov 2015 09:59:04 -0800
Message-ID: <20151130175903.GG2517@atomide.com>
References: <5637458D.60106@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5637458D.60106@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [151102 03:14]:
> Adds support for using a OMAP dual-mode timer with PWM capability
> as a Linux PWM device. The driver controls the timer by using the
> dmtimer API.
> 
> Add a platform_data structure for each pwm-omap-dmtimer nodes containing
> the dmtimers functions in order to get driver not rely on platform
> specific functions.
> 
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>

Thierry, seems you can pick this driver patch separately if no more
comments, I'll pick up the other two patches in this series.

Regards,

Tony
