From: Christ van Willegen <cvwillegen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v3 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Fri, 30 Sep 2016 18:23:14 +0200
Message-ID: <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ@mail.gmail.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

I saw this earlier, but didn't think it important to mention, but:


On Fri, Sep 23, 2016 at 2:41 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:

> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index 5d0cd51..9a11509 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c

> +                       /* scale ADC values to desired output range */
> +                       sx = (ts->prop.max_x * (tc.x - ts->min_x))
> +                               / (ts->max_x - ts->min_x);
> +                       sy = (ts->prop.max_y * (tc.y - ts->min_y))
> +                               / (ts->max_y - ts->min_y);
> +                       rt = (input->absinfo[ABS_PRESSURE].maximum * rt) /
> +                               ts->max_rt;

If ts->max_rt is zero, or ts->max_x == ts->min_x, or ts->max_y ==
ts->min_y, these yield a division by zero error.

Ofcourse, this is under control of the DT-maintainer(s) of the device
(if I'm not mistaking), but throwing an error on DT parse if (one of)
these condition(s) is met yields better info to the DT-maintainer than
a /0 error...

If you (or others) agree, could you add this to the patch?

Regards,

Christ van Willegen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
