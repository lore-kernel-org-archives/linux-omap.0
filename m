From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 10 May 2016 14:48:46 +0300
Message-ID: <87h9e6gmld.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-6-git-send-email-rogerq@ti.com> <877ff2i61f.fsf@linux.intel.com> <5731B395.4010201@ti.com> <87shxqgqyw.fsf@linux.intel.com> <5731C9CF.3030303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731C9CF.3030303@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> Roger Quadros <rogerq@ti.com> writes:
>>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>>> index 186a886..2e20892 100644
>>>>> --- a/drivers/usb/dwc3/core.h
>>>>> +++ b/drivers/usb/dwc3/core.h
>>>>> @@ -716,6 +716,8 @@ struct dwc3_scratchpad_array {
>>>>>   * @maximum_speed: maximum speed requested (mainly for testing purpo=
ses)
>>>>>   * @revision: revision register contents
>>>>>   * @dr_mode: requested mode of operation
>>>>> + * @gadget_irq: IRQ number for Peripheral IRQs
>>>>> + * @otg_irq: IRQ number for OTG IRQs
>>>>>   * @usb2_phy: pointer to USB2 PHY
>>>>>   * @usb3_phy: pointer to USB3 PHY
>>>>>   * @usb2_generic_phy: pointer to USB2 PHY
>>>>> @@ -817,6 +819,9 @@ struct dwc3 {
>>>>>=20=20
>>>>>  	enum usb_dr_mode	dr_mode;
>>>>>=20=20
>>>>> +	int			gadget_irq;
>>>>> +	int			otg_irq;
>>>>
>>>> while at that, let's add host_irq too and do proper changes to dwc3/ho=
st.c
>>>
>>> Sure. So we add host_irq here, and manually create an irq resource
>>> in dwc3_host_init?
>>=20
>> right :-) Then the code looks similar for otg, peripheral and host parts=
 ;-)
>>=20
> Just saw that host_irq is not used anywhere other than creating the XHCI =
platform
> device. So I don't see why we need host_irq in struct dwc3.
> It is obtained in dwc3_host_init() and consumed there itself.

fair enough.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMcqeAAoJEIaOsuA1yqREEvMP/3OVlRVz+jk4ve2SQekFLC3U
14OPNUK4nyoxLJUjonkukWnZ4bjEGvsfX//0lxQ+jaeuJTFePrVmw0sIXMYCcmdn
cuXGlnZDl3nPhwmpqE6ZRSjTCRBmCn6RppKZBCQ10Nv2L2g8VXEHXMpNJ1Rh4DdN
BEp8tZBF/rKt7QJVGtQ98f/W4L9pECCh0TdKbXrP4gQ5GeG0gVm1UMOJ9i5vQbOW
2Lpa42RgJoNqDFV9hkxVfobBSIzRg4y1Gko9x3G+CQsbg2eKzOgAswmd+vMdTknF
zy8cgSSaFRJgHgDfUN+Um3oshm9gyZBBCbOHhsYkNs7fzlyq8k8TI1oQ8//yaq/f
+Yr/NH5C0VYoQBCNPN/HGeTShc09H9Ya36t4Hj5G7ihJC0UTXtIXAvtCipLQMl/U
HMdWgMsdxjCm+zxCp0sjOyXyIe/nWmbGL/eY2s7Kti4aMHtNbQlb8EFfMxBz08bY
zZFeatahjNPUkavCePthJcUSPKazGYzXYaLQEHggQxx60CrcEdGp2K7wOnLLDzy/
OVhd4Afv9toCzVaN2AO427roSwfJGJ2mjPiOORd8L4pdDbSXprnWCewYUqizxfO/
nN4/1YU9thdayKTjMeOSrSwsYpIvGMQN0e6YWQhJYif2ygDJc25BvtY9+Iq/Nwe0
wxscVm6shL6AGYKWnki4
=jT13
-----END PGP SIGNATURE-----
--=-=-=--
