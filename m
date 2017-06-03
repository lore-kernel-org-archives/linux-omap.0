From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v5 0/3] More fixes for twl4030 charger
Date: Sat, 3 Jun 2017 08:01:13 +0200
Message-ID: <421EB4BB-9E42-413B-8FB8-2B865FC25D15@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495363097.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, Nikolaus Schaller <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

No comments for this series? Everything fine? Has it been merged =
somewhere?

> Am 21.05.2017 um 12:38 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Changes V5:
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
> H. Nikolaus Schaller (2):
>  drivers:power:twl4030-charger: remove nonstandard max_current sysfs
>    attribute
>  drivers:power:twl4030-charger: add deferred probing for phy and iio
>=20
> Marek Belisko (1):
>  ARM: dts: twl4030: Add missing madc reference for bci subnode
>=20
> .../ABI/testing/sysfs-class-power-twl4030          |  17 ----
> arch/arm/boot/dts/twl4030.dtsi                     |   2 +
> drivers/power/supply/twl4030_charger.c             | 100 =
+++++----------------
> 3 files changed, 24 insertions(+), 95 deletions(-)
>=20
> --=20
> 2.12.2
>=20
