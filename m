From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v5 0/5] Thermal: Support for hardware-tracked trip points
Date: Wed, 22 Jun 2016 11:25:39 +0800
Message-ID: <1466565939.2379.5.camel@intel.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
	 <57689B82.3000902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <57689B82.3000902@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>, Caesar Wang <wxt@rock-chips.com>, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, smbarber@google.com, Durgadoss R <durgadoss.r@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-rockchip@lists.infradead.org, briannorris@google.com, Andy Champ <andycham@amazon.com>, huangtao@rock-chips.com, Sascha Hauer <s.hauer@pengutronix.de>, javi.merino@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ni Wade <wni@nvidia.com>, Keerthy <j-keerthy@ti.com>, dmitry.torokhov@gmail.com, peter@piie.net, dianders@chromium.org, Leo Yan <leo.yan@linaro.org>, cf@rock-chips.com
List-Id: linux-omap@vger.kernel.org

On =E4=BA=8C, 2016-06-21 at 09:42 +0800, Caesar Wang wrote:
> Do you have other ideas for the following patches? :-)=C2=A0
> Even if only took two weeks feel after a long time.
>=20
> 9157919 New=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [v5=
,1/5] thermal: Add support for hardware-
> tracked trip points
> 9157917 New=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [v5=
,2/5] thermal: of: implement .set_trips for
> device tree thermal zones
> 9161129 New=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [v5=
=2E1,3/5] thermal: streamline get_trend
> callbacks
> 9157929 New=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [v5=
,4/5] thermal: bang-bang governor: act on
> lower trip boundary
> 9157925 New=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [v5=
,5/5] thermal: rockchip: add the set_trips
> function
> ---
>=20
I have no objections to this patch set, except one change in patch 1/5.
But as this also touches of_thermal and rockchip thermal driver. I'd
leave this patch set for Eduardo to review and take.
BTW, Eduardo is traveling recently, so you may still need to wait some
time.

