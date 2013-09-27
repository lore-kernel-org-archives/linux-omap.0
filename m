From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio/omap: maintain GPIO and IRQ usage separately
Date: Fri, 27 Sep 2013 11:08:43 -0700
Message-ID: <87r4cajfx0.fsf@linaro.org>
References: <1380069414-2922-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380069414-2922-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
	(Javier Martinez Canillas's message of "Wed, 25 Sep 2013 02:36:52
	+0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> writes:

> The GPIO OMAP controller pins can be used as IRQ and GPIO
> independently so is necessary to keep track GPIO pins and
> IRQ lines usage separately to make sure that the bank will
> always be enabled while being used.
>
> Also move gpio_is_input() definition in preparation for the
> next patch that setups the controller's irq_chip driver when
> a caller requests an interrupt line.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

I'm fine with this appproach.  For both patches:

Reviewed-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Also, I gave it a spin across a handful of OMAP boards using v3.12-rc2 +
these 2 patches.

Boot tested successfully with DT boot:

omap3530/beagle
omap3730/beagle-xm
omap3530/overo (Tobi w/GPIO IRQ networking)
omap3730/overo STORM (w/GPIO IRQ for networking)
am335x/beaglebone
am335x/beaglebone black
omap4430/panda
omap4460/panda-es
omap5912/OSK (omap1)

I also verified non-DT boot on the OMAP3 platforms that still support
legacy boot.

So feel free to also add

Tested-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks for your persistence in getting a fix for this upstream.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
