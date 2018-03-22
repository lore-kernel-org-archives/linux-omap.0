From: Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Thu, 22 Mar 2018 17:23:16 -0500
Message-ID: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
References: <20180309023750.108942-1-tony@atomide.com>
         <20180322135553.GA27648@amd> <20180322164633.GF5799@atomide.com>
         <20180322192843.GA17189@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322192843.GA17189@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2018-03-22 at 20:28 +0100, Pavel Machek wrote:
> Hi!
> 
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > sudo lsusb
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > zcat /proc/config.gz | grep MAPPH
> > > CONFIG_PHY_MAPPHONE_MDM6600=y
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > zcat /proc/config.gz | grep OHCI_
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > > CONFIG_USB_OHCI_HCD=y
> > > CONFIG_USB_OHCI_HCD_OMAP3=y
> > > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > 
> > > As far as I can tell,
> > > 
> > > +CONFIG_USB_WDM=y
> > > +CONFIG_USB_SERIAL=y
> > > +CONFIG_USB_SERIAL_QUALCOMM=y
> > > +CONFIG_USB_SERIAL_WWAN=y
> > > 
> > > should be enabled to enable the drivers (and I did that), but
> > > without
> > > device showing on the bus...
> > > 
> > > Any ideas?
> > 
> > Do you have the related dts patches picked from next?
> > 
> > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > 
> > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > ohci-platform loaded and then ifconfig should show four wwan
> > interfaces being added.
> 
> ifconfig? I thought I should get /dev/ttyUSB0..3?

I believe they are QMI via qmi_wwan, not TTYs.

Dan

> Anyway, that does not seem to work. Something is detected now:
> 
> [   10.819549] ALSA device list:
> [   10.831787]   #0: HDMI 58006000.encoder
> [   10.841186] Waiting 10 sec before mounting root device...
> [   10.887573] usb 2-1: New USB device found, idVendor=22b8,
> idProduct=2a70
> [   10.897521] usb 2-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [   10.907684] usb 2-1: Product: Flash MZ600
> [   10.914611] usb 2-1: Manufacturer: Motorola, Incorporated
> [   20.967193] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to
> feature incompatibilities
> 
> But qcserial driver does not bind to that. If I attempt to force it:
> 
> root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
> new_id
> [ 2059.267730] usb 2-1: unknown number of interfaces: 9
> [ 2059.272949] usb 2-1: unknown number of interfaces: 9
> [ 2059.278045] usb 2-1: unknown number of interfaces: 9
> [ 2059.283233] usb 2-1: unknown number of interfaces: 9
> [ 2059.288330] usb 2-1: unknown number of interfaces: 9
> [ 2059.293457] usb 2-1: unknown number of interfaces: 9
> [ 2059.298553] usb 2-1: unknown number of interfaces: 9
> [ 2059.303680] usb 2-1: unknown number of interfaces: 9
> [ 2059.308776] usb 2-1: unknown number of interfaces: 9
> 
> I don't get anything useful. Do I need to boot android before booting
> Linux or something? How does your lsusb look like?
> 
> Thanks,
> 								Pavel