Thanks,
rui
>=20
> Caesar
>=20
> On 2016=E5=B9=B406=E6=9C=8806=E6=97=A5 19:44, Caesar Wang wrote:
> > Thank you all for providing inputs and comments on previous
> > versions of
> > this patchset.
> > Especially thanks to the (Mikko,Sascha,Eduardo,Javi,Steve....).
> >=20
> > The history patches come from Mikko and Sascha.
> > =C2=A0=C2=A0=C2=A0=C2=A0http://thread.gmane.org/gmane.linux.power-m=
anagement.general/59
> > 451
> >=20
> > Now, I pick them up to continue upstream.
> > Nevermind!
> >=20
> > This series history patches:
> > v4: https://lkml.org/lkml/2016/5/27/122
> > v3: https://lkml.org/lkml/2016/5/24/797
> > v2: https://lkml.org/lkml/2016/5/3/220
> > v1: https://lkml.org/lkml/2016/4/24/227
> >=20
> > This series adds support for hardware trip points. It picks up
> > earlier
> > work from Mikko Perttunen. Mikko implemented hardware trip points
> > as part
> > of the device tree support. It was suggested back then to move the
> > functionality to the thermal core instead of putting more code into
> > the
> > device tree support. This series does exactly that.
> >=20
> > This series patches rebase the conflicts with the lastest next
> > kernel.
> > Note that the hardware-tracked trip points are very well tested
> > currently.
> >=20
> > Verified and tested on https://github.com/Caesar-github/rockchip/tr
> > ee/wip/fixes-thermal-0606
> > That's based on the next kernel (4.7-rc2).
> > localhost / # cat /proc/version
> > Linux version 4.7.0-rc2-next-20160606-02546-g534926d (wxt@nb)
> > ---
> > There are five pathes in this series.
> > thermal: Add support for hardware-tracked trip point
> > thermal: of: implement .set_trips for device tree thermal zones
> > thermal: streamline get_trend callbacks
> > thermal: bang-bang governor: act on lower trip boundary
> > thermal: rockchip: add the set_trips function
> >=20
> > Note: the hardware-tracked trip points that the similar patches
> > were verified
> > on ChromoeOs platform.
> > e.g.:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/c
> > hromeos-3.14
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/c
> > hromeos-3.18
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/c
> > hromeos-4.4
> > ---
> >=20
> > Anyway, I take the lastest thermal change to test from next kernel,
> >=20
> > Tested on RK3399 SoCs on https://chromium.googlesource.com/chromium
> > os/third_party/kernel/+/chromeos-4.4
> > And
> > Tested on RK3288 SoCs with chromebook on next kernel.
> > localhost / # while true; do grep ""
> > /sys/class/thermal/thermal_zone[0-1]/temp; sleep .5; done
> > /sys/class/thermal/thermal_zone1/temp:45454
> > /sys/class/thermal/thermal_zone2/temp:44090
> > /sys/class/thermal/thermal_zone1/temp:44545
> > /sys/class/thermal/thermal_zone2/temp:44545
> > /sys/class/thermal/thermal_zone1/temp:45454
> > /sys/class/thermal/thermal_zone2/temp:44545
> > /sys/class/thermal/thermal_zone1/temp:45000
> > ...
> > Then add the loading,
> > localhost / # md5sum /dev/zero &
> > [3] 8354
> > ..
> > The Set trips trigger the hardware-tracked points.
> >=20
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 68461, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 2 - temp: 64166, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 75000
> > rockchip-thermal ff280000.tsadc: sensor 2 - temp: 66153, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 70000
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 68076, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 2 - temp: 65384, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 75000
> > rockchip-thermal ff280000.tsadc: sensor 2 - temp: 65384, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 70000
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70833, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 75000
> > rockchip-thermal ff280000.tsadc: sensor 2 - temp: 66153, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 70000
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70416, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 75000
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 70000
> > rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
> > rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor
> > 1: low: 68000, high 75000
> > ..
> > ---
> > Anyway, the series patches are verified on rockchip platform.
> >=20
> > Thanks someone are reviewing and testing for it.
> >=20
> > -Caesar
> >=20
> >=20
> > Changes in v5:
> > - add the lock for thermal_zone_set_trips function.
> > - change based on next kernel.
> > - add the tested by Steve.
> >=20
> > Changes in v4:
> > - Missing the lock added in v3.
> > - as the Javi comments, %s/implemnets/implements.
> >=20
> > Changes in v3:
> > - as Javi comments on https://patchwork.kernel.org/patch/9001281/.
> > - add the lock for preventing the called from multi placce
> > - add the note for pre_low/high_trip.
> > - as the Javi comments on https://patchwork.kernel.org/patch/900131
> > 1/.
> > - add the select if they set the option for devicetree.
> > - Add the peter's ACK.
> >=20
> > Changes in v2:
> > - update the sysfs-api.txt for set_trips.
> > - add the commit in patch[v2 2/5].
> > - Update the commit for patch[v2 4/5].
> >=20
> > Caesar Wang (1):
> > =C2=A0 thermal: rockchip: add the set_trips function
> >=20
> > Sascha Hauer (4):
> > =C2=A0 thermal: Add support for hardware-tracked trip points
> > =C2=A0 thermal: of: implement .set_trips for device tree thermal zo=
nes
> > =C2=A0 thermal: streamline get_trend callbacks
> > =C2=A0 thermal: bang-bang governor: act on lower trip boundary
> >=20
> > =C2=A0Documentation/thermal/sysfs-api.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A07 +++
> > =C2=A0drivers/thermal/gov_bang_bang.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > =C2=A0drivers/thermal/of-thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 30 ++++++++
> > ----
> > =C2=A0drivers/thermal/rockchip_thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 39
> > ++++++++++++++++
> > =C2=A0drivers/thermal/thermal_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 54
> > ++++++++++++++++++++++
> > =C2=A0drivers/thermal/thermal_sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A03 ++
> > =C2=A0drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++-=
-----
> > =C2=A0include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 16 ++++++-
> > =C2=A08 files changed, 147 insertions(+), 29 deletions(-)
> >=20
> =C2=A0
