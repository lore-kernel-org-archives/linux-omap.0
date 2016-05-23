From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 0/5] Thermal: Support for hardware-tracked trip points
Date: Mon, 23 May 2016 15:32:39 +0800
Message-ID: <5742B217.4080405@gmail.com>
References: <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, smbarber@google.com, Durgadoss R <durgadoss.r@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-rockchip@lists.infradead.org, briannorris@google.com, Andy Champ <andycham@amazon.com>, huangtao@rock-chips.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Javi Merino <javi.merino@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ni Wade <wni@nvidia.com>, Keerthy <j-keerthy@ti.com>, dmitry.torokhov@gmail.com, dianders@chromium.org, Leo Yan <leo.yan@linaro.org>, cf@rock-chips.com
List-Id: linux-omap@vger.kernel.org

Hello Eduardo & 'Zhang Rui'

Do we have the chance to merge this series patches for next kernel?
I had picked them up in my github, and tested for a period of time with=
=20
rockchip inside kernel.

Let me know if someone have some suggestions or against opinios.
Thanks,

-Caesar
On 2016=E5=B9=B405=E6=9C=8803=E6=97=A5 17:33, Caesar Wang wrote:
> The history patches come from Mikko and Sascha.
> http://thread.gmane.org/gmane.linux.power-management.general/59451
>
> Now, I pick them up to continue upstream.
> Nevermind!
>
> This series history patches:
> v1: https://lkml.org/lkml/2016/4/24/227
>
> This series adds support for hardware trip points. It picks up earlie=
r
> work from Mikko Perttunen. Mikko implemented hardware trip points as =
part
> of the device tree support. It was suggested back then to move the
> functionality to the thermal core instead of putting more code into t=
he
> device tree support. This series does exactly that.
>
> This series patches rebase the conflicts.
> Note that the hardware-tracked trip points are very well tested curre=
ntly.
>
> Verified and tested on https://github.com/Caesar-github/rockchip/tree=
/wip/fixes-thermal-0503
> That's based on linux-kernel 20160502.
> .Linux version 4.6.0-rc6-next-20160502-08922-g860ed34 (wxt@nb)
>
>
> Changes in v2:
> - update the sysfs-api.txt for set_trips
> - add the commit in patch[v2 2/5].
> - Update the commit for patch[v2 4/5].
>
> Caesar Wang (1):
>    thermal: rockchip: add the set_trips function
>
> Sascha Hauer (4):
>    thermal: Add support for hardware-tracked trip points
>    thermal: of: implement .set_trips for device tree thermal zones
>    thermal: streamline get_trend callbacks
>    thermal: bang-bang governor: act on lower trip boundary
>
>   Documentation/thermal/sysfs-api.txt                |  7 +++
>   drivers/thermal/gov_bang_bang.c                    |  2 +-
>   drivers/thermal/of-thermal.c                       | 23 +++++-----
>   drivers/thermal/rockchip_thermal.c                 | 39 +++++++++++=
+++++
>   drivers/thermal/thermal_core.c                     | 52 +++++++++++=
+++++++++++
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++-------
>   include/linux/thermal.h                            |  9 +++-
>   7 files changed, 128 insertions(+), 29 deletions(-)
>

