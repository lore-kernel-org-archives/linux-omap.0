From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 05/10] ARM: SAMSUNG: Initialize PWM backlight enable_gpio
 field
Date: Tue, 01 Oct 2013 14:58:22 -0600
Message-ID: <524B376E.6060507@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com> <1379972467-11243-6-git-send-email-treding@nvidia.com> <524B14E8.5040302@wwwdotorg.org> <20131001204335.GB9201@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131001204335.GB9201-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/01/2013 02:43 PM, Thierry Reding wrote:
> On Tue, Oct 01, 2013 at 12:31:04PM -0600, Stephen Warren wrote:
>> On 09/23/2013 03:41 PM, Thierry Reding wrote:
>>> The GPIO API defines 0 as being a valid GPIO number, so this
>>> field needs to be initialized explicitly.
>> 
>>> static void __init smdkv210_map_io(void)
>> 
>>> @@ -70,6 +70,7 @@ static struct samsung_bl_drvdata
>>> samsung_dfl_bl_data __initdata = { .max_brightness = 255, 
>>> .dft_brightness = 255, .pwm_period_ns  = 78770, +		.enable_gpio
>>> = -1, .init           = samsung_bl_init, .exit           =
>>> samsung_bl_exit, }, @@ -121,6 +122,10 @@ void __init
>>> samsung_bl_set(struct samsung_bl_gpio_info *gpio_info, 
>>> samsung_bl_data->lth_brightness = bl_data->lth_brightness; if
>>> (bl_data->pwm_period_ns) samsung_bl_data->pwm_period_ns =
>>> bl_data->pwm_period_ns; +	if (bl_data->enable_gpio) +
>>> samsung_bl_data->enable_gpio = bl_data->enable_gpio; +	if
>>> (bl_data->enable_gpio_flags) +
>>> samsung_bl_data->enable_gpio_flags =
>>> bl_data->enable_gpio_flags;
>> 
>> Won't this cause the core pwm_bl driver to request/manipulate the
>> GPIO, whereas this driver already does that inside the
>> samsung_bl_init/exit callbacks? I think you either need to adjust
>> those callbacks, or not set the new standard GPIO property in
>> samsung_bl_data.
> 
> I don't think so. The samsung_bl_data is a copy of
> samsung_dfl_bl_data augmented by board-specific settings. So in
> fact copying these values here is essential to allow boards to
> override the enable_gpio and flags fields. Currently no board sets
> the enable_gpio to a valid GPIO so it's all still handled by the
> callbacks only.

Oh yes, you're right. I was confusing the new enable_gpio field in
pwm_bl's platform data with some other field in a custom data structure.

One minor point though:

>>> +	if (bl_data->enable_gpio) +		samsung_bl_data->enable_gpio =
>>> bl_data->enable_gpio;

That assumes that enable_gpio==0 means "none", whereas you've gone to
great pains in the rest of the series to allow 0 to be a valid GPIO
ID. right now, the default value of samsung_bl_data->enable_gpio is
-1, and if !bl_data->enable_gpio, that value won't be propagated across.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
