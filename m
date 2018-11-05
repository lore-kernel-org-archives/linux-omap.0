From: Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
Date: Mon, 5 Nov 2018 09:43:34 +0000
Message-ID: <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: tomeu.vizoso@collabora.com, khilman@baylibre.com, Olof Johansson <olof@lixom.net>, broonie@kernel.org, matthew.hart@linaro.org, enric.balletbo@collabora.com, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please see below, the kernelci.org automated boot bisection found
that the OMAP3 BeagleBoard-xM is failing to boot with SMP
disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
log output after the bootloader so the kernel seems to be
crashing very early on.


Here are the details and log of the "bad" boot:

  https://kernelci.org/boot/id/5bde6b0459b51468bcda93e0/

  https://storage.kernelci.org/mainline/master/v4.19-12838-g71e56028173b/arm/multi_v7_defconfig+CONFIG_SMP=n/lab-baylibre/boot-omap3-beagle-xm.html

and the history of all the bisection steps and checks:

  http://lava.baylibre.com:10080/scheduler/device/omap3-beagle-xm-sea?recent_length=20&recent_search=lava-bisect-9615#recent_


Please note that the board went offline after that so we don't
know if it's already fixed in v4.20-rc1, although that would seem
quite unlikely.


As always, please take the automated bisection results with a
pinch of salt: the root cause often lies somewhere else than in
the "breaking" commit found, and there has been no further
investigation beyond the automated bisection results.

Hope this helps!

Best wishes,
Guillaume


On 04/11/2018 09:40, kernelci.org bot wrote:
> Bisection result for mainline/master (v4.19-12838-g71e56028173b) on beagle-xm
> 
>   Good:       83650fd58a93 Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>   Bad:        71e56028173b Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>   Found:      513eb9859552 ARM: defconfig: Update multi_v7 to use PREEMPT
> 
> Details:
>   Good:       https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.19-12735-g83650fd58a93/
>   Bad:        https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.19-12838-g71e56028173b/
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     beagle-xm
>   Lab:        lab-baylibre
>   Config:     multi_v7_defconfig+CONFIG_SMP=n
>   Plan:       boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 513eb98595522bc0cb83831a9daee1d5738e66f1
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Fri Oct 19 11:24:26 2018 +0200
> 
>     ARM: defconfig: Update multi_v7 to use PREEMPT
>     
>     Using CONFIG_PREEMPT as preemption model for ARMv7 systems
>     appear to be the most reasonable default.
>     
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 63af6234c1b6..1c7616815a86 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_PREEMPT=y
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EMBEDDED=y
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [83650fd58a934fad5b7735fea96905ef986c0821] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 83650fd58a934fad5b7735fea96905ef986c0821
> # bad: [71e56028173bc84f01456a5679d8be9d681b49f1] Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 71e56028173bc84f01456a5679d8be9d681b49f1
> # good: [4e303fbe2d95806c875f5ebfcb3d980e20b4bd83] perf top: Allow disabling the overwrite mode
> git bisect good 4e303fbe2d95806c875f5ebfcb3d980e20b4bd83
> # bad: [01897f3e05ede4d66c0f9df465fde1d67a1d733f] Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 01897f3e05ede4d66c0f9df465fde1d67a1d733f
> # good: [ff27a06af6ffd3f49b9e193eb68f487ad76651e1] perf top: Start display thread earlier
> git bisect good ff27a06af6ffd3f49b9e193eb68f487ad76651e1
> # bad: [d2ff0ff2c23f1bacd35073bf50e6c18298a8d530] Merge tag 'armsoc-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> git bisect bad d2ff0ff2c23f1bacd35073bf50e6c18298a8d530
> # bad: [d4f79cb872bd4faa44eb133c1aee5f3411342c54] ARM: orion: avoid VLA in orion_mpp_conf
> git bisect bad d4f79cb872bd4faa44eb133c1aee5f3411342c54
> # good: [7f3d08f5255b964827214e69967b4d5008d6ea18] arm64: defconfig: Enable some IPMI configs
> git bisect good 7f3d08f5255b964827214e69967b4d5008d6ea18
> # bad: [513eb98595522bc0cb83831a9daee1d5738e66f1] ARM: defconfig: Update multi_v7 to use PREEMPT
> git bisect bad 513eb98595522bc0cb83831a9daee1d5738e66f1
> # first bad commit: [513eb98595522bc0cb83831a9daee1d5738e66f1] ARM: defconfig: Update multi_v7 to use PREEMPT
> -------------------------------------------------------------------------------
> 
