From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL for 4.4] DT/dmaengine: edma: Update for the new bindings
Date: Wed, 9 Dec 2015 13:10:18 +0200
Message-ID: <56680C1A.3050009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Arnd, Vinod,

As Arnd suggested, the two patch from the following series:
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122201.html

plus Acked-by from Arnd is available for pull if you prefer that way.


Regards,
P=C3=A9ter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d713=
0bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/omap-audio/linux-audio.git for-4.4/peter/edma_bind=
ing_update

for you to fetch changes up to af9089852e0ecd6ae7336992d29b04d7d82b404a=
:

  dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit t=
ype (2015-12-09 11:56:56 +0200)

----------------------------------------------------------------
Peter Ujfalusi (2):
      dmaengine: edma: DT: Change memcpy channel array from 16bit to 32=
bit type
      dmaengine: edma: DT: Change reserved slot array from 16bit to 32b=
it type

 Documentation/devicetree/bindings/dma/ti-edma.txt | 10 ++++------
 drivers/dma/edma.c                                | 53 +++++++++++++++=
++++++++++++++++++++------------------
 include/linux/platform_data/edma.h                |  2 +-
 3 files changed, 40 insertions(+), 25 deletions(-)
