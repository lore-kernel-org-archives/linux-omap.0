From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: regression v4.16 on Nokia N900:/dev/input/event6 aka AV Jack
 support disappeared
Date: Mon, 26 Feb 2018 10:47:45 +0100
Message-ID: <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
References: <20180224214617.GA22619@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180224214617.GA22619@amd>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, afd@ti.com
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

JFYI: This issues is tracked in the regression reports for Linux 4.16
(http://bit.ly/lnxregrep416 ) with this id:

Linux-Regression-ID: lr#4b650f

Please include this line in the comment section of patches that are
supposed to fix the issue. Please also mention the string once in other
mailinglist threads or different bug tracking entries if you or someone
else start to discuss the issue there. By including that string you make
it a whole lot easier to track where an issue gets discussed and how far
patches to fix it have made it. For more details on this please see
here: http://bit.ly/lnxregtrackid

Thx for your help. Ciao, Thorsten

On 24.02.2018 22:46, Pavel Machek wrote:
> Hi!
> 
> In v4.16, AV jack support disappeared.
> 
> This one is suspect:
> 
> commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
> Author: Andrew F. Davis <afd@ti.com>
> Date:   Wed Nov 29 11:13:59 2017 -0600
> 
>     ARM: dts: omap3-n900: Fix the audio CODEC's reset pin
> 
>     The correct DT property for specifying a GPIO used for reset
>         is "reset-gpios", fix this here.
> 
>     Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
>     support")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> How was it tested? It reverts polarity of reset pin, but
> sound/soc/codecs/tlv320aic3x.c treats those as aliases:
> 
>  ret = of_get_named_gpio(np, "reset-gpios", 0);
>  if (ret >= 0) {
>     aic3x->gpio_reset = ret;
>  } else {
>  ret = of_get_named_gpio(np, "gpio-reset", 0);
>  if (ret > 0) {
>     dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please update your DT");
>     aic3x->gpio_reset = ret;
> 
> 
> 									Pavel
> 
