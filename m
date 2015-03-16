From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap1_defconfig: drop obsolete Kconfig symbols
Date: Mon, 16 Mar 2015 11:22:15 -0700
Message-ID: <20150316182214.GV5264@atomide.com>
References: <alpine.DEB.2.02.1502070024030.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1502070024030.3767@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, stefan.hengelein@fau.de, valentinrothberg@gmail.com, pebolle@tiscali.nl
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [150206 16:29]:
> 
> scripts/checkkconfigsymbols.py indicates that omap1_defconfig
> references the following obsolete Kconfig symbols:
> 
> CONFIG_BT_L2CAP
> CONFIG_BT_SCO
> CONFIG_DEBUG_ERRORS
> CONFIG_EXPERIMENTAL
> CONFIG_FB_OMAP_BOOTLOADER_INIT
> CONFIG_LEDS_CPU
> CONFIG_MACH_OMAP_HTCWIZARD
> CONFIG_MTD_CHAR
> CONFIG_MTD_DEBUG
> CONFIG_MTD_DEBUG_VERBOSE
> CONFIG_MTD_PARTITIONS
> CONFIG_NET_ETHERNET
> CONFIG_RCU_CPU_STALL_DETECTOR
> CONFIG_SCSI_MULTI_LUN
> CONFIG_USB_DEVICE_CLASS
> CONFIG_VIDEO_OUTPUT_CONTROL
> 
> Drop them from omap1_defconfig.

Applying this one into omap-for-v4.1/defconfig thanks.

Tony
