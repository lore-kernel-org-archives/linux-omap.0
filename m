From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: regression v4.16 on Nokia N900:/dev/input/event6
 aka AV Jack support disappeared
Date: Mon, 26 Feb 2018 09:43:27 -0600
Message-ID: <052b4de7-5734-925b-7e0d-edf7abeefcfc@ti.com>
References: <20180224214617.GA22619@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180224214617.GA22619@amd>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/24/2018 03:46 PM, Pavel Machek wrote:
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


The polarity was wrong before, the AIC3x devices are active low reset
and there is no logic inverters between the SoC and the reset line.
GPIO_ACTIVE_LOW is therefor the correct polarity.

This does not change the driver behavior as currently it uses the old
gpio_set_value() which does not respect the polarity as set in DT.

When this driver is converted to use gpiod_ style calls having the
polarity correct will be important, and right now the old style gpio
calls will cause this driver to fail to work if a board comes along that
does have some logic inversion on the reset line as GPIO_ACTIVE is ignored.

As Pavel points out I think your trouble is elsewhere.

Andrew


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
