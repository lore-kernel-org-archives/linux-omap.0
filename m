From: Kevin Hilman <khilman@kernel.org>
Subject: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Tue, 16 Dec 2014 08:59:37 -0800
Message-ID: <CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47339 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbaLPQ7m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:59:42 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3B20A2B
	for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2014 16:59:41 +0000 (UTC)
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EB98520A24
	for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2014 16:59:38 +0000 (UTC)
Received: by mail-wg0-f49.google.com with SMTP id n12so17966057wgh.36
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2014 08:59:37 -0800 (PST)
In-Reply-To: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

FYI... New boot failures in today's linux-next for omap4-panda-es and
omap5-uevm:

   http://status.armcloud.us/boot/?lab-khilman&fail&omap

The omap3-beagle-xm one has been fixed by Tero, but the fix hasn't hit
-next yet.  I haven't had a chance to bisect these yet.

Kevin


---------- Forwarded message ----------
From: Kevin's boot bot <khilman@kernel.org>
Date: Mon, Dec 15, 2014 at 10:28 PM
Subject: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
To: kernel-build-reports@lists.linaro.org


Full Build report: http://status.armcloud.us/build/next/kernel/next-20141216/
Full Boot report:
http://status.armcloud.us/boot/all/job/next/kernel/next-20141216/

Tree/Branch: next
Git describe: next-20141216

Failed boot tests
=================
                     emev2-kzm9d:     FAIL:    arm-shmobile_defconfig
                                       u-boot: ERROR: timeout getting
DHCP address.

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-shmobile_defconfig/lab-khilman/boot-emev2-kzm9d.html
         exynos5420-arndale-octa:     FAIL:
arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y/lab-khilman/boot-exynos5420-arndale-octa.html
             exynos5800-peach-pi:     FAIL:
arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y/lab-khilman/boot-exynos5800-peach-pi.html
                      omap5-uevm:     FAIL:
arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y
                                       kernel: Unable to handle kernel
paging request at virtual address ffffffec


http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y/lab-khilman/boot-omap5-uevm.html
             exynos5800-peach-pi:     FAIL:    arm-multi_v7_defconfig
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-exynos5800-peach-pi.html
         exynos5420-arndale-octa:     FAIL:    arm-multi_v7_defconfig
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-exynos5420-arndale-octa.html
                      omap5-uevm:     FAIL:    arm-multi_v7_defconfig
                                       kernel: Unable to handle kernel
paging request at virtual address ffffffec


http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-omap5-uevm.html
                  omap4-panda-es:     FAIL:    arm-multi_v7_defconfig
                                       kernel: ERROR: failed to boot:
Kernel panic

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-omap4-panda-es.html
         exynos5420-arndale-octa:     FAIL:    arm-exynos_defconfig
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-exynos_defconfig/lab-khilman/boot-exynos5420-arndale-octa.html
             exynos5800-peach-pi:     FAIL:    arm-exynos_defconfig
                                       kernel: ERROR: failed to boot:
<class 'pexpect.TIMEOUT'>

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-exynos_defconfig/lab-khilman/boot-exynos5800-peach-pi.html
            exynos5410-odroid-xu:     FAIL:    arm-exynos_defconfig
                                       ERROR: Timeout waiting for
command: if test -n ${preboot}; then run preboot; fi.

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-exynos_defconfig/lab-khilman/boot-exynos5410-odroid-xu.html
          omap3-beagle-xm,legacy:     FAIL:    arm-omap2plus_defconfig
                                       kernel: ERROR: did not start booting.

http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-omap2plus_defconfig/lab-khilman/boot-omap3-beagle-xm,legacy.html

Full Report
===========

arm-shmobile_defconfig
----------------------
                     emev2-kzm9d:     FAIL  -  u-boot: ERROR: timeout
getting DHCP address.

arm-davinci_all_defconfig
-------------------------
                 dm365evm,legacy:     PASS
                       da850-evm:     PASS

arm-tegra_defconfig
-------------------
             tegra124-jetson-tk1:     PASS
                  tegra30-beaver:     PASS

arm-bcm2835_defconfig
---------------------
                     bcm2835-rpi:     PASS

arm-multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y
----------------------------------------------
      armada-xp-openblocks-ax3-4:     PASS
              armada-370-mirabox:     PASS

arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y
----------------------------------------
             tegra124-jetson-tk1:     PASS
            exynos5410-odroid-xu:     PASS
           sun7i-a20-cubieboard2:     PASS
         exynos5420-arndale-octa:     FAIL  -  kernel: ERROR: failed
to boot: <class 'pexpect.TIMEOUT'>
      armada-xp-openblocks-ax3-4:     PASS
             exynos5800-peach-pi:     FAIL  -  kernel: ERROR: failed
to boot: <class 'pexpect.TIMEOUT'>
              sun7i-a20-bananapi:     PASS
                      omap5-uevm:     FAIL  (Warnings:  1)  -  kernel:
Unable to handle kernel paging request at virtual address ffffffec

           exynos5422-odroid-xu3:     PASS  (Warnings:  1)
              exynos5250-arndale:     PASS
                rk3288-evb-rk808:     PASS
               vexpress-v2p-ca15:     PASS

