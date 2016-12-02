From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Thu, 1 Dec 2016 16:29:22 -0800
Message-ID: <20161202002921.GD3703@atomide.com>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161201211234.GA3703@atomide.com>
 <34435805.uoQ87SrZdl@avalon>
 <20161201214457.GC3703@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161201214457.GC3703-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161201 13:45]:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161201 13:37]:
> > Hi Tony,
> > 
> > On Thursday 01 Dec 2016 13:12:34 Tony Lindgren wrote:
> > > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> > > > The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> > > > connected to port 2 of the OMAP EHCI controller. The board however has
> > > > no EEPROM to store the ethernet MAC address, which is programmed by the
> > > > boot loader.
> > > > 
> > > > To allow Linux to use the same MAC address as the boot loader (or for
> > > > that matter any fixed MAC address), we need a node in the device tree
> > > > for the ethernet controller that the boot loader can update at runtime
> > > > with a local-mac-address property. Add it, along with an alias for the
> > > > ethernet controller to let the boot loader locate it easily.
> > > 
> > > Does not seem to work here.. Do I need to set something in u-boot?
> > > I'm using U-Boot 2016.09-00004-g26bb688.
> > 
> > Some versions (possibly forked by vendors) might set the MAC address
> > automatically in DT, but in my case I have the following in my boot script:
> > 
> > tftp 0x80800000 beagle/omap3-beagle-xm.dtb
> > fdt addr ${fileaddr} ${filesize}
> > fdt resize
> > fdt set /ocp@68000000/usbhshost@48064000/ehci@48064800/usb2@2/usbether@1 local-mac-address "[7a d2 a0 00 d1 f0]"
> 
> OK. I just added setenv ethaddr ${usbethaddr} to my bootcmd..

Here's a similar patch for omap5-uevm. Somehow u-boot does not populate the
local-mac-address on it though although set in the environment.

So I had to manually do the fdt set /ocp/usbhshost@4a064000/ehci@4a064c00/usbether@3
command.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 1 Dec 2016 12:57:24 -0800
Subject: [PATCH] ARM: dts: omap5-uevm: Allow bootloader to configure USB
 Ethernet MAC

Note that with 9730 the wiring is different compared to 9514 found on
beagleboard xm for example.

On beagleboard xm we have:

/sys/bus/usb/devices/1-2	hub
/sys/bus/usb/devices/1-2.1	9514

While on omap5-uevm we have:

/sys/bus/usb/devices/1-2	hub
/sys/bus/usb/devices/1-3	9730

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -18,6 +18,10 @@
 		reg = <0 0x80000000 0 0x7f000000>; /* 2032 MB */
 	};
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -164,6 +168,23 @@
 	>;
 };
 
+&usbhsehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb2@2 {
+		compatible = "usb424,3503";
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	ethernet: usbether@3 {
+		compatible = "usb424,9730";
+		reg = <3>;
+	};
+};
+
 &wlcore {
 	compatible = "ti,wl1837";
 };
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
