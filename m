From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Fri, 1 Apr 2016 06:35:28 -0700
Message-ID: <CAFp+6iEJAq6CzntpM-RXYN8NwtHUUJoFHFf17mdV4nLE8eJwyA@mail.gmail.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
	<56FE7234.5000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56FE7234.5000505@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vivek Gautam <gautam.vivek@samsung.com>, vireshk@kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, spear-devel@list.st.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, CPGS <cpgs@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,


On Fri, Apr 1, 2016 at 6:05 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Friday 01 April 2016 04:59 PM, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>
>> With growing number of phy drivers, it makes sense to
>> group these drivers under their respective vendor/platform
>> umbrella directory.
>>
>> Build-tested 'multi_v7_defconfig'.
>>
>>  drivers/phy/Kconfig                               | 386 +---------------------
>>  drivers/phy/Makefile                              |  57 +---
>>  drivers/phy/bcom/Kconfig                          |  27 ++
>>  drivers/phy/bcom/Makefile                         |   3 +
>>  drivers/phy/{ => bcom}/phy-bcm-cygnus-pcie.c      |   0
>>  drivers/phy/{ => bcom}/phy-bcm-kona-usb2.c        |   0
>>  drivers/phy/{ => bcom}/phy-brcmstb-sata.c         |   0
>>  drivers/phy/hisi/Kconfig                          |  20 ++
>>  drivers/phy/hisi/Makefile                         |   2 +
>>  drivers/phy/{ => hisi}/phy-hi6220-usb.c           |   0
>>  drivers/phy/{ => hisi}/phy-hix5hd2-sata.c         |   0
>>  drivers/phy/marvell/Kconfig                       |  50 +++
>>  drivers/phy/marvell/Makefile                      |   6 +
>>  drivers/phy/{ => marvell}/phy-armada375-usb2.c    |   0
>>  drivers/phy/{ => marvell}/phy-berlin-sata.c       |   0
>>  drivers/phy/{ => marvell}/phy-berlin-usb.c        |   0
>>  drivers/phy/{ => marvell}/phy-mvebu-sata.c        |   0
>>  drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c     |   0
>>  drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c     |   0
>>  drivers/phy/qcom/Kconfig                          |  23 ++
>>  drivers/phy/qcom/Makefile                         |   5 +
>>  drivers/phy/{ => qcom}/phy-qcom-apq8064-sata.c    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ipq806x-sata.c    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs-i.h           |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.c    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.h    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.c    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.h    |   0
>>  drivers/phy/{ => qcom}/phy-qcom-ufs.c             |   0
>>  drivers/phy/rcar/Kconfig                          |  16 +
>>  drivers/phy/rcar/Makefile                         |   2 +
>>  drivers/phy/{ => rcar}/phy-rcar-gen2.c            |   0
>>  drivers/phy/{ => rcar}/phy-rcar-gen3-usb2.c       |   0
>>  drivers/phy/rockchip/Kconfig                      |  23 ++
>>  drivers/phy/rockchip/Makefile                     |   3 +
>>  drivers/phy/{ => rockchip}/phy-rockchip-dp.c      |   0
>>  drivers/phy/{ => rockchip}/phy-rockchip-emmc.c    |   0
>>  drivers/phy/{ => rockchip}/phy-rockchip-usb.c     |   0
>>  drivers/phy/samsung/Kconfig                       |  87 +++++
>>  drivers/phy/samsung/Makefile                      |  10 +
>>  drivers/phy/{ => samsung}/phy-exynos-dp-video.c   |   0
>>  drivers/phy/{ => samsung}/phy-exynos-mipi-video.c |   0
>>  drivers/phy/{ => samsung}/phy-exynos4210-usb2.c   |   0
>>  drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c   |   0
>>  drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c    |   0
>>  drivers/phy/{ => samsung}/phy-exynos5250-sata.c   |   0
>>  drivers/phy/{ => samsung}/phy-exynos5250-usb2.c   |   0
>>  drivers/phy/{ => samsung}/phy-s5pv210-usb2.c      |   0
>>  drivers/phy/{ => samsung}/phy-samsung-usb2.c      |   0
>>  drivers/phy/{ => samsung}/phy-samsung-usb2.h      |   0
>>  drivers/phy/st/Kconfig                            |  51 +++
>>  drivers/phy/st/Makefile                           |   6 +
>>  drivers/phy/{ => st}/phy-miphy28lp.c              |   0
>>  drivers/phy/{ => st}/phy-miphy365x.c              |   0
>>  drivers/phy/{ => st}/phy-spear1310-miphy.c        |   0
>>  drivers/phy/{ => st}/phy-spear1340-miphy.c        |   0
>>  drivers/phy/{ => st}/phy-stih407-usb.c            |   0
>>  drivers/phy/{ => st}/phy-stih41x-usb.c            |   0
>>  drivers/phy/sunxi/Kconfig                         |  28 ++
>>  drivers/phy/sunxi/Makefile                        |   2 +
>>  drivers/phy/{ => sunxi}/phy-sun4i-usb.c           |   0
>>  drivers/phy/{ => sunxi}/phy-sun9i-usb.c           |   0
>>  drivers/phy/ti/Kconfig                            |  67 ++++
>>  drivers/phy/ti/Makefile                           |   6 +
>>  drivers/phy/{ => ti}/phy-dm816x-usb.c             |   0
>>  drivers/phy/{ => ti}/phy-omap-control.c           |   0
>>  drivers/phy/{ => ti}/phy-omap-usb2.c              |   0
>>  drivers/phy/{ => ti}/phy-ti-pipe3.c               |   0
>>  drivers/phy/{ => ti}/phy-tusb1210.c               |   0
>>  drivers/phy/{ => ti}/phy-twl4030-usb.c            |   0
>>  drivers/phy/{ => ti}/ulpi_phy.h                   |   0
>
> ulpi_phy.h is not specific to TI though at this point tusb1210 is the only ULPI
> driver.

