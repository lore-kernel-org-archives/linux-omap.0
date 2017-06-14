From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v6 0/4] More fixes for twl4030 charger
Date: Wed, 14 Jun 2017 11:29:09 +0200
Message-ID: <8AEF614C-8C30-4C3A-9357-F9FB44ECBA00@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, Nikolaus Schaller <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Am 14.06.2017 um 11:25 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Changes V6:
> * split up -EPROBE_DEFER and irq allocation patch into small steps:
> 	* convert iio to devm allocation (by Sebsatian Reichel)
> 	* fix potentially wrong initialization sequence (by Grygorii =
Strashko)
> 	* add -EPROBE_DEFER
>=20
> 2017-05-21 12:38:24: Changes V5:
> * reworked max_current removal patch (comments by Sebastian Reichel)
> * resubmit missing madc connection for AC power detection
> * resubmit patch for irq allocation and -EPROBE_DEFER
> * rebased on 4.12-rc1
>=20
> Changes V4:
> * resent commit (original one did contain material not upstream)
>=20
> 2017-04-14 21:29:39: 2017-04-14 20:26:00: Changes V3:
> * worked in comments by Sebsatian Reichel
> * clarifications of some commit messages
> * rebased on v4.11rc-6
>=20
> It took a while (18 months) until we propose an updated patch for =
upstream...
>=20
> 2015-11-02 12:27:39: Changes V2:
> * worked in comments by Nishanth Menon <nm@ti.com>
> * added another patch which solves a probing/boot stall problem (irq =
allocation vs. -EPROBE_DEFER)
>=20
> V1:
> 4.3-rc1 introduced a new charger driver for the twl4030. This patch =
set fixes some
> issues.
>=20
> While making twl4030 changes from 4.3 operable we have found some =
issues
> during testing on GTA04 and OpenPandora.
>=20
> H. Nikolaus Schaller (4):
>  power: supply: twl4030-charger: allocate iio by =
devm_iio_channel_get()
>    and fix error path
>  power: supply: twl4030-charger: move allocation of iio channel to the
>    beginning
>  power: supply: twl4030-charger: move irq allocation to just before
>    irqs are enabled
>  power: supply: twl4030-charger: add deferred probing for phy and iio

I should note that I have split up the original single commit into 4 =
separate patches.
If maintainers thing this is too fine granularity, please squash them.

The result is tested to work on GTA04.
