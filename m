From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding information
Date: Wed, 8 Jan 2014 17:18:45 +0530
Message-ID: <52CD3B1D.5080203@ti.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com> <3761842.HRY1CDBF4z@wuerfel> <52CD324D.3020701@ti.com> <201401081235.40927.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401081235.40927.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, "Kristo, Tero" <t-kristo-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/08/2014 05:05 PM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, Roger Quadros wrote:
>> OK. I'll update the binding information to reflect all the clocks.
>>
>> But what about clk_get() vs of_clk_get_by_name() ?
> 
> I think the convention these days is to just use clk_get(), which calls
> of_clk_get_by_name() internally. Not sure if that's what you are asking.
>

OK fine. I'll continue to use clk_get() then.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
