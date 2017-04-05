From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 0/3] phy: Group phy drivers based on vendor listing
Date: Wed, 5 Apr 2017 17:14:01 +0530
Message-ID: <7f917bf4-8cef-aaa8-8ecc-39b24ac42959@codeaurora.org>
References: <1490015997-12956-1-git-send-email-vivek.gautam@codeaurora.org>
 <05b651c2-a634-b092-cd40-8ba9851ca6d0@ti.com>
 <58ee3286-3894-f11a-47f3-a77d7dc43945@codeaurora.org>
 <d760f11e-6874-cdf2-3ec1-ef38a9d44f9a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <d760f11e-6874-cdf2-3ec1-ef38a9d44f9a-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 04/05/2017 05:12 PM, Kishon Vijay Abraham I wrote:
> Hi Vivek,
>
> On Wednesday 05 April 2017 05:07 PM, Vivek Gautam wrote:
>> Hi Kishon,
>>
>>
>> On 04/05/2017 04:34 PM, Kishon Vijay Abraham I wrote:
>>> Hi Vivek,
>>>
>>> On Monday 20 March 2017 06:49 PM, Vivek Gautam wrote:
>>>> This is the next version to an earlier posted series [1].
>>>> Missed Cc'ing the first patch of the previous series [1] to lkml.
>>>> Posting out this series now after addressing comments
>>>> and after adding the received 'Acked-by' and 'Reviewed-by'
>>>> tags.
>>>>
>>>> This series is based on linux-phy/next branch.
>>>>
>>>> [1] https://www.spinics.net/lists/arm-kernel/msg568370.html
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> The best time to merge this would be immediately after -rc1 is tagged. Can you
>>> resend when 4.12-rc1 is tagged?
>> Sure, I will send the series when 4.12-rc1 is out.
>> I am also planning to send qcom phy's next version and i had rebased the
>> earlier version on this patch series. Should i just rebase those patches on
>> top of phy/next, or on this series?
> phy/next please..

Okay, thanks

