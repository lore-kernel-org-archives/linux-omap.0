From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] TSC2102 main SPI driver
Date: Thu, 19 Oct 2006 16:42:46 +0300
Message-ID: <20061019134244.GE9983@atomide.com>
References: <fb249edb0608180301u113ae66fg7be0b7a001c1cc46@mail.gmail.com>
	<200609012214.43755.david-b@pacbell.net>
	<fb249edb0609131201h545d9a36wa24140740f6ef3db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609131201h545d9a36wa24140740f6ef3db@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060913 22:08]:
> Thanks for the review.
> 
> On 02/09/06, David Brownell <david-b@pacbell.net> wrote:
> >On Friday 18 August 2006 3:01 am, andrzej zaborowski wrote:
> >> --- a/drivers/spi/Kconfig       2006-07-06 02:48:18.000000000 +0000
> >> +++ b/drivers/spi/Kconfig       2006-08-17 23:35:38.000000000 +0000
> >
> >Hmm, seems to me this is the wrong directory for this driver.
> >I can see it primarily being a touchscreen driver (with some
> >hwmon sensors too); or primarily an audio driver.  But maybe
> >you're right that the core should be here.
> 
> I was also wondering where it should go. With functions as diverse as
> audio, input and hwmon I can't tell what is the primary function.
> 
> >
> >
> >> > +config TSC2102
> >> +       depends on SPI_MASTER
> >> +       tristate "TSC2102 codec support"
> >> +       ---help---
> >> +         Say Y here if you want support for the TSC2102 codec.  It is
> >> +         needed for the touchscreen driver on some boards.
> >
> >Don't describe it as a "codec".  It's a multifunction chip, with audio
> >codec and amplifier, and sensors  for touchscreen, battery voltage, and
> >temperature ... plus more, I don't have the spec sheet here.
> 
> Ok. Basically this, audio controller and the sensors.
> 
> >
> >How much does this driver need to differ from a TSC 2101 driver, by the
> >way?  Enough to really need separate drivers?
> 
> Well, I can imagine a TSC 2XXX driver but there would be *a lot* of
> conditional code because  there are differences: some registers or
> single bits in particular registers have changed places or are
> "Reserved"; the capabilities differ: some chips include a keypad
> controller, have different audio outputs and inputs and different
> sensors. The main difference, however, is that on 2102 and later (e.g.
> 2301) a new conversion doesn't start until all converted data is read
> out of the registers which means that you always have to read the data
> or you won't receive another interrupt.
> 
> >
> >
> >
> >> +module_param_named(sensor_scan_msecs, tsc.mode_msecs, uint, 0);
> >> +MODULE_PARM_DESC(sensor_scan_msecs, "Temperature & battery scan 
> >interval");
> >
> >If you even need to have this be configurable, it should be part of
> >the hwmon support.  AFAICT only the battery would need polling, and
> >that would only be for APM emulation...
> 
> This value also affects the touchscreen responsiveness because
> touchscreen conversions have to be stopped for the scanning of other
> sensors.
> 
> >
> >> +void tsc2102_set_volume(uint8_t left_ch, uint8_t right_ch)
> >> ...
> >> +void tsc2102_set_mute(int left_ch, int right_ch)
> >> ...
> >> +void tsc2102_get_mute(int *left_ch, int *right_ch)
> >> ...
> >> +void tsc2102_set_deemphasis(int enable)
> >> ...
> >> +void tsc2102_set_bassboost(int enable)
> >> ... etc ...
> >
> >All of that should surely be included only if the ALSA support is
> >included ...
> 
> Ok. I now include it if CONFIG_SOUND is enabled because it's not ALSA 
> specific.
> 
> >
> >
> >> +static struct platform_device tsc2102_ts_device = {
> >> +       .name           = "tsc2102-ts",
> >> +       .id             = -1,
> >> +};
> >> +
> >> +static struct platform_device tsc2102_hwmon_device = {
> >> +       .name           = "tsc2102-hwmon",
> >> +       .id             = -1,
> >> +};
> >
> >I don't much like spilitting those out like that; if HWMON is
> >configured, just include tsc2102 hwmon hooks here, directly;
> >even if you do split out the touchscreen and audio support
> >into separate drivers.
> 
> The attached version is how it looks with the hwmon part included in
> this same file. I liked more the approach with hwmon code separated in
> drivers/hwmon/ because then the "platform_device" framework itself
> takes care of the configuration. Also I think that a device
> "tsc2102-hwmon" should exist even if hwmon is not configured.
> 
> >
> >
> >> +static struct platform_device tsc2102_alsa_device = {
> >> +       .name           = "tsc2102-alsa",
> >> +       .id             = -1,
> >> +};
> >> +
> >
> >Surely you should be setting the parent of all those devices
> >to be the spi_device.dev ???
> 
> Ok.
> 
> >
> >
> >Also, the linkage between this "core" to "layered" drivers
> >leaves a bit to be desired.  Why not just provide those
> >layered drivers a hook function they can call, maybe along
> >the lines of
> >
> >        tsc210x_write_sync(struct device *tsc210x,
> >                        unsigned        register,
> >                        u16             value);
> >
> >Or whatever ... the "device" being of course the sysfs parent
> >of the platform device.
> 
> I'm not sure I understand. There are hooks for writing and reading
> registers provided, but I figured it is better to access registers
> directly (using these hooks) only from one file because of the
> dependency between the chip's functions, e.g touchscreen and the
> sensors, they have to share the ADC time and shouldn't mess up the
> order of some accesses. Also, when the audio DAC is powered up, the
> proper clock must be enabled or the touchscreen will stop working (not
> the audio).

Pushing today.

Tony
