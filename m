From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP build failure after this merge window - caused by usb or phy
 Kconfig krap
Date: Mon, 25 Nov 2013 14:09:27 +0000
Message-ID: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

There's no other way to say it, and I've no idea who is responsible for
this:

  LD      init/built-in.o
drivers/built-in.o: In function `omap_usb2_remove':
powercap_sys.c:(.text+0x1c60): undefined reference to `usb_remove_phy'
drivers/built-in.o: In function `omap_usb_power_off':
powercap_sys.c:(.text+0x1c84): undefined reference to `omap_control_usb_phy_power'
drivers/built-in.o: In function `omap_usb_power_on':
powercap_sys.c:(.text+0x1ca8): undefined reference to `omap_control_usb_phy_power'
drivers/built-in.o: In function `omap_usb2_probe':
powercap_sys.c:(.text+0x1dac): undefined reference to `omap_control_usb_phy_power'
powercap_sys.c:(.text+0x1e5c): undefined reference to `usb_add_phy_dev'
drivers/built-in.o: In function `omap_usb2_suspend':
powercap_sys.c:(.text+0x1ec8): undefined reference to `omap_control_usb_phy_power'
powercap_sys.c:(.text+0x1f20): undefined reference to `omap_control_usb_phy_power'
drivers/built-in.o: In function `omap_usb2_set_comparator':
powercap_sys.c:(.text+0x1f54): undefined reference to `usb_get_phy'
arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
dss-common.c:(.text+0xf824): undefined reference to `usb_bind_phy'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

These warnings probably have something to do with it:

scripts/kconfig/conf --silentoldconfig Kconfig
warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))
warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))

which just illustrates why "select" in Kconfig is soo fscking bad that
it shouldn't be used.

It certainly should not be used without running through a series of
randconfig builds to make absolutely sure you have the dependencies
correct... or an allnoconfig with just the options required to select
the new option enabled.
