From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
Date: Wed, 5 Oct 2011 00:05:16 +0530
Message-ID: <20111004183516.GB8021@manju-desktop>
References: <20110922184614.25419.84606.stgit@ponder>
 <20111004145148.GA8021@manju-desktop>
 <CACxGe6tXEx1A+ZuBTUdi8jjfx_hOCaX6eSpUOOhNH9us+Mnczg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6tXEx1A+ZuBTUdi8jjfx_hOCaX6eSpUOOhNH9us+Mnczg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 04, 2011 at 09:58:10AM -0600, Grant Likely wrote:
> On Tue, Oct 4, 2011 at 8:51 AM, G, Manjunath Kondaiah <manjugk@ti.com=
> wrote:
> > On Thu, Sep 22, 2011 at 12:51:23PM -0600, Grant Likely wrote:
> >> Hi Manjunath,
> >>
> >> Here's the current state of the patch. =A0The major think that nee=
ds to
> >> be done is to convert it to use a separate workqueue as described =
in
> >> the TODO above. =A0It also needs some users adapted to it. =A0One =
of the
> >> gpio drivers would work; preferably one of the newer drivers that
> >> doesn't have a lot of drivers depending on the early_initcall()
> >> behaviour yet.
> >
> > I have tested this patch on omap3 beagle board by making:
> > 1. omap-gpio driver init as late_initcall instead of postcore_initc=
all
> > 2. mmc driver probe will request gpio through gpio_request and gpio=
 driver
> > returns -EDEFER_PROBE which in turn makes mmc driver to request def=
erral probe.
> > 3. When deferral probe gets activated, it scans driver entries and =
it will not
> > find any match for mmc driver probe.
>=20
> Looks like drivers/mmc/host/omap.c is using platform_driver_probe()
> instead of platform_driver_register().  Add the probe hook to the
> platform_driver structure and change it to call
> platform_driver_register() and it should work.  Don't forget to chang=
e
> mmc_omap_probe from __init to __devinit.

Yes. After changing it into platform_driver_register, I can see mmc pro=
be is
getting completed from deferred probe list. But, MMC upper layer will c=
heck=20
probe and it waits for ever since probe_count is not getting incremente=
d.

Log:

[    1.807830] platform omap_hsmmc.0: Driver omap_hsmmc requests probe =
deferral

=2E..

[    1.948760] omap_device: omap_gpio.0: new worst case activate latenc=
y 0:30517
[    1.959259] OMAP GPIO hardware version 2.5

=2E..

[    2.000488] platform omap_hsmmc.0: Retrying from deferred list
[    2.008026] omap_device: omap_hsmmc.0: new worst case activate laten=
cy 0:244140
[    2.020080] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put1
[    2.035827] omap_hsmmc omap_hsmmc.0: Probe success...
[    2.042083] twl_rtc twl_rtc: setting system clock to 2000-01-01 01:0=
6:35 UTC
(946688795)
[    2.056030] Waiting for root device /dev/mmcblk0p2...
[    2.061492] driver_probe_done: probe_count =3D 0
[    2.168518] driver_probe_done: probe_count =3D 0
[    2.277832] driver_probe_done: probe_count =3D 0
[    2.387207] driver_probe_done: probe_count =3D 0
[    2.496582] driver_probe_done: probe_count =3D 0

Waits for ever in init/do_mount.c:
	if ((ROOT_DEV =3D=3D 0) && root_wait) {
		printk(KERN_INFO "Waiting for root device %s...\n",
			saved_root_name);
		while (driver_probe_done() !=3D 0 ||
			(ROOT_DEV =3D name_to_dev_t(saved_root_name)) =3D=3D 0)
			msleep(100);
		async_synchronize_full();
	}

-Manjunath
