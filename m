From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Fri, 21 Dec 2018 10:02:05 -0800
Message-ID: <20181221180205.GH6707@atomide.com>
References: <20181221011752.25627-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [181221 01:18]:
> The new code has been tested on the Motorola Droid 4. For testing the audio
> should be configured to route Ext to Speaker or Headphone. Then you need to
> plug headphone, since its cable is used as antenna. For testing there is a
> 'radio' utility packages in Debian. When you start the utility you need to
> specify a frequency, since initial get_frequency returns an error:

Nice, good to see that ti-st kim stuff gone :) I gave this a quick
try using fmtools.git and fmscan works just fine. No luck yet with
fm though, it gives VIDIOC_G_CTRL: Not a tty error somehow so
maybe I'm missing some options, patch below for omap2plus_defconfig.

Hmm so looks like nothing to configure for the clocks or
CPCAP_BIT_ST_L_TIMESLOT bits for cap for the EXT? So the
wl12xx audio is wired directly to cpcap EXT then and not a
TDM slot on the mcbsp huh?

> Merry Christmas!

Same to you!

Tony

8< --------------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 21 Dec 2018 07:57:09 -0800
Subject: [PATCH] ARM: omap2plus_defconfig: Add RADIO_WL128X as a loadable
 module

This allows using the FM radio in the wl12xx chips after modprobe
fm_drv using radio from xawt, or fmtools.

Note that the firmware placed into /lib/firmware/ti-connectivity
directory:

fm_rx_ch8_1283.2.bts
fmc_ch8_1283.2.bts

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -126,6 +126,7 @@ CONFIG_AF_RXRPC=m
 CONFIG_RXKAD=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
+CONFIG_RFKILL=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
@@ -343,12 +344,14 @@ CONFIG_IR_GPIO_TX=m
 CONFIG_IR_PWM_TX=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_RADIO_SUPPORT=y
 CONFIG_MEDIA_CEC_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
 CONFIG_CEC_PLATFORM_DRIVERS=y
+CONFIG_RADIO_WL128X=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_TVP5150=m
 CONFIG_DRM=m
-- 
2.19.2
