From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 7 Jun 2016 17:05:35 +0300
Message-ID: <5756D4AF.8030103@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <57501E0D.4010007@ti.com> <57569543.4090007@ti.com> <5756B4E7.5000007@ti.com>
 <5756C1B8.1040207@ti.com> <877fe1b0xx.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Eh5rcLMi2jMKakdI3Xfn2cri7MBOVQv6K"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877fe1b0xx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Eh5rcLMi2jMKakdI3Xfn2cri7MBOVQv6K
Content-Type: multipart/mixed; boundary="krKhKhGDxqGaLJFkXRCeBv9bxbmli7blq"
From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
 jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <5756D4AF.8030103-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
References: <1462977406-22806-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
 <1462977406-22806-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org> <574E92E8.5080201-l0cyMroinI0@public.gmane.org>
 <57501E0D.4010007-l0cyMroinI0@public.gmane.org> <57569543.4090007-l0cyMroinI0@public.gmane.org> <5756B4E7.5000007-l0cyMroinI0@public.gmane.org>
 <5756C1B8.1040207-l0cyMroinI0@public.gmane.org> <877fe1b0xx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
In-Reply-To: <877fe1b0xx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--krKhKhGDxqGaLJFkXRCeBv9bxbmli7blq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/06/16 16:09, Felipe Balbi wrote:
>=20
> Hi,
>=20
> (guys, please make sure to break lines at 80-columns)
>=20
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>>> @@ -2853,6 +2852,23 @@ static irqreturn_t dwc3_interrupt(int irq, =
void *_evt)
>>>>>>    int dwc3_gadget_init(struct dwc3 *dwc)
>>>>>>    {
>>>>>>        int                    ret;
>>>>>> +    struct resource *res;
>>>>>> +    struct platform_device *dwc3_pdev =3D to_platform_device(dwc-=
>dev);
>>>>>> +
>>>>>> +    dwc->irq_gadget =3D platform_get_irq_byname(dwc3_pdev, "perip=
heral");
>>>>>> +    if (dwc->irq_gadget <=3D 0) {
>>>>>
>>>>> Is it expected to get -EPROBE_DEFER here?
>>>>
>>>> Probably not as we don't have any chance of deferring probe here. We=
've already
>>>> probed successfully and are just turning on the gadget mode here.
>>>
>>> In general, you can't say that you've been probed successfully if not=

>>> all resources are ready, and irq is a resource :) It's expected that
>>> all resources will be requested in probe, but here you are trying to
>>> get resource outside of probe. As result, it will be perfectly
>>> possible to get -EPROBE_DEFER here if on some HW GPIO IRQ will be
>>> used as peripheral, or host or otg irq (for example), because GPIO
>>> IRQ controller might not be ready at the moment when IRQ resource is
>>> requested.
>>
>> I agree with you.
>>
>> Felipe, are you ok with moving the IRQ resource obtaining code to prob=
e?
>=20
> You mean that probe() would setup all gadget_irq, otg_irq and host_irq
> while the other pieces (otg.c, gadget.c and host.c) only use it?
>=20
> yeah, that should be fine. No problems.
>=20
OK great. I'll fix this up then. Thanks.

cheers,
-roger


--krKhKhGDxqGaLJFkXRCeBv9bxbmli7blq--

--Eh5rcLMi2jMKakdI3Xfn2cri7MBOVQv6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVtSwAAoJENJaa9O+djCTYhMQAIfR7l4rrnDGZuv7+Tb1aXAx
rcdkynmGtVFFlNlRHHtAs7xdl6NQVLfWMziy7D0fpv4+Pi3LuSL4eown/GVYlCtq
V4iYH8ajb8o06nXqWIf+xnt/U8ncv2ol0bxbbBbbJL//yjXsGRGDrvB/uRhTDoZU
6uQ5ZYUxRg+yCBOM7NmWANvvbWGom+iMeVtBMbqTKTVmtAROvF45sAmcvE81xVSw
BlDXV+pvtZATXhXeDtD95T5EzlaoposHm5U3CZWyIBQv7OTGJfiAH1O1MqDp04+7
9S03n3SWN+aPfAMT2Ye4dj9GKHSSJFU/KvEq12dx8WMjSxtdVGp5w+yr293oIN0S
X9VqqXVCO3t8RpiOzfDPoXtmtxdkWJvB3GGTRe41ZeJhm+k3uVHqz+xSr9l1zkvn
kzRbjfezSBbzQ8bgsacNBPFuf5oph2EidSP+o5/oUB74bGYi89oqBLHMu+lc01GW
WzO9RGJRranYfsbDhyyNo3M/IJ3eWT0/KLU5fPV3AGNj3PBgbPJpVBOvY/jg6buu
AhDu/K5CdSlJakcaTLyIvLyrmbwYXc8NBsxe9w825Aow3W6sled2jPx3PwOio0lL
wW7xfgtJmGGuTNGjBep7IWoW8UNcpCN//Z4SRqA9kKt36KVrmhFT9LiJEPatNNJN
uVJxysFxNYhYUbf1ReDP
=ISsW
-----END PGP SIGNATURE-----

--Eh5rcLMi2jMKakdI3Xfn2cri7MBOVQv6K--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
