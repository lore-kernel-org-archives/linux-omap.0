From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 19:26:27 +0200
Message-ID: <56EAE8C3.1080301@gmail.com>
References: <201507251228.27128@pali> <201601050034.12810@pali>
 <20160306152339.GA428@earth> <201603121342.33099@pali>
 <56E68B71.2030202@ti.com> <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EA6282.5050501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi,

>
> can you try this:
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 11d85c5c787a..7f5881bff5d9 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -386,6 +386,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
>                  data->power_gpio = pdata->power_gpio;
>          } else if (np) {
>                  data->power_gpio = of_get_named_gpio(np, "power-gpio", 0);
> +               if (data->power_gpio == -EPROBE_DEFER)
> +                       return data->power_gpio;
>          } else {
>                  dev_err(dev, "Platform data not set\n");
>                  dump_stack();
>


Doesn't help :(

Ivo
