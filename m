From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] serial: mctrl_gpio: restrict MCTRL initialization
Date: Thu, 27 Jul 2017 17:55:44 +0300
Message-ID: <1501167344.29303.272.camel@linux.intel.com>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
         <1501161456-13367-2-git-send-email-yegorslists@googlemail.com>
         <20170727140008.myhk2w6mwxxinhyb@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727140008.myhk2w6mwxxinhyb-T6qyLwKrzP+Pq0V0m3QNwQq/OYV65a7L4Y2cMoPwMik@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2017-07-27 at 16:00 +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 27, 2017 at 03:17:34PM +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
> wrote:
> > GPIOs specified for serial port can be used either as GPIO driven
> > MCTRL
> > or as a wakeup-source. Use the latter property to abort the MCTRL
> > initialization.
> 
> Why is that an either-or and not an and?

That is how mctrl is designed right now.

Note marking the pin as a wakeup source inside mctrl driver will not
help since there is much bigger issue, i.e. pinctrl is not ready for a
such.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
