From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
Date: Tue, 28 Sep 2010 14:43:16 +0400
Message-ID: <4CA1C6C4.20504@mvista.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com> <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Murthy <arun.murthy@stericsson.com>
Cc: lars@metafoo.de, akpm@linux-foundation.org, kernel@pengutronix.de, philipp.zabel@gmail.com, robert.jarzmik@free.fr, marek.vasut@gmail.com, eric.y.miao@gmail.com, rpurdie@rpsys.net, sameo@linux.intel.com, kgene.kim@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, STEricsson_nomadik_linux@list.st.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 28-09-2010 14:35, Arun Murthy wrote:

> A new element 'name' is added to pwm led platform data structure.
> This is required to identify the pwm device.

> Signed-off-by: Arun Murthy<arun.murthy@stericsson.com>
> Acked-by: Linus Walleij<linus.walleij@stericsson.com>

[...]

> diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
> index 33a0711..7a847a0 100644
> --- a/include/linux/leds_pwm.h
> +++ b/include/linux/leds_pwm.h
> @@ -16,6 +16,7 @@ struct led_pwm {
>   struct led_pwm_platform_data {
>   	int			num_leds;
>   	struct led_pwm	*leds;
> +	char *name;
>   };

    Shouldn't '*name'be aligned, at least with '*leds'?

WBR, Sergei
