From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 3/8] omap1: Amstrad Delta defconfig fixes
Date: Wed, 11 Nov 2009 18:24:56 +0100
Message-ID: <200911111825.00281.jkrzyszt@tis.icnet.pl>
References: <20091111025907.31793.84134.stgit@localhost> <20091111030057.31793.60438.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49260 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164AbZKKRZP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 12:25:15 -0500
In-Reply-To: <20091111030057.31793.60438.stgit@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jonathan McDowell <noodles@earth.li>, e3-hacking@earth.li

Wednesday 11 November 2009 04:00:57 Tony Lindgren napisa=C5=82(a):
> From: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
>
> The patch provides the following fixes:
>
> - keep kernel small enough to boot with standard tools,
> - ensure compatibility with both new and legacy distros,
> - turn on support for recently added or fixed hardware features.
>
> Created and tested against linux-2.6.32-rc5.
>
> Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tony,

Please do not apply this patch yet, or revert it if already applied. It=
 would=20
exhibit the LCD DMA not working bug when CONFIG_PM=3Dy, as I tried to s=
tate=20
while submitting v2 of my fix that corrected the issue=20
(http://www.spinics.net/lists/linux-omap/msg19963.html).

Sorry for not stating that again with this submission (or not waiting w=
ith=20
the submission after the bug is fixed first). That happened after I=20
misinterpreted your comment "Sounds good to me." =20
(http://www.spinics.net/lists/linux-omap/msg19965.html) as your accepta=
nce=20
for the patch v2 as posted, with my self proposed changes, that resulte=
d in v3 =20
submission directly (http://www.spinics.net/lists/linux-omap/msg20059.h=
tml),=20
that has been objected by you next.

Thanks,
Janusz

> ---
>  arch/arm/configs/ams_delta_defconfig |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/configs/ams_delta_defconfig
> b/arch/arm/configs/ams_delta_defconfig index 7647325..e8f7380 100644
> --- a/arch/arm/configs/ams_delta_defconfig
> +++ b/arch/arm/configs/ams_delta_defconfig
> @@ -55,10 +55,10 @@ CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_INITRAMFS_SOURCE=3D""
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>  CONFIG_SYSCTL=3Dy
> -# CONFIG_EMBEDDED is not set
> +CONFIG_EMBEDDED=3Dy
>  CONFIG_UID16=3Dy
>  CONFIG_SYSCTL_SYSCALL=3Dy
> -CONFIG_KALLSYMS=3Dy
> +# CONFIG_KALLSYMS is not set
>  # CONFIG_KALLSYMS_ALL is not set
>  # CONFIG_KALLSYMS_EXTRA_PASS is not set
>  CONFIG_HOTPLUG=3Dy
> @@ -224,7 +224,7 @@ CONFIG_CPU_CP15_MMU=3Dy
>  #
>  # Processor Features
>  #
> -# CONFIG_ARM_THUMB is not set
> +CONFIG_ARM_THUMB=3Dy
>  # CONFIG_CPU_ICACHE_DISABLE is not set
>  # CONFIG_CPU_DCACHE_DISABLE is not set
>  CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
> @@ -248,7 +248,7 @@ CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
>  # CONFIG_HIGH_RES_TIMERS is not set
>  CONFIG_PREEMPT=3Dy
>  CONFIG_HZ=3D100
> -# CONFIG_AEABI is not set
> +CONFIG_AEABI=3Dy
>  # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
>  CONFIG_SELECT_MEMORY_MODEL=3Dy
>  CONFIG_FLATMEM_MANUAL=3Dy
> @@ -299,7 +299,9 @@ CONFIG_BINFMT_ELF=3Dy
>  #
>  # Power management options
>  #
> -# CONFIG_PM is not set
> +CONFIG_PM=3Dy
> +# CONFIG_SUSPEND is not set
> +CONFIG_PM_RUNTIME=3Dy
>
>  #
>  # Networking
> @@ -670,7 +672,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
>  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
>  # CONFIG_INPUT_JOYDEV is not set
>  # CONFIG_INPUT_TSDEV is not set
> -# CONFIG_INPUT_EVDEV is not set
> +CONFIG_INPUT_EVDEV=3Dy
>  # CONFIG_INPUT_EVBUG is not set
>
>  #
> @@ -784,6 +786,7 @@ CONFIG_I2C_OMAP=3Dy
>  #
>  # CONFIG_SPI is not set
>  # CONFIG_SPI_MASTER is not set
> +CONFIG_GPIO_SYSFS=3Dy
>
>  #
>  # Dallas's 1-wire bus
> @@ -820,6 +823,7 @@ CONFIG_LEDS_AMS_DELTA=3Dy
>  CONFIG_LEDS_TRIGGERS=3Dy
>  CONFIG_LEDS_TRIGGER_TIMER=3Dy
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
>
>  #
>  # Multimedia devices
> @@ -896,7 +900,13 @@ CONFIG_LOGO_LINUX_CLUT224=3Dy
>  #
>  # Sound
>  #
> -# CONFIG_SOUND is not set
> +CONFIG_SOUND=3Dy
> +CONFIG_SND=3Dy
> +CONFIG_SND_MIXER_OSS=3Dy
> +CONFIG_SND_PCM_OSS=3Dy
> +CONFIG_SND_SOC=3Dy
> +CONFIG_SND_OMAP_SOC=3Dy
> +CONFIG_SND_OMAP_SOC_AMS_DELTA=3Dy
>
>  #
>  # HID Devices
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
