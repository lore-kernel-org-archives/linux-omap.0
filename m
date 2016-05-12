From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Thu, 12 May 2016 14:16:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1605121413060.5957-100000@netrider.rowland.org>
References: <SG2PR06MB09194AB523C3ABDB425285C7D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB09194AB523C3ABDB425285C7D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Roger Quadros <rogerq@ti.com>, Rob Herring <robh@kernel.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 12 May 2016, Yoshihiro Shimoda wrote:

> > > Alan, does USB core even know which EHCI and OHCI are linked to the same port
> > > or the handoff is software transparent?
> > 
> > The core knows.  It doesn't use the information for a whole lot of
> > things, but it does use it in a couple of places.  Search for
> > "companion" in core/hcd-pci.c and you'll see.
> 
> Thank you for the information. I didn't know this code.
> If my understanding is correct, the core/hcd-pci.c code will not be used by non-PCI devices.
> In other words, nobody sets "hcd->self.hs_companion" if we use such a device.

That's right.

> So, I will try to add such a code if needed.

The main thing to watch out for is during system resume.  The EHCI
controller must not be resumed until all of its companion controllers
have been resumed.

Alan Stern
