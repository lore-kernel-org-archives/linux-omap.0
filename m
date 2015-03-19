From: Nikolay Dimitrov <picmaster@mail.bg>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 20:06:15 +0200
Message-ID: <550B1017.2000405@mail.bg>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com>
 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
 <550AF442.5040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <550AF442.5040203@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Greg Knight <g.knight@symetrica.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On 03/19/2015 06:07 PM, Peter Ujfalusi wrote:
> On 03/19/2015 04:34 PM, Greg Knight wrote:
>>> SO is it so that the codec's MCLK is coming from McASP AHCLKX (or R) and this
>>> clock need to be present all the time? W/o the MCLK the registers are not
>>> accessible?
>>
>> Correct, the SGTL5000's I2C registers are not accessible without MCLK.
>
> Yeah, according to the datasheet, it needs MCLK in order to communicate with it.
>

Slight clarification here - I can't find any such reference in the
SGTL5000 datasheet where it's explicitly written that the I2C bus
*requires* the MCLK running. Unfortunately, all of us found this
obscure dependency empirically. One more thing - the codec's I2C works
with "any" supported MCLK (8-27 MHz), you can even change the clock on
the fly (not highly recommended, but it works).

>>  From my testing, the clock need only be present when the audio chip is
>> in use. When not in use, the chip appears perfectly happy to not be
>> clocked.
>
> If you change audio controls while you don't have audio activity, you will
> still need to have the MCLK running.

Correct. And this is a big issue. As far as I know, the kernel drivers
control separately the clock domains, and separately i2c devices, so
the basic expectation on the kernel side is that there's no connection
between these 2. In this specific case, because of the SGTL5000's
implementation, there's a dependency. Right now as I see it, there are
several ways to resolve it:

1. Run the reference clock all the time, so the SGTL5000 codec is
happy, and DAPM widgets can work as-is. We've been doing this all the
time - the reference clocks are routinely configured either in the
bootloader, or in the DTS iomuxc node. While this can work in some
cases (or until someone touches the same clock or one of its parents
:D), there are other cases (like battery-powered devices) where people
would want more aggressive power management, which means controlling
the reference clock at runtime (see #2).

2. Add "hacks" in the DAPM widgets that add control to the codec's
reference clocks. While this seems the preferred route to many, the
general feeling is that such approach is not very welcome in upstream.

3. Add explicit support in the kernel's audio subsystem for
dependencies between i2c devices and clocks, maybe via "DAPM clock
widget" or something like this. Provided that the DAPM graphs are
defined properly, this will work out-of-the-box for all use cases,
without the hacks (until we see even more twisted cases).

Kind regards,
Nikolay
