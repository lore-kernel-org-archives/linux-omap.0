From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
Date: Wed, 27 Apr 2016 13:18:31 +0000
Message-ID: <AM4PR04MB213050D6375B3ED0D3414D4689640@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-9-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130FA0DCDDE4A81F8F54F4E89640@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <57209BE2.7030300@ti.com> <57209E71.5070709@ti.com>
 <AM4PR04MB21301FB7EE62E9ACF14230C289640@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB21301FB7EE62E9ACF14230C289640@AM4PR04MB2130.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Roger Quadros <rogerq@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jun Li [mailto:jun.li@nxp.com]
> Sent: Wednesday, April 27, 2016 8:50 PM
> To: Roger Quadros <rogerq@ti.com>; stern@rowland.harvard.edu;
> balbi@kernel.org; gregkh@linuxfoundation.org; peter.chen@freescale.com
> Cc: dan.j.williams@intel.com; jun.li@freescale.com;
> mathias.nyman@linux.intel.com; tony@atomide.com; Joao.Pinto@synopsys.com;
> abrestic@chromium.org; r.baldyga@samsung.com; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
> 
> Hi
> > -----Original Message-----
> > From: Roger Quadros [mailto:rogerq@ti.com]
> > Sent: Wednesday, April 27, 2016 7:12 PM
> > To: Jun Li <jun.li@nxp.com>; stern@rowland.harvard.edu;
> > balbi@kernel.org; gregkh@linuxfoundation.org; peter.chen@freescale.com
> > Cc: dan.j.williams@intel.com; jun.li@freescale.com;
> > mathias.nyman@linux.intel.com; tony@atomide.com;
> > Joao.Pinto@synopsys.com; abrestic@chromium.org; r.baldyga@samsung.com;
> > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-omap@vger.kernel.org
> > Subject: Re: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
> >
> > On 27/04/16 14:00, Roger Quadros wrote:
> > > On 27/04/16 13:16, Jun Li wrote:
> > >> Hi
> > >>
> > >>>
> > >>> +
> > >>> +static struct otg_hcd_ops otg_hcd_intf = {
> > >>> +	.add = usb_add_hcd,
> > >>> +	.remove = usb_remove_hcd,
> > >>> +	.usb_bus_start_enum = usb_bus_start_enum,
> > >>
> > >> Build break if CONFIG_USB_OTG is not enabled:
> > >>
> > >> drivers/built-in.o:(.data+0x1db30): undefined reference to
> > `usb_bus_start_enum'
> > >> Makefile:948: recipe for target 'vmlinux' failed
> > >> make: *** [vmlinux] Error 1
> >
> > I couldn't get this error. Could you please send me your .config? Thanks.
> 
> imx_v6_v7_defconfig

My bad, no problem now.

Li Jun

> 
> >
> > cheers,
> > -roger
> > >
> > > Thanks. Will fix it.
> > >
> > > cheers,
> > > -roger
> > >
> > >>
> > >>> +	.usb_control_msg = usb_control_msg,
> > >>> +	.usb_hub_find_child = usb_hub_find_child, };
> > >>> +
> > >>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-usb"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
