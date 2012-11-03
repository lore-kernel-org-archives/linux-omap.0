From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH 0/5] usb: musb: am335x support
Date: Sat, 3 Nov 2012 02:40:50 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63EA1AA39@DBDE01.ent.ti.com>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <509420D8.1030307@gmail.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "Mohammed, Afzal" <afzal@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> 
> On 02.11.2012 17:31, Afzal Mohammed wrote:
> > This series adds usb support to am335x SoC's found on boards like 
> > Beagle Bone. Here only first instance is supported, as currently 
> > multiple phy's of same type is not supported (am335x has two USB2 
> > phy's).
> 
> I'm testing these patches with an AM33xx board that has the 
> first musb port wired to an USB type A plug, but it doesn't 
> yet work for me.
> 
> The messages I'm getting are:
> 
> [    1.219339] ehci_hcd: USB 2.0 'Enhanced' Host Controller 
> (EHCI) Driver
> [    1.226568] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver

Why ehci, ohci has selected for am335xx platform?

> [    1.233444] usbcore: registered new interface driver uas
> [    1.239066] Initializing USB Mass Storage driver...
> [    1.244395] usbcore: registered new interface driver usb-storage
> [    1.250732] USB Mass Storage support registered.
> [    1.255573] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    1.262671] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
> combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [    1.262889] musb-hdrc: MHDRC RTL version 2.0
> [    1.262907] musb-hdrc: setup fifo_mode 4
> [    1.262940] musb-hdrc: 28/31 max ep, 16384/16384 memory
> 
> So there is no host interface registered. I'm unsure on how 

The host interface will be registered when you load the gadget driver, (like insmod g_zero.ko ,etc).

> to fix this, and I didn't get an answer yet to that question 
> when I asked Felipe about how interface drivers like dsps are 
> supposed to act in order to get host mode back after the 
> recent musb cleanups.
> 
> What type of hardware do you test this with? Does host mode 
> work for you?
> 

By default only otg build is supported, you must insert the gadget module for each usb port in order to enable the host/device functionality. Have you checked with loading any gadget module (g_ether.ko, or g_ether.ko etc)? 

-RaviBabu
> 
> Many thanks,
> Daniel
> 
> 
> 