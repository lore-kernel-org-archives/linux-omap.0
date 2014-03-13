From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Thu, 13 Mar 2014 22:34:42 +0000
Message-ID: <20140313223442.GB28504@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com>
 <20140311120259.GI21216@lee--X1>
 <531EFE97.1090202@ti.com>
 <20140311130715.GM21216@lee--X1>
 <531F0B49.2070008@ti.com>
 <20140311162428.GA7177@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140311162428.GA7177@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> > > That does mean I need a) all of the Maintainer Acks and b) you to=
 tell
> > > me which ones need to go through a single tree.
> >=20
> > You need to take patches 1 to 6 in the MFD tree. Out of these, patc=
hes 1 to 4
> > need to be shared with Tony as an immutable branch.
> >=20
> > Tony, could you please Ack patches 1 to 4? Thanks.
>=20
> Changes in 1 to 6 look OK to me, so for those please feel free to add=
:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

The following changes since commit 0414855fdc4a40da05221fc6062cccbc0c30=
f169:

  Linux 3.14-rc5 (2014-03-02 18:56:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-omap

for you to fetch changes up to 2e1b365cea4a0a750b8ffd4bc6ca5e9e8020f53e=
:

  mfd: omap-usb-tll: Update DT clock binding information (2014-03-13 22=
:27:17 +0000)

----------------------------------------------------------------
Colin Ian King (1):
      mfd: omap-usb-tll: Fix cppcheck sizeof warning

Roger Quadros (7):
      mfd: omap-usb-host: Use resource managed clk_get()
      mfd: omap-usb-host: Get clocks based on hardware revision
      mfd: omap-usb-host: Always fail on clk_get() error
      mfd: omap-usb-host: Use proper clock name instead of alias
      mfd: omap-usb-host: Use clock names as per function for reference=
 clocks
      mfd: omap-usb-host: Update DT clock binding information
      mfd: omap-usb-tll: Update DT clock binding information

 Documentation/devicetree/bindings/mfd/omap-usb-host.txt |  23 ++++++++=
++++++
 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt  |  10 ++++++
 arch/arm/boot/dts/omap4.dtsi                            |   6 ++++
 arch/arm/boot/dts/omap5.dtsi                            |   6 ++++
 arch/arm/mach-omap2/cclock3xxx_data.c                   |   4 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              |   6 ----
 drivers/clk/ti/clk-3xxx.c                               |   4 ---
 drivers/mfd/omap-usb-host.c                             | 189 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++--------------------------=
--------------------------------
 drivers/mfd/omap-usb-tll.c                              |   2 +-
 9 files changed, 136 insertions(+), 114 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
