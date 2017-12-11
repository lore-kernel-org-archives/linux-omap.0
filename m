From: Yinbo Zhu <yinbo.zhu-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Mon, 11 Dec 2017 03:15:37 +0000
Message-ID: <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com>
 <87vahhpkhw.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vahhpkhw.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>, Jerry Huang <jerry.huang-3arQi8VN3Tc@public.gmane.org>, Ran Wang <ran.wang_1-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]=20
Sent: Friday, December 08, 2017 6:44 PM
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Yinbo Zhu <yinbo.zhu@n=
xp.com>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; open list:DESIGNWARE USB3 DRD =
IP DRIVER <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; open list:DESIGNWARE USB3 DRD IP DRI=
VER <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;=
 Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>; Jerry Huang <jerry.huang-3arQi8VN3Tc@public.gmane.org>; Ran Wa=
ng <ran.wang_1-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-00961=
1


>Hi,

>Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> On Fri, Dec 08, 2017 at 05:49:41PM +0800, yinbo.zhu-3arQi8VN3Tc@public.gmane.org wrote:
>> From: "yinbo.zhu" <yinbo.zhu-3arQi8VN3Tc@public.gmane.org>
>>=20
>> Description: This is a occasional problem where the software
>
> No need for a "Description:" word.  That's just assumed here, right?

I will remove "Description:" thanks.
>> issues an End Transfer command while a USB transfer is in progress,=20
>> resulting in the TxFIFO  being flushed when the lower layer is=20
>> waiting for data,causing the super speed (SS) transmit to get blocked.
>> If the End Transfer command is issued on an IN endpoint to flush out=20
>> the pending transfers when the same IN endpoint is doing transfers on=20
>> the USB, then depending upon the timing of the End Transfer (and the=20
>> resulting internal FIFO flush),the lower layer (U3PTL/U3MAC) could=20
>> get stuck waiting for data indefinitely. This blocks the transmission=20
>> path on the SS, and no DP/ACK/ERDY/DEVNOTIF packets can be sent from=20
>> the device.
>> Impact: If this issue happens and the transmission gets blocked, then=20
>> the USB host aborts and resets/re-enumerates the device.
>> This unblocks the transmitt engine and the device functions normally.
>>=20
>> Workaround: Software must wait for all existing TRBs to complete=20
>> before issuing End transfer command.
>>=20
>> Configs Affected:
>> LS1088-48A-R1.0, LS2081A-R1.1, LS2088-48A-R1.0, LS2088-48A-R1.1,=20
>> LX2160-2120-2080A-R1.
>
> What are these Configs?  That doesn't seem to match up with anything=20
> that is in the kernel tree that I can see.

These configs is soc information, I don't enable it on these platform dts.
Although the erratum issue can't be reproduced. =20
>>=20
>> Signed-off-by: yinbo.zhu <yinbo.zhu-3arQi8VN3Tc@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/core.c      |  3 +++
>>  drivers/usb/dwc3/core.h      |  3 +++
>>  drivers/usb/dwc3/host.c      |  3 +++
>>  drivers/usb/host/xhci-plat.c |  4 ++++
>>  drivers/usb/host/xhci.c      | 24 ++++++++++++++++++------
>>  drivers/usb/host/xhci.h      |  1 +
>>  6 files changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index=20
>> 5cb3f6795b0b..071e7cea8cbb 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1106,6 +1106,9 @@ static void dwc3_get_properties(struct dwc3=20
>> *dwc)
>> =20
>>  	dwc->quirk_reverse_in_out =3D device_property_read_bool(dev,
>>  				"snps,quirk_reverse_in_out");

>This was generated on vendor tree. This quirk doesn't exist in dwc3. Also,
 >update your tree and review MAINTAINERS file. It has been almost 2 years =
since I left TI :-)

>--
>Balbi

Hi Balbi,

The quirk that I had add it in dwc3. Your meaning is that I can't use quirk=
 to enable or disable the erratum, isn't it? The tree is git://git.kernel.o=
rg/pub/scm/linux/kernel/git/gregkh/usb.git, I had updated it.

Thanks.
Yinbo

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
