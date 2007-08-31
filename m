From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: Latest 2.6.14 source for 2430 Uploaded to linux.omap.com
Date: Fri, 31 Aug 2007 17:38:27 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701AE547A@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all:

I have uploaded a new Linux 2.6.14 tar ball "linux-2.6.14-omap2-v4.tgz" =
for TI OMAP2430 SDP on=20

http://linux.omap.com/pub/kernel/2430sdp/source/

This has few bug fixes and supports following features for OMAP2430:

*	Support for NFS file system.
*	Support for Ethernet.=20
*	Support for Interrupt controller.
*	Support for Framebuffer.=20
*	Support for Debug UART port.=20
*	Support for DMA framework.
*	Support for TV out.
*	Support for Camera driver.
*	Support for Video post-processing requirements (rotation, mirroring, =
cropping, overlay, up/down-sampling).
*	Support for High-Speed MMC (52MHz, 4-bit, slot 1 or 2).
*	Support for SD and SDIO cards.
*	Support for TWL4030 (T2) audio CODEC.
*	Support for TWL4030 (T2) RTC.
*	Support for TSC2046 Touchscreen controller.
*	Support for Keypad.
*	Support for HS-I2C.
*	Support for 26Mhz input clock rate.
*	DSS change to support 2430 Errata
*	The EX3691 Camera is supported. =20
*	Support for HDQ.
*	OneNAND flash is supported as the default =20
*	SibleyNOR flash is supported as the default
*	Support for McBSP.
*	McSPI library, including DMA support.
*	Support for OMAP2430 version 4.0 ES 2.1 as default.
*	PRCM 2 supported as default.
*	Watchdog driver
*	Full-speed USB Host and Gadget using Philips ISP1301 or TWL4030 (T2) =
FS USB transceiver
*	Support for Battery driver
*	High Speed USB OTG using Philips ISP1504 transceiver
*	Support for SDIO card interrupts
*	Support for LED
*	Support for Sound services (Vibrator)
*	Support for Camera burst mode
*	Support for Suspend and resume functionality =20
*	Support for EABI and VFP.
*	Support for ALSA Audio driver.
*	Support for activity monitoring interface for DVFS.
*	Support for ALSA DASF audio driver
*	Support for SDHC cards
*	Added pre/post idle poll when serial8250 is in state IDLE_2.
*	Added support for HS USB host isochronous endpoints for USB Audio

I have also uploaded Nishanth Menon's 2430 Startup guide at=20

http://linux.omap.com/pub/kernel/2430sdp/OMAP2430_Startup_guide.pdf

Regards,
Khasim
