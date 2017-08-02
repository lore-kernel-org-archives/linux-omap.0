From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: restrict MCTRL initialization
Date: Wed, 2 Aug 2017 08:19:54 +0200
Message-ID: <20170802061954.mhd3hkmmm4wukhu3@pengutronix.de>
References: <1501485203-13185-1-git-send-email-yegorslists@googlemail.com>
 <1501485203-13185-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501485203-13185-2-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Yegor,

On Mon, Jul 31, 2017 at 09:13:21AM +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> GPIOs specified for serial port can be used either as GPIO driven MCTRL
> or as a wakeup-source. Use the latter property to abort the MCTRL
> initialization.
> 
> Return -ENOSYS as this would just skip mctrl initialization in the
> case of wakeup source usage and not disable the port completely due to
> failed serial8250_register_8250_port().
> 
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Did I miss the explanation in the last round why this is necessary? You
write "can be used either as GPIO driven MCTRL or as a wakeup-source",
I wonder why there is a conflict.

Can you show a dt that makes problems and describe it. I would guess
either your dt being broken or you want to extend mctrl-gpio instead of
restrict it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
