From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Tue, 12 Dec 2017 07:09:09 +0000
Message-ID: <AM3PR04MB1251BBEE0FF48CA0433F91B6E9340@AM3PR04MB1251.eurprd04.prod.outlook.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com>
 <87vahhpkhw.fsf@linux.intel.com>
 <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <87mv2pprz2.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mv2pprz2.fsf@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com]=20
Sent: Monday, December 11, 2017 4:52 PM
To: Yinbo Zhu <yinbo.zhu@nxp.com>; Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>; open list:DESIGNWARE USB3 DRD =
IP DRIVER <linux-usb@vger.kernel.org>; open list:DESIGNWARE USB3 DRD IP DRI=
VER <linux-omap@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;=
 Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang <jerry.huang@nxp.com>; Ran Wa=
ng <ran.wang_1@nxp.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-00961=
1


>>Hi,

>>(please break your lines at 80-characters)

>>Yinbo Zhu <yinbo.zhu@nxp.com> writes:
I had check it. Every line is less than 80-characters.
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index=20
>>> 5cb3f6795b0b..071e7cea8cbb 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1106,6 +1106,9 @@ static void dwc3_get_properties(struct dwc3
>>> *dwc)
>>> =20
>>>  	dwc->quirk_reverse_in_out =3D device_property_read_bool(dev,
>>>  				"snps,quirk_reverse_in_out");
>
>>This was generated on vendor tree. This quirk doesn't exist in dwc3.=20
>>Also,
>  >update your tree and review MAINTAINERS file. It has been almost 2=20
> years since I left TI :-)
>
>>--
>>Balbi
>
> Hi Balbi,
>
> The quirk that I had add it in dwc3. Your meaning is that I can't use=20
> quirk to enable or disable the erratum, isn't it? The tree is=20
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git, I had=20
> updated it.

>-*- mode: grep; default-directory: "~/workspace/linux/" -*- Grep started a=
t Mon Dec 11 10:50:47

>git --no-pager grep --color -nH -e quirk_reverse_in_out

>Grep finished with no matches found at Mon Dec 11 10:50:48

>--
>balbi
Hi Balbi,

You can't find the quirk that it is normal. There's no one in the previous =
code.
 The quirk that I added to control the new erratum=20
Please you note.

Thanks.
Yinbo.
