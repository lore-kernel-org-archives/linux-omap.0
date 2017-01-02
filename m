From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 09:44:32 +0100
Message-ID: <20170102084432.GA6728@pali>
References: <201701012054.54505@pali>
 <6462f543-0422-8146-a196-f4e07c3ebb6f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6462f543-0422-8146-a196-f4e07c3ebb6f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 02 January 2017 10:23:23 Peter Ujfalusi wrote:
> Hi,
> 
> On 01/01/2017 09:54 PM, Pali Rohár wrote:
> > Hi!
> > 
> > I'm looking at original Maemo N900 2.6.28 sound driver and GPIOs which
> > controls A/V jack detection.
> > 
> > For reference source code of that driver can be found e.g. at alsa-devel
> > ML [1] [2] or in my linux-n900 git tree, branch v2.6.28-nokia [3].
> > 
> > In that sound/soc/omap/rx51.c code is function rx51_set_eci_switches()
> > which configures 2 gpios: RX51_ECI_SWITCH_1_GPIO = gpio 178 and
> > RX51_ECI_SWITCH_2_GPIO = gpio 182 based on "eci mode" input parameter.
> > 
> > But in mainline kernel code [4] [5] there is no information about gpio 178
> > (as RX51_ECI_SWITCH_1_GPIO) and gpio 182 is called as just "eci-switch".
> > More interesting part is that "eci-switch" gpio is not used in whole
> > mainline code. It is just referenced in Nokia N900 DTS [4]. Looks like
> > sound driver in mainline kernel is incomplete.
> > 
> > Jarkko, you are listed as original author of that driver. Do you (or
> > anybody else) remember what that rx51_set_eci_switches() function is
> > doing? And what gpio 178 controls? I was even not able to find gpio 178
> > in RX-51 Schematics [6].
> 
> GPIO_182 is to select where to route the MIC line from the jack for the
> ECI core to handle (when the TVOUT is disabled).

Yes, already figured out from schematic.

> I have no idea what the
> gpio_178 should have been used for. It might be only needed for early
> protos but not in production devices?

I do not know, reason why I'm asking.

> > And do you know something about Nokia ECI headsets supports for Nokia
> > N900. Looks like there is already some kernel code but support for ECI
> > bus or multibuttons headset is missing.
> 
> Not sure if n900 had full support for ECI, afaik n9 did supported it.
> The ECI input driver was sent upstream, but can not recall the reason
> why it is not in mainline:
> 
> https://patchwork.kernel.org/patch/450811/

That driver is just kernel input glue for some unknown (audio?) chip.
Nothing useful for Nokia N900. To work it is needed another driver which
fill data to that input one.

> > 
> > [1] - http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022033.html
> > 
> > [2] - http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022039.html
> > 
> > [3] - https://github.com/pali/linux-n900/blob/v2.6.28-nokia/sound/soc/omap/rx51.c
> > 
> > [4] - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/omap3-n900.dts#n128
> > 
> > [5] - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/omap/rx51.c
> > 
> > [6] - https://wiki.maemo.org/N900_Hardware_Schematic
> > 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
