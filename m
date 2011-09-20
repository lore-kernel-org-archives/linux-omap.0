From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/5] [media] v4l: Add mt9t111 sensor driver
Date: Tue, 20 Sep 2011 17:09:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109201704190.11274@axis700.grange>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
 <1316530612-23075-3-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1316530612-23075-3-git-send-email-deepthy.ravi@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Deepthy Ravi <deepthy.ravi@ti.com>
Cc: laurent.pinchart@ideasonboard.com, mchehab@infradead.org, tony@atomide.com, hvaibhav@ti.com, linux-media@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, hverkuil@xs4all.nl, m.szyprowski@samsung.com, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, david.woodhouse@intel.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Sep 2011, Deepthy Ravi wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>=20
> The MT9T111 is a 3.1Mp CMOS sensor from Aptina with
> its latest image signal processing (ISP) and 1.75=CE=BCm
> pixel technology.
> The sensor driver currently supports only VGA
> resolution.
>=20
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
> ---
>  drivers/media/video/Kconfig       |    7 +
>  drivers/media/video/Makefile      |    1 +
>  drivers/media/video/mt9t111.c     |  793 +++++++++++++++++++++
>  drivers/media/video/mt9t111_reg.h | 1367 +++++++++++++++++++++++++++=
++++++++++
>  include/media/mt9t111.h           |   45 ++
>  5 files changed, 2213 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/mt9t111.c
>  create mode 100644 drivers/media/video/mt9t111_reg.h
>  create mode 100644 include/media/mt9t111.h

NAK. The mt9t112 driver claims to also support mt9t111. I'm not sure,=20
whether the driver has indeed been tested with mt9t111, but this is=20
definitely something to verify. If the chips are indeed similar, please=
=20
use the tree at

http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/shortlog/refs/heads/rc=
1-for-3.2

which has converted the mt9t112 driver to be also used outside ot the=20
soc-camera subsystem, and use that driver instead of adding another one=
=2E

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
