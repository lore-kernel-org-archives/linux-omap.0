From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Thu, 19 Jan 2012 14:26:45 +0000
Message-ID: <201201191426.45923.arnd@arndb.de>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com> <201201181403.47806.arnd@arndb.de> <20120118213635.GB3401@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120118213635.GB3401@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Andi <andi.shyti@gmail.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "greg@kroah.com" <greg@kroah.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 January 2012, Andi wrote:
> What do you mean with "kernel-wide policy for accelerometer drivers"?
> As far as I know, accelerometer drivers are written between the i2c driver and the
> input driver.
> The input driver provides already some accelerometer specific event types, ABS_X, ABS_Y, ABS_Z,
> in your opinion isn't it enough?
> If you mean something like collecting common properties like g range or frequency or whatever in a
> standard interface, then I think that accelerometers are quite different as devices and sometimes
> it could be difficult to arrange a common interface.

The problem is that we have some drivers using the input subsystem, some
drivers using the iio subsystem and some drivers using none of these but
interfacing with user space using some homegrown method, see my list:

> > $ git grep -l accelerometer drivers/ | manual_grep
> > drivers/hwmon/applesmc.c
> >    (one hwmon sysfs attribute for x/y/z)
> > drivers/input/misc/adxl34x.c
> >    (lots of sysfs attributes, input_report_key)
> > drivers/input/misc/cma3000_d0x.c
> >    (input_report_abs)
> > drivers/input/misc/kxtj9.c
> >    (input_report_abs, plus one aux sysfs attribute)
> > drivers/macintosh/ams/ams-core.c
> >    (one sysfs attribute for x/y/z)
> > drivers/misc/lis3lv02d/
> >    (multiple sysfs attributes)
> > drivers/platform/x86/hdaps.c
> >    (multiple sysfs attributes, only x/y)
> > drivers/platform/x86/hp_accel.c
> >    (hooks into drivers/misc/lis3lv02d/)
> > drivers/staging/iio/accel/kxsd9.c
> >    (iio)
> > drivers/staging/iio/accel/sca3000_core.c
> >    (iio plus extra attributes)

If all drivers were using the input subsystem in the way you describe,
that would be a good solution, but right now the majority of the
drivers don't do this.

	Arnd
