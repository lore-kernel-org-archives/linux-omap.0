From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Mon, 11 Dec 2017 08:27:16 +0000
Message-ID: <VI1PR04MB12624956F5B6544A78AB1251E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com>
 <87vahhpkhw.fsf@linux.intel.com>
 <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <20171211073443.GB7712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171211073443.GB7712@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]=20
Sent: Monday, December 11, 2017 3:35 PM
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>; Mathias Nyman <mathias.nym=
an@intel.com>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-usb@vger.kern=
el.org>; open list:DESIGNWARE USB3 DRD IP DRIVER <linux-omap@vger.kernel.or=
g>; open list <linux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.co=
m>; Jerry Huang <jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-00961=
1

On Mon, Dec 11, 2017 at 03:15:37AM +0000, Yinbo Zhu wrote:
>=20
>=20
> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com]
> Sent: Friday, December 08, 2017 6:44 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Yinbo Zhu=20
> <yinbo.zhu@nxp.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>; open list:DESIGNWARE USB3=20
> DRD IP DRIVER <linux-usb@vger.kernel.org>; open list:DESIGNWARE USB3=20
> DRD IP DRIVER <linux-omap@vger.kernel.org>; open list=20
> <linux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry=20
> Huang <jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
> Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum=20
> A-009611
>=20
>=20
> >Hi,
>=20
> >Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Fri, Dec 08, 2017 at 05:49:41PM +0800, yinbo.zhu@nxp.com wrote:
> >> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> >>=20
> >> Description: This is a occasional problem where the software
> >
> > No need for a "Description:" word.  That's just assumed here, right?
>=20
> I will remove "Description:" thanks.
> >> issues an End Transfer command while a USB transfer is in progress,=20
> >> resulting in the TxFIFO  being flushed when the lower layer is=20
> >> waiting for data,causing the super speed (SS) transmit to get blocked.
> >> If the End Transfer command is issued on an IN endpoint to flush=20
> >> out the pending transfers when the same IN endpoint is doing=20
> >> transfers on the USB, then depending upon the timing of the End=20
> >> Transfer (and the resulting internal FIFO flush),the lower layer=20
> >> (U3PTL/U3MAC) could get stuck waiting for data indefinitely. This=20
> >> blocks the transmission path on the SS, and no DP/ACK/ERDY/DEVNOTIF=20
> >> packets can be sent from the device.
> >> Impact: If this issue happens and the transmission gets blocked,=20
> >> then the USB host aborts and resets/re-enumerates the device.
> >> This unblocks the transmitt engine and the device functions normally.
> >>=20
> >> Workaround: Software must wait for all existing TRBs to complete=20
> >> before issuing End transfer command.
> >>=20
> >> Configs Affected:
> >> LS1088-48A-R1.0, LS2081A-R1.1, LS2088-48A-R1.0, LS2088-48A-R1.1,=20
> >> LX2160-2120-2080A-R1.
> >
> > What are these Configs?  That doesn't seem to match up with anything=20
> > that is in the kernel tree that I can see.
>=20
> These configs is soc information, I don't enable it on these platform dts=
.
> Although the erratum issue can't be reproduced. =20

>I do not understand what this means, please explain it a bit better.

>thanks,

>greg k-h

Maybe I have a problem with your words, Your meaning is that you want to as=
k me why I didn't add an attribute in the device tree to match kernel for e=
very platform, right?
