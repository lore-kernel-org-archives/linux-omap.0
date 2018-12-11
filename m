From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: fix USB configuration for device-only setups
Date: Tue, 11 Dec 2018 08:17:52 -0800
Message-ID: <20181211161752.GR6707@atomide.com>
References: <20181204175742.2634-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204175742.2634-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181204 09:58]:
> Currently we do USB configuration only if the host mode (CONFIG_USB)
> is enabled. But it should be done also in the case of device-only setups,
> so change the condition to CONFIG_USB_SUPPORT. This allows to use
> omap_udc on Palm Tungsten E.

I'll apply this into omap-for-v4.21/omap1 as it seems that it's
been broken for ages :) Let me know if there is urgent need for
the -rc cycle.

Regards,

Tony
