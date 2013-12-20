From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 11:27:01 +0000
Message-ID: <20131220112700.GF32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131219182252.GP27438@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 19, 2013 at 10:22:53AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [131219 09:58]:
> > On Wed, Dec 18, 2013 at 10:23:54AM -0800, Tony Lindgren wrote:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131218 05:56]:
> > > > I don't have an LDP board at hand, and I wasn't able to find out anything from
> > > > the logs.
> > > > 
> > > > I think I should change omapfb to print something if it's probed succesfully,
> > > > as the deferred probing makes finding out if something is probed fine or not
> > > > quite murky. Without deferred probing, it was simpler: no errors -> the driver
> > > > must be (most likely) ok.
> > > > 
> > > > Although... In an earlier log, where there was no panel driver, the log has
> > > > these errors:
> > > > 
> > > > Error opening /dev/fb0: No such device
> > > > 
> > > > There are none in the latest log, which makes me guess the omapfb has been
> > > > probed, and fb0 is actually there. But the X is still dying for some reason...
> > > > 
> > > > I'll look at this more. Maybe someone in our team can find a board to test.
> > > 
> > > Hmm I had the framebuffer working with DT on LDP after fixing the twl4030
> > > gpio regression with 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl
> > > gpio output) using this pdata quirks patch:
> > > 
> > > [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make omap3 LDP to use it
> > > 
> > > AFAIK the pdata hack above should not be needed now, but I have not tried
> > > with Tomi's DSS DT patches yet.
> > > 
> > > Tomi do you have some sample panel dpi .dts entry somewhere for the LDP I
> > > could try at some point?
> > > 
> > > Russell, maybe all you're missing is just omapfb.vram=0:2M,1:5M or similar
> > > from your kernel cmdline?
> > 
> > Note that I'm trying to get non-DT stuff working properly here first, in
> > such a state that it has done in the past with mainline kernels.  This is
> > quite an old regression, but it's still a regression nevertheless.
> 
> Yeah that should just work now.
>  
> > I've just built and booted a kernel with the backlight support in.  No
> > change.
> 
> I just tried it here with v3.13-rc4 in legacy mode using omap2plus_defconfig
> with the following test script and seems to work just fine for producing a
> nice random color pattern on the LCD:
> 
> #!/bin/sh
> mount -o rw,remount /
> depmod -a
> modprobe panel-generic-dpi
> modprobe panel-dpi
> modprobe omapfb vram=0:2M,1:5M
> if [ -c /dev/fb0 ]; then
>         dd if=/dev/urandom of=/dev/fb0;
> fi
> 
> Note that as the panel name has changed recently so my script tries to
> load both panel modules.

I don't think the problem is with the creation of the framebuffer.

> Maybe you're missing something from your .config file still?

Maybe, but that's the problem - finding out what is missing.  This is the
endless problem where things keep changing - it's very difficult to keep
a "working configuration" working because the config symbols keep changing.

Also, bear in mind that there's many different variants of the LDP hardware
with stuff connected up in different ways (I'm aware that the keypad is
just randomly allocated).  I wouldn't be surprised if this also applied
to how the backlight on the LCD was done.

> BTW, I'm seeing MMC errors with my LDP here though, does that work
> for you?

I see no errors there.

Okay, while digging through the changes, I found this - this is the old
code.  gpio + 15 is the backlight enable GPIO.

 static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 {
-       ldp_panel_data.gpios[0] = gpio + 7;
-       ldp_panel_data.gpio_invert[0] = true;

-       ldp_panel_data.gpios[1] = gpio + 15;
-       ldp_panel_data.gpio_invert[1] = true;

        return 0;
 }

...

-static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
-{
...
-       for (i = 0; i < panel_data->num_gpios; ++i) {
-               gpio_set_value_cansleep(panel_data->gpios[i],
-                               panel_data->gpio_invert[i] ? 0 : 1);
-       }

-static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
-{
...
-       for (i = panel_data->num_gpios - 1; i >= 0; --i) {
-               gpio_set_value_cansleep(panel_data->gpios[i],
-                               panel_data->gpio_invert[i] ? 1 : 0);
-       }

-static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
-{
-       for (i = 0; i < panel_data->num_gpios; ++i) {
-               r = devm_gpio_request_one(dssdev->dev, panel_data->gpios[i],
-                               panel_data->gpio_invert[i] ?
-                               GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
-                               "panel gpio");
-               if (r)
-                       return r;
-       }

So, when gpio_invert[] is set, the signal is active low for "on".  What
does the new code do?

 static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 {
+       /* LCD enable GPIO */
+       ldp_lcd_pdata.enable_gpio = gpio + 7;

+       /* Backlight enable GPIO */
+       ldp_lcd_pdata.backlight_gpio = gpio + 15;
...

static int panel_dpi_enable(struct omap_dss_device *dssdev)
{
...
        if (gpio_is_valid(ddata->backlight_gpio))
                gpio_set_value_cansleep(ddata->backlight_gpio, 1);

...
static void panel_dpi_disable(struct omap_dss_device *dssdev)
{
...
        if (gpio_is_valid(ddata->backlight_gpio))
                gpio_set_value_cansleep(ddata->backlight_gpio, 0);

...
static int panel_dpi_probe(struct platform_device *pdev)
{
...
        if (gpio_is_valid(ddata->backlight_gpio)) {
                r = devm_gpio_request_one(&pdev->dev, ddata->backlight_gpio,
                                GPIOF_OUT_INIT_LOW, "panel backlight");

which is fixed at active-high for "on".

Would you like to revise whether this works for you... I suspect that
you're missing configuration which means that the backlight_gpio is
not valid, and hence it's being left in same default state (maybe by
the boot loader?)
