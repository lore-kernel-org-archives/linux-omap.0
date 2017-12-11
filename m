From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-007463
Date: Mon, 11 Dec 2017 08:08:07 +0000
Message-ID: <AM3PR04MB1251B5EC0B5F9E80E5DF92F2E9370@AM3PR04MB1251.eurprd04.prod.outlook.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208101739.GA15897@kroah.com>
 <VI1PR04MB1262B663F3B631E10E12D283E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <20171211073358.GA7712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171211073358.GA7712@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]=20
Sent: Monday, December 11, 2017 3:34 PM
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Felipe Balbi <balbi@ti.com>; Mathias Nyman <mathias.nyman@intel.com>; o=
pen list:DESIGNWARE USB3 DRD IP DRIVER <linux-usb@vger.kernel.org>; open li=
st:DESIGNWARE USB3 DRD IP DRIVER <linux-omap@vger.kernel.org>; open list <l=
inux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang =
<jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-00746=
3

On Mon, Dec 11, 2017 at 02:26:02AM +0000, Yinbo Zhu wrote:
>=20
>=20
> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, December 08, 2017 6:18 PM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>
> Cc: Felipe Balbi <balbi@ti.com>; Mathias Nyman=20
> <mathias.nyman@intel.com>; open list:DESIGNWARE USB3 DRD IP DRIVER=20
> <linux-usb@vger.kernel.org>; open list:DESIGNWARE USB3 DRD IP DRIVER=20
> <linux-omap@vger.kernel.org>; open list=20
> <linux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry=20
> Huang <jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
> Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum=20
> A-007463
>=20
> On Fri, Dec 08, 2017 at 05:49:40PM +0800, yinbo.zhu@nxp.com wrote:
> > From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>=20
> >I need a "real name" here, I doubt you sign documents as:
> >	"yinbo.zhu"
> >right?  :)
>=20
> >Also, you sent 3 patches, yet no way to know what order to apply them in=
.  Please fix that up by sending a >patch series, properly numbered.
>=20
> >thanks,
>=20
> >greg k-h
>=20
> Hi Greg Kroah-Hartman,
>=20
> "Yinbo.zhu" is my email address prefix,and it is automatically generated =
through the git command.

>Then this means you have not correctly configured git, please fix that :)
I will remove the point in "Yinbo.zhu"
Thanks.
> You can follow the order of patch A-007463 A-009611 A-009668 to apply it.

>That's not how we number patches in the kernel, please do so in the normal=
 way.=20
> See the mailing lists for lots of examples.  The kernel documentation als=
o describes the correct format for this.
Okay, I will mark the sign for patch order. About the kernel documentation =
I will remove the punctuation.
thanks
>thanks,
