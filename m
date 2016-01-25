From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH repost] arm: plat-omap: Add PWM dmtimer platform data
 quirks
Date: Mon, 25 Jan 2016 10:08:30 -0800
Message-ID: <20160125180829.GV19432@atomide.com>
References: <20151130183707.GK2517@atomide.com>
 <1453479351-21825-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453479351-21825-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [160122 08:16]:
> In order to set the currently platform dependent dmtimer
> functions pointers as platform data for the pwm-omap-dmtimer
> platform driver, add it to plat-omap auxdata_lookup table.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> Tony, Thierry,
> 
> The previous patches are now upstream, here is a repost of the patch re-tested
> against mainline.
> 
> Ref: http://lkml.kernel.org/r/56374592.4060201@baylibre.com 
> Patchset: http://lkml.kernel.org/r/5620ED2C.1090107@baylibre.com

OK great. I'll add this into omap-for-v4.5/fixes so we get the
PWM driver working.

Regards,

Tony