arm-imx_v6_v7_defconfig
-----------------------
      imx6dl-wandboard,wand-dual:     PASS
      imx6dl-wandboard,wand-solo:     PASS
                 imx6q-wandboard:     PASS

arm-versatile_defconfig
-----------------------
              versatilepb,legacy:     PASS

arm-multi_v7_defconfig
----------------------
                am335x-boneblack:     PASS
 qcom-msm8974-sony-xperia-honami:     PASS
              armada-370-mirabox:     PASS
            sun4i-a10-cubieboard:     PASS
                omap3-overo-tobi:     PASS
                     am335x-bone:     PASS
              sun7i-a20-bananapi:     PASS
             tegra124-jetson-tk1:     PASS
                 omap3-beagle-xm:     PASS
           sun7i-a20-cubieboard2:     PASS
            exynos5410-odroid-xu:     PASS
                     omap4-panda:     PASS
                 imx6q-wandboard:     PASS
      imx6dl-wandboard,wand-dual:     PASS
                    omap3-beagle:     PASS
                    ste-snowball:     PASS
                  tegra30-beaver:     PASS
                      omap3-n900:     PASS
        qcom-apq8074-dragonboard:     PASS
           qcom-apq8064-cm-qs600:     PASS
                     bcm28155-ap:     PASS
             exynos5800-peach-pi:     FAIL  -  kernel: ERROR: failed
to boot: <class 'pexpect.TIMEOUT'>
      imx6dl-wandboard,wand-solo:     PASS
          omap3-overo-storm-tobi:     PASS
           exynos5422-odroid-xu3:     PASS  (Warnings:  1)
                rk3288-evb-rk808:     PASS
            qcom-apq8064-ifc6410:     PASS
                   stih410-b2120:     PASS
         exynos5420-arndale-octa:     FAIL  -  kernel: ERROR: failed
to boot: <class 'pexpect.TIMEOUT'>
      armada-xp-openblocks-ax3-4:     PASS
                vexpress-v2p-ca9:     PASS
               vexpress-v2p-ca15:     PASS
                      omap5-uevm:     FAIL  (Warnings:  1)  -  kernel:
Unable to handle kernel paging request at virtual address ffffffec

                  omap4-panda-es:     FAIL  (Warnings:  1)  -  kernel:
ERROR: failed to boot: Kernel panic
              exynos5250-arndale:     PASS
                      zynq-zc702:     PASS
                   am437x-gp-evm:     PASS  (Warnings:  1)

arm-vexpress_defconfig
----------------------
                vexpress-v2p-ca9:     PASS
               vexpress-v2p-ca15:     PASS

arm-sunxi_defconfig
-------------------
              sun7i-a20-bananapi:     PASS
           sun7i-a20-cubieboard2:     PASS
            sun4i-a10-cubieboard:     PASS

arm-qcom_defconfig
------------------
           qcom-apq8064-cm-qs600:     PASS
            qcom-apq8064-ifc6410:     PASS
 qcom-msm8974-sony-xperia-honami:     PASS
        qcom-apq8074-dragonboard:     PASS

arm-u8500_defconfig
-------------------
                    ste-snowball:     PASS

arm-exynos_defconfig
--------------------
         exynos5420-arndale-octa:     FAIL  (Warnings:  1)  -  kernel:
ERROR: failed to boot: <class 'pexpect.TIMEOUT'>
           exynos5422-odroid-xu3:     PASS  (Warnings:  1)
              exynos5250-arndale:     PASS
             exynos5800-peach-pi:     FAIL  -  kernel: ERROR: failed
to boot: <class 'pexpect.TIMEOUT'>
            exynos5410-odroid-xu:     FAIL  -  ERROR: Timeout waiting
for command: if test -n ${preboot}; then run preboot; fi.

arm-mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y
----------------------------------------------
      armada-xp-openblocks-ax3-4:     PASS
              armada-370-mirabox:     PASS

arm-bcm_defconfig
-----------------
                     bcm28155-ap:     PASS

arm-omap2plus_defconfig
-----------------------
                     omap4-panda:     PASS
          omap3-overo-storm-tobi:     PASS
                 omap3-beagle-xm:     PASS
                      omap3-n900:     PASS
          omap3-beagle-xm,legacy:     FAIL  -  kernel: ERROR: did not
start booting.
                     am335x-bone:     PASS
                am335x-boneblack:     PASS
               omap3-n900,legacy:     PASS  (Warnings:  3)
                omap3-overo-tobi:     PASS
             omap3-beagle,legacy:     PASS  (Warnings:  2)
         omap3-overo-tobi,legacy:     PASS  (Warnings:  2)
   omap3-overo-storm-tobi,legacy:     PASS  (Warnings:  1)
                      omap5-uevm:     PASS  (Warnings:  1)
                  omap4-panda-es:     PASS
                   am437x-gp-evm:     PASS
                    omap3-beagle:     PASS

arm-sama5_defconfig
-------------------
                      sama5d35ek:     PASS
           at91-sama5d3_xplained:     PASS

arm-mvebu_v7_defconfig
----------------------
      armada-xp-openblocks-ax3-4:     PASS
              armada-370-mirabox:     PASS

arm64-defconfig+CONFIG_OF_UNITTEST=y
------------------------------------
             qemu-aarch64,legacy:     PASS

arm64-defconfig
---------------
             qemu-aarch64,legacy:     PASS
