From: mirmit <mirmit@bouillot.org>
Subject: Re: Uploaded Latest 2.6.14 on linux.omap.com
Date: Thu, 3 May 2007 09:58:28 +0200
Message-ID: <986017390705030058xe1b2e88j9b80afc1454aeff1@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47D02242@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47D02242@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim,

I haven't found it - yet- at
http://linux.omap.com/pub/kernel/2430sdp/source/, which seem the logical
place for it. only Feb release is present there.

What functionality/feature level is for 2420 SDP board, as it seem this
release is also for H4?

Which toolchain is recommended to use with? I guess the one at
linux.omap.com is not suitable (3.2.2). But maybe latest from codesourcery
is more indicated.

Regards,

Mirmit

2007/5/3, Syed Mohammed, Khasim <x0khasim@ti.com>:
>
> All:
>
> FYI, I have uploaded latest version of Linux kernel "version 2.6.14" on
> linux.omap.com
>
> linux-2.6.14-omap2420-omap2430-new.tgz 02-May-2007 19:00   49M
>
> Features for OMAP2430 (validated on TI's 2430 SDP)
> ================================================
>
> New Features
> ============
>
> *       EABI back ported to 2.6.14 (Enabled by default).
> *       Support for SDHC (SD High Capacity) cards
> *       Support for ALSA audio driver and enabled as default.
>
> Supported Features
> ==================
>
> *       Support for Framebuffer.
> *       Support for Debug UART port.
> *       Support for DMA framework.
> *       Support for TV out.
> *       Support for Camera driver.
> *       Support for Video post-processing (rotation, mirroring, cropping,
> overlay, up/down-sampling).
> *       Support for High-Speed MMC (52MHz, 4-bit, slot 1 or 2).
> *       Support for NFS file system.
> *       Support for Ethernet.
> *       Support for Interrupt controller.
> *       Support for SD and SDIO cards.
> *       Support for TWL4030 (T2) audio CODEC.
> *       Support for TWL4030 (T2) RTC.
> *       Support for TSC2046 Touchscreen controller.
> *       Support for Keypad.
> *       Support for HS-I2C.
> *       Support for 26Mhz input clock rate.
> *       DSS change to support 2430 Errata
> *       The EX3691 Camera is supported.
> *       Support for HDQ.
> *       OneNAND flash is supported as the default
> *       SibleyNOR flash is supported as the default
> *       Support for McBSP.
> *       McSPI library, including DMA support.
> *       Support for OMAP2430 version 4.0 ES 2.1 as default.
> *       PRCM 2 supported as default.
> *       Watchdog driver
> *       Full-speed USB Host and Gadget using Philips ISP1301 or TWL4030
> (T2) FS USB transceiver
> *       Support for Battery driver
> *       High Speed USB OTG using Philips ISP1504 transceiver
> *       Support for SDIO card interrupt
> *       Support for LED
> *       Support for Sound services(Vibrator)
> *       Support for Camera burst mode
> *       Support for Suspend and resume functionality
> *       Support for EABI and VFP.
> *       Support for ALSA Audio driver.
> *       Support for activity monitoring interface for DVFS.
>
> Regards,
> Khasim
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
