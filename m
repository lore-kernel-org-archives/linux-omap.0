From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
Date: Wed, 27 Apr 2016 10:16:33 +0000
Message-ID: <AM4PR04MB2130FA0DCDDE4A81F8F54F4E89640@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-9-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

> 
> +
> +static struct otg_hcd_ops otg_hcd_intf = {
> +	.add = usb_add_hcd,
> +	.remove = usb_remove_hcd,
> +	.usb_bus_start_enum = usb_bus_start_enum,

Build break if CONFIG_USB_OTG is not enabled:

drivers/built-in.o:(.data+0x1db30): undefined reference to `usb_bus_start_enum'
Makefile:948: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Li Jun
 
> +	.usb_control_msg = usb_control_msg,
> +	.usb_hub_find_child = usb_hub_find_child, };
> +
