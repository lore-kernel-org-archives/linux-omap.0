From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH v6 7/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Wed, 23 Nov 2016 10:12:06 -0300
Message-ID: <cc450963-16f9-10e6-a8c4-3b4e4771248e@osg.samsung.com>
References: <cover.1477557860.git.hns@goldelico.com>
 <54f282e1adebeeb133687b6c430ecbb6f2fe6d5b.1477557860.git.hns@goldelico.com>
 <20161119181824.GB20446@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161119181824.GB20446@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel@pyra-handhel
List-Id: linux-omap@vger.kernel.org

Hello Dmitry,

On 11/19/2016 03:18 PM, Dmitry Torokhov wrote:
> On Thu, Oct 27, 2016 at 10:44:20AM +0200, H. Nikolaus Schaller wrote:
>> Fix module table so that the driver is loaded if compiled
>> as module and requested by DT.
> 
> We really need to fix it between spi/i23c core and module utils instead
> of keeping adding duplicate IDs all over drivers. We already have OF
> module device table containing the same data, we should be able to use
> it.
> 

Agreed, unfortunately until the I2C and SPI core are changed to properly
report OF modaliases, we will have to keep adding these duplicated IDs.

And changing the I2C and SPI core isn't trivial since it could break a
lot of drivers that rely on a platform modalias being reported (i.e: no
OF device IDs present in the drivers even when are registered via DT).

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
