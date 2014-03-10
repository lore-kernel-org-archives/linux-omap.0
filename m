From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv8 0/4] power_supply: Introduce power supply charging
 driver
Date: Mon, 10 Mar 2014 08:35:52 +0000
Message-ID: <20140310083552.GB14976@lee--X1>
References: <1394170174-21959-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394170174-21959-1-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Jenny,

Would you mind _not_ CC'ing me on all of your emails please?

I have enough _relevant_ email to deal with already without seeing
this churn constantly.

Thanks in advance.

> v1: introduced feature as a framework within power supply class drive=
r with
> 	separate files for battid framework and charging framework
> v2: fixed review comments, moved macros and inline functions to power=
_supply.h
> v3: moved the feature as a separate driver, combined battid framework=
 and
> 	charging framework inside the power supply charging driver. Moved
> 	charger specific properties to power_supply_charger.h and plugged th=
e
> 	driver with power supply subsystem using power_supply_notifier
> 	introduced in my previous patch. Also a sample charger chip driver
> 	(bq24261) patch added to give more idea on the psy charging driver
> 	usage
> v4: Fixed review comments, no major design changes.
> v5: Fixed makefile inconsistencies, removed unused pdata callbacks
> v6: Fixed nested loops, commenting style
> v7: added kerneldocs for structs and minor fixes
> v8: used msecs_to_jiffies instead of HZ directly, modified Kconfig he=
lp text
>     for POWER_SUPPLY_CHARGING_ALGO_PSE
>=20
> The Power Supply charging driver connects multiple subsystems
> to do charging in a generic way. The subsystems involves power_supply=
,
> thermal and battery communication subsystems (1wire).With this the ch=
arging is
> handled in a generic way.
>=20
> The driver makes use of different new features - Battery Identificati=
on
> interfaces, pluggable charging algorithms, charger cable arbitrations=
 etc.
> The patch also introduces generic interface for charger cable notific=
ations.
> Charger cable events and capabilities can be notified using the gener=
ic
> power_supply_notifier chain.
>=20
> Overall this driver removes the charging logic out of the charger chi=
p driver
> and the charger chip driver can just listen to the request from the p=
ower
> supply charging driver to set the charger properties. This can be imp=
lemented
> by exposing get_property and set property callbacks.
>=20
> Jenny TC (4):
>   power_supply: Add inlmt,iterm, min/max temp props
>   power_supply: Introduce generic psy charging driver
>   power_supply: Introduce PSE compliant algorithm
>   power_supply: bq24261 charger driver
>=20
>  Documentation/power/power_supply_charger.txt |  353 +++++++
>  Documentation/power/power_supply_class.txt   |    6 +
>  drivers/power/Kconfig                        |   31 +
>  drivers/power/Makefile                       |    3 +
>  drivers/power/bq24261-charger.c              | 1350 ++++++++++++++++=
++++++++++
>  drivers/power/charging_algo_pse.c            |  204 ++++
>  drivers/power/power_supply_charger.c         | 1186 ++++++++++++++++=
++++++
>  drivers/power/power_supply_charger.h         |  218 +++++
>  drivers/power/power_supply_core.c            |    3 +
>  drivers/power/power_supply_sysfs.c           |    4 +
>  include/linux/power/bq24261-charger.h        |   25 +
>  include/linux/power/power_supply_charger.h   |  341 +++++++
>  include/linux/power_supply.h                 |  164 ++++
>  13 files changed, 3888 insertions(+)
>  create mode 100644 Documentation/power/power_supply_charger.txt
>  create mode 100644 drivers/power/bq24261-charger.c
>  create mode 100644 drivers/power/charging_algo_pse.c
>  create mode 100644 drivers/power/power_supply_charger.c
>  create mode 100644 drivers/power/power_supply_charger.h
>  create mode 100644 include/linux/power/bq24261-charger.h
>  create mode 100644 include/linux/power/power_supply_charger.h
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
