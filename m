From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Wed, 18 Jan 2012 14:03:47 +0000
Message-ID: <201201181403.47806.arnd@arndb.de>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com> <331ABD5ECB02734CA317220B2BBEABC13177CDA4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13177CDA4@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "greg@kroah.com" <greg@kroah.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 January 2012, AnilKumar, Chimata wrote:
> Hi All,
> 
> Recalling the patch, provide the comments if there are any if not please include
> this patch to v3.3 kernel.

As Mark and Greg said, 3.4 would be appropriate.

> +static ssize_t lis3lv02d_range_set(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	unsigned long range;
> +
> +	if (strict_strtoul(buf, 0, &range))
> +		return -EINVAL;
> +
> +	lis3_dev.g_range = range;
> +	lis3lv02d_update_g_range(&lis3_dev);
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR(selftest, S_IRUSR, lis3lv02d_selftest_show, NULL);
>  static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
>  static DEVICE_ATTR(rate, S_IRUGO | S_IWUSR, lis3lv02d_rate_show,
>  					    lis3lv02d_rate_set);
> +static DEVICE_ATTR(range, S_IRUGO | S_IWUSR, lis3lv02d_range_show,
> +					    lis3lv02d_range_set);

I think you need to document this new attribute in the Documentation
directory, unless I missed the other patch doing this.

On a more general topic, do we have a kernel-wide policy for accelerometer
drivers? AFAICT, we currently have three subsystems that contain 
accelerometer drivers, plus a few ad-hoc ones like this, which is a
rather unpleasant situation. What I found are these:

$ git grep -l accelerometer drivers/ | manual_grep
drivers/hwmon/applesmc.c
   (one hwmon sysfs attribute for x/y/z)
drivers/input/misc/adxl34x.c
   (lots of sysfs attributes, input_report_key)
drivers/input/misc/cma3000_d0x.c
   (input_report_abs)
drivers/input/misc/kxtj9.c
   (input_report_abs, plus one aux sysfs attribute)
drivers/macintosh/ams/ams-core.c
   (one sysfs attribute for x/y/z)
drivers/misc/lis3lv02d/
   (multiple sysfs attributes)
drivers/platform/x86/hdaps.c
   (multiple sysfs attributes, only x/y)
drivers/platform/x86/hp_accel.c
   (hooks into drivers/misc/lis3lv02d/)
drivers/staging/iio/accel/kxsd9.c
   (iio)
drivers/staging/iio/accel/sca3000_core.c
   (iio plus extra attributes)

While I'm not blaming you for the current situation, but I think the
situation is no longer sustainable and we need to decide on one place
and interface for these to go in the long run so we don't grow even
more nonstandard interfaces.

Any opinions where they should live? input, iio or a new subsystem?

	Arnd