Yes, you are right. But i was hesitant to add a multi-level header
file include in the phy driver
which uses it.

Does it makes sense to move this ulpi_phy.h to include/linux/phy ?

>>  71 files changed, 464 insertions(+), 416 deletions(-)
>>  create mode 100644 drivers/phy/bcom/Kconfig
>>  create mode 100644 drivers/phy/bcom/Makefile
>>  rename drivers/phy/{ => bcom}/phy-bcm-cygnus-pcie.c (100%)
>>  rename drivers/phy/{ => bcom}/phy-bcm-kona-usb2.c (100%)
>>  rename drivers/phy/{ => bcom}/phy-brcmstb-sata.c (100%)
>>  create mode 100644 drivers/phy/hisi/Kconfig
>>  create mode 100644 drivers/phy/hisi/Makefile
>>  rename drivers/phy/{ => hisi}/phy-hi6220-usb.c (100%)
>>  rename drivers/phy/{ => hisi}/phy-hix5hd2-sata.c (100%)
>>  create mode 100644 drivers/phy/marvell/Kconfig
>>  create mode 100644 drivers/phy/marvell/Makefile
>>  rename drivers/phy/{ => marvell}/phy-armada375-usb2.c (100%)
>>  rename drivers/phy/{ => marvell}/phy-berlin-sata.c (100%)
>>  rename drivers/phy/{ => marvell}/phy-berlin-usb.c (100%)
>>  rename drivers/phy/{ => marvell}/phy-mvebu-sata.c (100%)
>>  rename drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c (100%)
>>  rename drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c (100%)
>>  create mode 100644 drivers/phy/qcom/Kconfig
>>  create mode 100644 drivers/phy/qcom/Makefile
>>  rename drivers/phy/{ => qcom}/phy-qcom-apq8064-sata.c (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ipq806x-sata.c (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-i.h (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.c (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.h (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.c (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.h (100%)
>>  rename drivers/phy/{ => qcom}/phy-qcom-ufs.c (100%)
>>  create mode 100644 drivers/phy/rcar/Kconfig
>>  create mode 100644 drivers/phy/rcar/Makefile
>>  rename drivers/phy/{ => rcar}/phy-rcar-gen2.c (100%)
>>  rename drivers/phy/{ => rcar}/phy-rcar-gen3-usb2.c (100%)
>>  create mode 100644 drivers/phy/rockchip/Kconfig
>>  create mode 100644 drivers/phy/rockchip/Makefile
>>  rename drivers/phy/{ => rockchip}/phy-rockchip-dp.c (100%)
>>  rename drivers/phy/{ => rockchip}/phy-rockchip-emmc.c (100%)
>>  rename drivers/phy/{ => rockchip}/phy-rockchip-usb.c (100%)
>>  create mode 100644 drivers/phy/samsung/Kconfig
>>  create mode 100644 drivers/phy/samsung/Makefile
>>  rename drivers/phy/{ => samsung}/phy-exynos-dp-video.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos-mipi-video.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos4210-usb2.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos5250-sata.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-exynos5250-usb2.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-s5pv210-usb2.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-samsung-usb2.c (100%)
>>  rename drivers/phy/{ => samsung}/phy-samsung-usb2.h (100%)
>>  create mode 100644 drivers/phy/st/Kconfig
>>  create mode 100644 drivers/phy/st/Makefile
>>  rename drivers/phy/{ => st}/phy-miphy28lp.c (100%)
>>  rename drivers/phy/{ => st}/phy-miphy365x.c (100%)
>>  rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>>  rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>>  rename drivers/phy/{ => st}/phy-stih407-usb.c (100%)
>>  rename drivers/phy/{ => st}/phy-stih41x-usb.c (100%)
>>  create mode 100644 drivers/phy/sunxi/Kconfig
>>  create mode 100644 drivers/phy/sunxi/Makefile
>>  rename drivers/phy/{ => sunxi}/phy-sun4i-usb.c (100%)
>>  rename drivers/phy/{ => sunxi}/phy-sun9i-usb.c (100%)
>>  create mode 100644 drivers/phy/ti/Kconfig
>>  create mode 100644 drivers/phy/ti/Makefile
>>  rename drivers/phy/{ => ti}/phy-dm816x-usb.c (100%)
>>  rename drivers/phy/{ => ti}/phy-omap-control.c (100%)
>>  rename drivers/phy/{ => ti}/phy-omap-usb2.c (100%)
>>  rename drivers/phy/{ => ti}/phy-ti-pipe3.c (100%)
>>  rename drivers/phy/{ => ti}/phy-tusb1210.c (100%)
>>  rename drivers/phy/{ => ti}/phy-twl4030-usb.c (100%)
>>  rename drivers/phy/{ => ti}/ulpi_phy.h (100%)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 26566db..80c8c68 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -15,45 +15,6 @@ config GENERIC_PHY
>>         phy users can obtain reference to the PHY. All the users of this
>>         framework should select this config.
>>
>
>> +menuconfig PHY_PLAT
>> +     bool "Platform Phy drivers"
>
> Not really convinced about adding a new config here. This will create new
> dependencies and will also start breaking users of oldconfig.

This serves including all the directory paths in the 'make' for
driver/phy/Makefile.

Otherwise each directory will have to be built as per particular platform
And, not all drivers of a vendor are built for one-kind of platform,
for example, Samsung uses ARCH_EXYNOS, as well as ARCH_S5PV210
Similarly, Broadcom phy drivers are based on multiple platforms, and so
does Marvell's.

Please suggest a concise way to include the vendor directories in the build path
in drivers/phy/Makefile.

>
> Also not all of them are platform drivers (e.g ULPI PHY drivers).
I Think this applies to ulpi_phy only at this moment, which we can resolve
by moving that to include/linux path.

>
> Thanks
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
