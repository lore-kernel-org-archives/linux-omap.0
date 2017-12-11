From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-007463
Date: Mon, 11 Dec 2017 08:33:58 +0100
Message-ID: <20171211073358.GA7712@kroah.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208101739.GA15897@kroah.com>
 <VI1PR04MB1262B663F3B631E10E12D283E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB1262B663F3B631E10E12D283E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Felipe Balbi <balbi@ti.com>, Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 11, 2017 at 02:26:02AM +0000, Yinbo Zhu wrote:
> 
> 
> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org] 
> Sent: Friday, December 08, 2017 6:18 PM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>
> Cc: Felipe Balbi <balbi@ti.com>; Mathias Nyman <mathias.nyman@intel.com>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-usb@vger.kernel.org>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-omap@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang <jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
> Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-007463
> 
> On Fri, Dec 08, 2017 at 05:49:40PM +0800, yinbo.zhu@nxp.com wrote:
> > From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> >I need a "real name" here, I doubt you sign documents as:
> >	"yinbo.zhu"
> >right?  :)
> 
> >Also, you sent 3 patches, yet no way to know what order to apply them in.  Please fix that up by sending a >patch series, properly numbered.
> 
> >thanks,
> 
> >greg k-h
> 
> Hi Greg Kroah-Hartman,
> 
> "Yinbo.zhu" is my email address prefix,and it is automatically generated through the git command.

Then this means you have not correctly configured git, please fix that :)

> You can follow the order of patch A-007463 A-009611 A-009668 to apply it.

That's not how we number patches in the kernel, please do so in the
normal way.  See the mailing lists for lots of examples.  The kernel
documentation also describes the correct format for this.

thanks,

greg k-h