-
Vivek
>
> -Kishon
>
>>
>> Best Regards
>> Vivek
>>
>>> Thanks
>>> Kishon
>>>
>>>> -- 
>>>> Vivek Gautam (3):
>>>>     phy: qcom-usb: Remove unused ulpi phy header
>>>>     phy: Move ULPI phy header out of drivers to include path
>>>>     phy: Group vendor specific phy drivers
>>>>
>>>>    MAINTAINERS                                        |  18 +-
>>>>    drivers/phy/Kconfig                                | 471
>>>> +--------------------
>>>>    drivers/phy/Makefile                               |  67 +--
>>>>    drivers/phy/allwinner/Kconfig                      |  31 ++
>>>>    drivers/phy/allwinner/Makefile                     |   2 +
>>>>    drivers/phy/{ => allwinner}/phy-sun4i-usb.c        |   0
>>>>    drivers/phy/{ => allwinner}/phy-sun9i-usb.c        |   0
>>>>    drivers/phy/broadcom/Kconfig                       |  64 +++
>>>>    drivers/phy/broadcom/Makefile                      |   7 +
>>>>    drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c   |   0
>>>>    drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c     |   0
>>>>    drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c       |   0
>>>>    drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c       |   0
>>>>    drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c      |   0
>>>>    drivers/phy/{ => broadcom}/phy-bcm-nsp-usb3.c      |   0
>>>>    drivers/phy/{ => broadcom}/phy-brcm-sata.c         |   0
>>>>    drivers/phy/hisilicon/Kconfig                      |  20 +
>>>>    drivers/phy/hisilicon/Makefile                     |   2 +
>>>>    drivers/phy/{ => hisilicon}/phy-hi6220-usb.c       |   0
>>>>    drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c     |   0
>>>>    drivers/phy/marvell/Kconfig                        |  50 +++
>>>>    drivers/phy/marvell/Makefile                       |   6 +
>>>>    drivers/phy/{ => marvell}/phy-armada375-usb2.c     |   0
>>>>    drivers/phy/{ => marvell}/phy-berlin-sata.c        |   0
>>>>    drivers/phy/{ => marvell}/phy-berlin-usb.c         |   0
>>>>    drivers/phy/{ => marvell}/phy-mvebu-sata.c         |   0
>>>>    drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c      |   0
>>>>    drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c      |   0
>>>>    drivers/phy/qualcomm/Kconfig                       |  38 ++
>>>>    drivers/phy/qualcomm/Makefile                      |   7 +
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h        |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-ufs.c          |   0
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c       |   2 -
>>>>    drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c     |   2 -
>>>>    drivers/phy/renesas/Kconfig                        |  17 +
>>>>    drivers/phy/renesas/Makefile                       |   2 +
>>>>    drivers/phy/{ => renesas}/phy-rcar-gen2.c          |   0
>>>>    drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c     |   0
>>>>    drivers/phy/rockchip/Kconfig                       |  51 +++
>>>>    drivers/phy/rockchip/Makefile                      |   6 +
>>>>    drivers/phy/{ => rockchip}/phy-rockchip-dp.c       |   0
>>>>    drivers/phy/{ => rockchip}/phy-rockchip-emmc.c     |   0
>>>>    .../phy/{ => rockchip}/phy-rockchip-inno-usb2.c    |   0
>>>>    drivers/phy/{ => rockchip}/phy-rockchip-pcie.c     |   0
>>>>    drivers/phy/{ => rockchip}/phy-rockchip-typec.c    |   0
>>>>    drivers/phy/{ => rockchip}/phy-rockchip-usb.c      |   0
>>>>    drivers/phy/samsung/Kconfig                        |  96 +++++
>>>>    drivers/phy/samsung/Makefile                       |  11 +
>>>>    drivers/phy/{ => samsung}/phy-exynos-dp-video.c    |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos-mipi-video.c  |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos-pcie.c        |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos4210-usb2.c    |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c    |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c     |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos5250-sata.c    |   0
>>>>    drivers/phy/{ => samsung}/phy-exynos5250-usb2.c    |   0
>>>>    drivers/phy/{ => samsung}/phy-s5pv210-usb2.c       |   0
>>>>    drivers/phy/{ => samsung}/phy-samsung-usb2.c       |   0
>>>>    drivers/phy/{ => samsung}/phy-samsung-usb2.h       |   0
>>>>    drivers/phy/st/Kconfig                             |  33 ++
>>>>    drivers/phy/st/Makefile                            |   4 +
>>>>    drivers/phy/{ => st}/phy-miphy28lp.c               |   0
>>>>    drivers/phy/{ => st}/phy-spear1310-miphy.c         |   0
>>>>    drivers/phy/{ => st}/phy-spear1340-miphy.c         |   0
>>>>    drivers/phy/{ => st}/phy-stih407-usb.c             |   0
>>>>    drivers/phy/ti/Kconfig                             |  78 ++++
>>>>    drivers/phy/ti/Makefile                            |   7 +
>>>>    drivers/phy/{ => ti}/phy-da8xx-usb.c               |   0
>>>>    drivers/phy/{ => ti}/phy-dm816x-usb.c              |   0
>>>>    drivers/phy/{ => ti}/phy-omap-control.c            |   0
>>>>    drivers/phy/{ => ti}/phy-omap-usb2.c               |   0
>>>>    drivers/phy/{ => ti}/phy-ti-pipe3.c                |   0
>>>>    drivers/phy/{ => ti}/phy-tusb1210.c                |   3 +-
>>>>    drivers/phy/{ => ti}/phy-twl4030-usb.c             |   0
>>>>    {drivers => include/linux}/phy/ulpi_phy.h          |   0
>>>>    81 files changed, 568 insertions(+), 527 deletions(-)
>>>>    create mode 100644 drivers/phy/allwinner/Kconfig
>>>>    create mode 100644 drivers/phy/allwinner/Makefile
>>>>    rename drivers/phy/{ => allwinner}/phy-sun4i-usb.c (100%)
>>>>    rename drivers/phy/{ => allwinner}/phy-sun9i-usb.c (100%)
>>>>    create mode 100644 drivers/phy/broadcom/Kconfig
>>>>    create mode 100644 drivers/phy/broadcom/Makefile
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-bcm-nsp-usb3.c (100%)
>>>>    rename drivers/phy/{ => broadcom}/phy-brcm-sata.c (100%)
>>>>    create mode 100644 drivers/phy/hisilicon/Kconfig
>>>>    create mode 100644 drivers/phy/hisilicon/Makefile
>>>>    rename drivers/phy/{ => hisilicon}/phy-hi6220-usb.c (100%)
>>>>    rename drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c (100%)
>>>>    create mode 100644 drivers/phy/marvell/Kconfig
>>>>    create mode 100644 drivers/phy/marvell/Makefile
>>>>    rename drivers/phy/{ => marvell}/phy-armada375-usb2.c (100%)
>>>>    rename drivers/phy/{ => marvell}/phy-berlin-sata.c (100%)
>>>>    rename drivers/phy/{ => marvell}/phy-berlin-usb.c (100%)
>>>>    rename drivers/phy/{ => marvell}/phy-mvebu-sata.c (100%)
>>>>    rename drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c (100%)
>>>>    rename drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c (100%)
>>>>    create mode 100644 drivers/phy/qualcomm/Kconfig
>>>>    create mode 100644 drivers/phy/qualcomm/Makefile
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-ufs.c (100%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c (99%)
>>>>    rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c (99%)
>>>>    create mode 100644 drivers/phy/renesas/Kconfig
>>>>    create mode 100644 drivers/phy/renesas/Makefile
>>>>    rename drivers/phy/{ => renesas}/phy-rcar-gen2.c (100%)
>>>>    rename drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c (100%)
>>>>    create mode 100644 drivers/phy/rockchip/Kconfig
>>>>    create mode 100644 drivers/phy/rockchip/Makefile
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-dp.c (100%)
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-emmc.c (100%)
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-inno-usb2.c (100%)
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-pcie.c (100%)
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-typec.c (100%)
>>>>    rename drivers/phy/{ => rockchip}/phy-rockchip-usb.c (100%)
>>>>    create mode 100644 drivers/phy/samsung/Kconfig
>>>>    create mode 100644 drivers/phy/samsung/Makefile
>>>>    rename drivers/phy/{ => samsung}/phy-exynos-dp-video.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos-mipi-video.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos-pcie.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos4210-usb2.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos5250-sata.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-exynos5250-usb2.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-s5pv210-usb2.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-samsung-usb2.c (100%)
>>>>    rename drivers/phy/{ => samsung}/phy-samsung-usb2.h (100%)
>>>>    create mode 100644 drivers/phy/st/Kconfig
>>>>    create mode 100644 drivers/phy/st/Makefile
>>>>    rename drivers/phy/{ => st}/phy-miphy28lp.c (100%)
>>>>    rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>>>>    rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>>>>    rename drivers/phy/{ => st}/phy-stih407-usb.c (100%)
>>>>    create mode 100644 drivers/phy/ti/Kconfig
>>>>    create mode 100644 drivers/phy/ti/Makefile
>>>>    rename drivers/phy/{ => ti}/phy-da8xx-usb.c (100%)
>>>>    rename drivers/phy/{ => ti}/phy-dm816x-usb.c (100%)
>>>>    rename drivers/phy/{ => ti}/phy-omap-control.c (100%)
>>>>    rename drivers/phy/{ => ti}/phy-omap-usb2.c (100%)
>>>>    rename drivers/phy/{ => ti}/phy-ti-pipe3.c (100%)
>>>>    rename drivers/phy/{ => ti}/phy-tusb1210.c (99%)
>>>>    rename drivers/phy/{ => ti}/phy-twl4030-usb.c (100%)
>>>>    rename {drivers => include/linux}/phy/ulpi_phy.h (100%)
>>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
