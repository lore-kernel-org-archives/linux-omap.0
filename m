From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 25 May 2016 14:44:32 +0000
Message-ID: <AM4PR04MB213028144706EC69A066EAEE89400@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-9-git-send-email-rogerq@ti.com> <574422CA.8080002@ti.com>
 <20160525024427.GA31142@shlinux2> <574598D3.5090405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <574598D3.5090405@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

Hi Roger

> >>
> >> Here, we should be checking if user needs to disable any OTG
> >> features. So,
> >>
> >> 	if (dev->of_node)
> >> 		of_usb_update_otg_caps(dev->of_node, &otg->caps);
> >>
> >> Do you agree?
> >> This means we need to change otg->caps from 'struct usb_otg_caps
> *caps;'
> >> to 'struct usb_otg_caps caps;' so that we can modify the local copy
> >> instead of the one passed by the OTG controller.
> >
> > Why can't modify the one from OTG controller directly?
> >
> 
> There are 2 things.
> 1) OTG features supported by hardware. This is the controller's config-
> >otg_caps
> 2) OTG features needed by system designer. This can be a subset of (1).

Let's make things simple, we only need this subnet, which can be set
by controller driver in config->otg_caps before pass (its address)
to OTG core.

So controller driver should get the capability of HW(+SW) and user config
by whatever approach, then set its config->otg_caps.

Li Jun
