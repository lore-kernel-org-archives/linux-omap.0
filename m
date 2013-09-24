From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC v2] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 08:58:08 -0700
Message-ID: <20130924155808.GP2684@atomide.com>
References: <1380009480-4975-1-git-send-email-javier.martinez@collabora.co.uk>
 <20130924154048.GM2684@atomide.com>
 <5241B3B7.5070701@ti.com>
 <5241B465.5050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5241B465.5050604-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org> [130924 08:56]:
> On Tuesday 24 September 2013 11:45 AM, Balaji T K wrote:
> > On Tuesday 24 September 2013 09:10 PM, Tony Lindgren wrote:
> >> * Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [130924 01:06]:
> >>> The OMAP GPIO controller HW requires a pin to be configured in GPIO
> >>> input mode in order to operate as an interrupt input. Since drivers
> >>> should not be aware of whether an interrupt pin is also a GPIO or not,
> >>> the HW should be fully configured/enabled as an IRQ if a driver solely
> >>> uses IRQ APIs such as request_irq(), and never calls any GPIO-related
> >>> APIs. As such, add the missing HW setup to the OMAP GPIO controller's
> >>> irq_chip driver.
> >>>
> >>> Since this bypasses the GPIO subsystem we have to ensure that another
> >>> caller won't be able to request the same GPIO pin that is used as an
> >>> IRQ and set its direction as output. Requesting the GPIO and setting
> >>> its direction as input is allowed though.
> >>
> >> Also please mention the regression that this fixes. So far we know
> >> that smsc911x for tobi and igep boards in mainline, and also the
> > 
> >> MMC card detect for omap4 boards.
> > Hi Tony,
> > 
> > Card detect on omap4 board (sdp and panda) is not based on omap gpio,
> > so I think this fix is not applicable for omap4.
> > 
> > Card detect line for SD card goes to power IC on OMAP4 panda and SDP.
> > 
> I confused Tony mostly. It was OMAP4 SPI based ethernet which uses the
> GPIO as an interrupt line.
> 
> So for Panda, its Ethernet driver and not MMC.

OK :) Thanks for clarifying.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
