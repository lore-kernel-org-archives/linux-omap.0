From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [RESEND PATCH v3 2/2] phy: Group vendor specific phy drivers
Date: Tue, 14 Mar 2017 13:35:57 +0530
Message-ID: <42126738-453a-555f-c3c1-48d30702af9b@codeaurora.org>
References: <1489472080-23711-2-git-send-email-vivek.gautam@codeaurora.org>
 <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
 <CAJKOXPcWKjis_dWtzJPWSZxVnRPYdsf+_uDzjCaCFOwyOLG2Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPcWKjis_dWtzJPWSZxVnRPYdsf+_uDzjCaCFOwyOLG2Gw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kishon@ti.com, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Krzysztof,


On 03/14/2017 12:14 PM, Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 8:22 AM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Also updated the MAINTAINERS file to reflect the correct
>> directory structure for phy drivers.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-usb@vger.kernel.org
>> ---
>>
>> Corrected Krzysztof's email-id. Added linux-arm-msm.
>>
>> Hi Heiko, Viresh,
>> It's been a year since the last version of this patch was posted.
>> Kishon has agreed to pull this change now. I am carrying forward
>> your Acks since there are no functional changes.
>> I have taken care of the drivers that were added/removed since
>> the last version.
>> Please feel free to jump in if you have any concerns.
>>
>> Changes since v2
>>   - Rebased on linux-phy/next.
>>   - Took care of drivers added/removed for each vendors since v2.
>>   - Updated the 'Signed-off-by' tag with my current email id.
>>
>> Changes from v1:
>>   - Updated the MAINTAINERS file to reflect the same change
>>     in directory structure.
>>   - Removed PHY_PLAT config as pointed out by Kishon.
>>     So we don't require the second patch in the v1 of this series:
>>     [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
>>   - Renamed sunxi --> allwinner; rcar --> renesas.
>>   - Fixed error coming with qcom Makefile.
>>
>> * Build tested multi_v7_defconfig.
>> * Build tested arm64 defconfig with all the involved configs enabled.
>>
>>   MAINTAINERS                                        |  18 +-
>>   drivers/phy/Kconfig                                | 471 +--------------------
>>   drivers/phy/Makefile                               |  67 +--
>>   drivers/phy/allwinner/Kconfig                      |  31 ++
>>   drivers/phy/allwinner/Makefile                     |   2 +
>>   drivers/phy/{ => allwinner}/phy-sun4i-usb.c        |   0
>>   drivers/phy/{ => allwinner}/phy-sun9i-usb.c        |   0
>>   drivers/phy/broadcom/Kconfig                       |  64 +++
>>   drivers/phy/broadcom/Makefile                      |   7 +
>>   drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c   |   0
>>   drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c     |   0
>>   drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c       |   0
>>   drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c       |   0
>>   drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c      |   0
>>   drivers/phy/{ => broadcom}/phy-bcm-nsp-usb3.c      |   0
>>   drivers/phy/{ => broadcom}/phy-brcm-sata.c         |   0
>>   drivers/phy/hisilicon/Kconfig                      |  20 +
>>   drivers/phy/hisilicon/Makefile                     |   2 +
>>   drivers/phy/{ => hisilicon}/phy-hi6220-usb.c       |   0
>>   drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c     |   0
>>   drivers/phy/marvell/Kconfig                        |  50 +++
>>   drivers/phy/marvell/Makefile                       |   6 +
>>   drivers/phy/{ => marvell}/phy-armada375-usb2.c     |   0
>>   drivers/phy/{ => marvell}/phy-berlin-sata.c        |   0
>>   drivers/phy/{ => marvell}/phy-berlin-usb.c         |   0
>>   drivers/phy/{ => marvell}/phy-mvebu-sata.c         |   0
>>   drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c      |   0
>>   drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c      |   0
>>   drivers/phy/qualcomm/Kconfig                       |  38 ++
>>   drivers/phy/qualcomm/Makefile                      |   7 +
>>   drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h        |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-ufs.c          |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c       |   0
>>   drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c     |   0
>>   drivers/phy/renesas/Kconfig                        |  17 +
>>   drivers/phy/renesas/Makefile                       |   2 +
>>   drivers/phy/{ => renesas}/phy-rcar-gen2.c          |   0
>>   drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c     |   0
>>   drivers/phy/rockchip/Kconfig                       |  51 +++
>>   drivers/phy/rockchip/Makefile                      |   6 +
>>   drivers/phy/{ => rockchip}/phy-rockchip-dp.c       |   0
>>   drivers/phy/{ => rockchip}/phy-rockchip-emmc.c     |   0
>>   .../phy/{ => rockchip}/phy-rockchip-inno-usb2.c    |   0
>>   drivers/phy/{ => rockchip}/phy-rockchip-pcie.c     |   0
>>   drivers/phy/{ => rockchip}/phy-rockchip-typec.c    |   0
>>   drivers/phy/{ => rockchip}/phy-rockchip-usb.c      |   0
>>   drivers/phy/samsung/Kconfig                        |  96 +++++
>>   drivers/phy/samsung/Makefile                       |  11 +
>>   drivers/phy/{ => samsung}/phy-exynos-dp-video.c    |   0
>>   drivers/phy/{ => samsung}/phy-exynos-mipi-video.c  |   0
>>   drivers/phy/{ => samsung}/phy-exynos-pcie.c        |   0
>>   drivers/phy/{ => samsung}/phy-exynos4210-usb2.c    |   0
>>   drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c    |   0
>>   drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c     |   0
>>   drivers/phy/{ => samsung}/phy-exynos5250-sata.c    |   0
>>   drivers/phy/{ => samsung}/phy-exynos5250-usb2.c    |   0
>>   drivers/phy/{ => samsung}/phy-s5pv210-usb2.c       |   0
>>   drivers/phy/{ => samsung}/phy-samsung-usb2.c       |   0
>>   drivers/phy/{ => samsung}/phy-samsung-usb2.h       |   0
>>   drivers/phy/st/Kconfig                             |  33 ++
>>   drivers/phy/st/Makefile                            |   4 +
>>   drivers/phy/{ => st}/phy-miphy28lp.c               |   0
>>   drivers/phy/{ => st}/phy-spear1310-miphy.c         |   0
>>   drivers/phy/{ => st}/phy-spear1340-miphy.c         |   0
>>   drivers/phy/{ => st}/phy-stih407-usb.c             |   0
>>   drivers/phy/ti/Kconfig                             |  78 ++++
>>   drivers/phy/ti/Makefile                            |   7 +
>>   drivers/phy/{ => ti}/phy-da8xx-usb.c               |   0
>>   drivers/phy/{ => ti}/phy-dm816x-usb.c              |   0
>>   drivers/phy/{ => ti}/phy-omap-control.c            |   0
>>   drivers/phy/{ => ti}/phy-omap-usb2.c               |   0
>>   drivers/phy/{ => ti}/phy-ti-pipe3.c                |   0
>>   drivers/phy/{ => ti}/phy-tusb1210.c                |   0
>>   drivers/phy/{ => ti}/phy-twl4030-usb.c             |   0
>>   80 files changed, 567 insertions(+), 521 deletions(-)
>>   create mode 100644 drivers/phy/allwinner/Kconfig
>>   create mode 100644 drivers/phy/allwinner/Makefile
>>   rename drivers/phy/{ => allwinner}/phy-sun4i-usb.c (100%)
>>   rename drivers/phy/{ => allwinner}/phy-sun9i-usb.c (100%)
>>   create mode 100644 drivers/phy/broadcom/Kconfig
>>   create mode 100644 drivers/phy/broadcom/Makefile
>>   rename drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-bcm-nsp-usb3.c (100%)
>>   rename drivers/phy/{ => broadcom}/phy-brcm-sata.c (100%)
>>   create mode 100644 drivers/phy/hisilicon/Kconfig
>>   create mode 100644 drivers/phy/hisilicon/Makefile
>>   rename drivers/phy/{ => hisilicon}/phy-hi6220-usb.c (100%)
>>   rename drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c (100%)
>>   create mode 100644 drivers/phy/marvell/Kconfig
>>   create mode 100644 drivers/phy/marvell/Makefile
>>   rename drivers/phy/{ => marvell}/phy-armada375-usb2.c (100%)
>>   rename drivers/phy/{ => marvell}/phy-berlin-sata.c (100%)
>>   rename drivers/phy/{ => marvell}/phy-berlin-usb.c (100%)
>>   rename drivers/phy/{ => marvell}/phy-mvebu-sata.c (100%)
>>   rename drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c (100%)
>>   rename drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c (100%)
>>   create mode 100644 drivers/phy/qualcomm/Kconfig
>>   create mode 100644 drivers/phy/qualcomm/Makefile
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-ufs.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c (100%)
>>   rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c (100%)
>>   create mode 100644 drivers/phy/renesas/Kconfig
>>   create mode 100644 drivers/phy/renesas/Makefile
>>   rename drivers/phy/{ => renesas}/phy-rcar-gen2.c (100%)
>>   rename drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c (100%)
>>   create mode 100644 drivers/phy/rockchip/Kconfig
>>   create mode 100644 drivers/phy/rockchip/Makefile
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-dp.c (100%)
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-emmc.c (100%)
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-inno-usb2.c (100%)
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-pcie.c (100%)
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-typec.c (100%)
>>   rename drivers/phy/{ => rockchip}/phy-rockchip-usb.c (100%)
>>   create mode 100644 drivers/phy/samsung/Kconfig
>>   create mode 100644 drivers/phy/samsung/Makefile
>>   rename drivers/phy/{ => samsung}/phy-exynos-dp-video.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos-mipi-video.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos-pcie.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos4210-usb2.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos5250-sata.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-exynos5250-usb2.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-s5pv210-usb2.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-samsung-usb2.c (100%)
>>   rename drivers/phy/{ => samsung}/phy-samsung-usb2.h (100%)
>>   create mode 100644 drivers/phy/st/Kconfig
>>   create mode 100644 drivers/phy/st/Makefile
>>   rename drivers/phy/{ => st}/phy-miphy28lp.c (100%)
>>   rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>>   rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>>   rename drivers/phy/{ => st}/phy-stih407-usb.c (100%)
>>   create mode 100644 drivers/phy/ti/Kconfig
>>   create mode 100644 drivers/phy/ti/Makefile
>>   rename drivers/phy/{ => ti}/phy-da8xx-usb.c (100%)
>>   rename drivers/phy/{ => ti}/phy-dm816x-usb.c (100%)
>>   rename drivers/phy/{ => ti}/phy-omap-control.c (100%)
>>   rename drivers/phy/{ => ti}/phy-omap-usb2.c (100%)
>>   rename drivers/phy/{ => ti}/phy-ti-pipe3.c (100%)
>>   rename drivers/phy/{ => ti}/phy-tusb1210.c (100%)
>>   rename drivers/phy/{ => ti}/phy-twl4030-usb.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c776906f67a9..22583a160fa5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1814,8 +1814,8 @@ F:        drivers/i2c/busses/i2c-st.c
>>   F:     drivers/media/rc/st_rc.c
>>   F:     drivers/media/platform/sti/c8sectpfe/
>>   F:     drivers/mmc/host/sdhci-st.c
>> -F:     drivers/phy/phy-miphy28lp.c
>> -F:     drivers/phy/phy-stih407-usb.c
>> +F:     drivers/phy/st/phy-miphy28lp.c
>> +F:     drivers/phy/st/phy-stih407-usb.c
>>   F:     drivers/pinctrl/pinctrl-st.c
>>   F:     drivers/remoteproc/st_remoteproc.c
>>   F:     drivers/remoteproc/st_slim_rproc.c
>> @@ -10637,7 +10637,7 @@ RENESAS USB2 PHY DRIVER
>>   M:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>   L:     linux-renesas-soc@vger.kernel.org
>>   S:     Maintained
>> -F:     drivers/phy/phy-rcar-gen3-usb2.c
>> +F:     drivers/phy/renesas/phy-rcar-gen3-usb2.c
>>
>>   RESET CONTROLLER FRAMEWORK
>>   M:     Philipp Zabel <p.zabel@pengutronix.de>
>> @@ -11011,12 +11011,12 @@ L:    linux-kernel@vger.kernel.org
>>   S:     Supported
>>   F:     Documentation/devicetree/bindings/phy/samsung-phy.txt
>>   F:     Documentation/phy/samsung-usb2.txt
>> -F:     drivers/phy/phy-exynos4210-usb2.c
>> -F:     drivers/phy/phy-exynos4x12-usb2.c
>> -F:     drivers/phy/phy-exynos5250-usb2.c
>> -F:     drivers/phy/phy-s5pv210-usb2.c
>> -F:     drivers/phy/phy-samsung-usb2.c
>> -F:     drivers/phy/phy-samsung-usb2.h
>> +F:     drivers/phy/samsung/phy-exynos4210-usb2.c
>> +F:     drivers/phy/samsung/phy-exynos4x12-usb2.c
>> +F:     drivers/phy/samsung/phy-exynos5250-usb2.c
>> +F:     drivers/phy/samsung/phy-s5pv210-usb2.c
>> +F:     drivers/phy/samsung/phy-samsung-usb2.c
>> +F:     drivers/phy/samsung/phy-samsung-usb2.h
> Or this could be "drivers/phy/samsung/" so it would include all
> drivers (if that is desired)?
>
> I am fine with both, so:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the Ack.
I am also fine with both. Sylwester can comment on this since there are
couple of drivers apart from this list.
I am cool with phy-exynos5-usbdrd.c driver that I wrote. :-)

Best Regards
Vivek

>
> Best regards,
> Krzysztof

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
