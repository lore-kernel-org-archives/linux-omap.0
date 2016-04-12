From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-baltos-ir5221: use dedicated RTS/CTS
 signals
Date: Tue, 12 Apr 2016 14:17:03 -0700
Message-ID: <20160412211703.GG5995@atomide.com>
References: <1459246088-17768-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459246088-17768-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [160329 03:10]:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> Before "tty: Add software emulated RS485 support for 8250" patch Baltos devices
> relied on MCTRL_GPIO framework to handle both modem signals and RS485 mode.
> 
> With emulated RS485 support for 8250 we can now use these pins as dedicated
> RTS/CTS signals taking advantage of hardware flow control etc. when operating
> in RS232 mode.

Applying into omap-for-v4.7/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
