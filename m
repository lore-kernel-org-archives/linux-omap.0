From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] thermal: consistently use int for temperatures
Date: Mon, 6 Jul 2015 12:25:15 +0200
Message-ID: <20150706122515.4580521c@endymion.delvare>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

On Mon,  6 Jul 2015 09:19:49 +0200, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>=20
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0=C2=B0C. This will=
 probably
> immediately shut the machine down due to overtemperature if started b=
elow
> 0=C2=B0C.
>=20
> 'long' is 64bit on several architectures. This is not needed since IN=
T_MAX =C2=B0mC
> is above the melting point of all known materials.
>=20
> Consistently use a plain 'int' for temperatures throughout the therma=
l code and
> the drivers. This only changes the places in the drivers where the te=
mperature
> is passed around as pointer, when drivers internally use another type=
 this is
> not changed.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Feuerer <peter@piie.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: lm-sensors@lm-sensors.org
> ---
>  drivers/acpi/thermal.c                             | 12 +++++-----
>  drivers/hwmon/lm75.c                               |  2 +-
>  drivers/hwmon/ntc_thermistor.c                     |  2 +-
>  drivers/hwmon/tmp102.c                             |  2 +-
>  drivers/input/touchscreen/sun4i-ts.c               |  8 +++----
>  drivers/platform/x86/acerhdf.c                     |  9 ++++----
>  drivers/platform/x86/intel_mid_thermal.c           |  9 ++++----
>  drivers/power/power_supply_core.c                  |  2 +-
>  drivers/thermal/armada_thermal.c                   |  2 +-
>  drivers/thermal/db8500_thermal.c                   |  7 +++---
>  drivers/thermal/dove_thermal.c                     |  2 +-
>  drivers/thermal/fair_share.c                       |  2 +-
>  drivers/thermal/gov_bang_bang.c                    |  5 ++--
>  drivers/thermal/hisi_thermal.c                     |  4 ++--
>  drivers/thermal/imx_thermal.c                      | 27 +++++++++++-=
----------
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  2 +-
>  .../thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++----
>  .../thermal/int340x_thermal/int340x_thermal_zone.h |  8 +++----
>  .../int340x_thermal/processor_thermal_device.c     |  4 ++--
>  drivers/thermal/intel_quark_dts_thermal.c          | 13 +++++------
>  drivers/thermal/intel_soc_dts_iosf.c               |  8 +++----
>  drivers/thermal/kirkwood_thermal.c                 |  2 +-
>  drivers/thermal/of-thermal.c                       | 14 +++++------
>  drivers/thermal/power_allocator.c                  | 16 ++++++------=
-
>  drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
>  drivers/thermal/rcar_thermal.c                     |  7 +++---
>  drivers/thermal/rockchip_thermal.c                 | 10 ++++----
>  drivers/thermal/samsung/exynos_tmu.c               | 23 +++++++++---=
------
>  drivers/thermal/spear_thermal.c                    |  2 +-
>  drivers/thermal/st/st_thermal.c                    |  5 ++--
>  drivers/thermal/step_wise.c                        |  4 ++--
>  drivers/thermal/tegra_soctherm.c                   |  4 ++--
>  drivers/thermal/thermal_core.c                     | 26 ++++++++++--=
---------
>  drivers/thermal/thermal_hwmon.c                    | 10 ++++----
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 10 ++++----
>  drivers/thermal/x86_pkg_temp_thermal.c             | 10 ++++----
>  include/linux/thermal.h                            | 26 +++++++++---=
---------
>  37 files changed, 148 insertions(+), 163 deletions(-)
> (...)

No objection from me.

=46or the hwmon parts:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support
