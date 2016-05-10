From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 10 May 2016 13:14:15 +0300
Message-ID: <87shxqgqyw.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-6-git-send-email-rogerq@ti.com> <877ff2i61f.fsf@linux.intel.com> <5731B395.4010201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B395.4010201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>> index 186a886..2e20892 100644
>>> --- a/drivers/usb/dwc3/core.h
>>> +++ b/drivers/usb/dwc3/core.h
>>> @@ -716,6 +716,8 @@ struct dwc3_scratchpad_array {
>>>   * @maximum_speed: maximum speed requested (mainly for testing purpose=
s)
>>>   * @revision: revision register contents
>>>   * @dr_mode: requested mode of operation
>>> + * @gadget_irq: IRQ number for Peripheral IRQs
>>> + * @otg_irq: IRQ number for OTG IRQs
>>>   * @usb2_phy: pointer to USB2 PHY
>>>   * @usb3_phy: pointer to USB3 PHY
>>>   * @usb2_generic_phy: pointer to USB2 PHY
>>> @@ -817,6 +819,9 @@ struct dwc3 {
>>>=20=20
>>>  	enum usb_dr_mode	dr_mode;
>>>=20=20
>>> +	int			gadget_irq;
>>> +	int			otg_irq;
>>=20
>> while at that, let's add host_irq too and do proper changes to dwc3/host=
.c
>
> Sure. So we add host_irq here, and manually create an irq resource
> in dwc3_host_init?

right :-) Then the code looks similar for otg, peripheral and host parts ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbR3AAoJEIaOsuA1yqREZ28P/3NevqaKyv1DeObqgUQbLFj0
lAVcGFYDYFf9rfr9IRiV28NBp8rYnGqLNh41OymO7cJE+DvtK0jOOOxqNKC/gNDi
uXGaZ5vzz0rLKch9Yd7RTrNuLFQcYAr2nl3RtRns5+0CGVc2u72zFo851vGiotN/
q4XHEZ7iVnWvopKhyiUkMrMhph5usABL8OMesork3tMVoWSg3GCiOY2z9kbsBp3E
vkNR1i5G6zPROVzgKhKM1E0JP5GbA37wP/4vqV1N3grSrktbu/kPKrH4dzjTrYHY
t4eVpw8rydw2ypYkl997AiP2jj+eQRjVLWkxJGmDvmGy9vz+7+fEamwNyXvOZtdJ
E0uDGGMsS/3j/MA2dmQnB13Im4gLbGaj0TCc0sf7j6kLnCD0mAQvSacgAhBRGHzA
Ytr40j6gDwtrAC+MxRpDHIB2hTRLL3lpBcwUjFm6wklwY9/6F2dRZjf3MYNqiAKG
I+7DsvXh3o7kt15S7ZJtU72DZZW9oWv2hiFpIRyIzl8GQdUOl9AjcKVU/bEzSfPd
Eq4rV2BXwgt6ef9wXJvCTKhIbjqho7BsvVppbeCFBi2OtsqQcte0u6qzS50z/9cv
aGWAbB5HLxnrb5M51KYt2CR0OU6a1yKGSmxjC+yzmYxuAN9Ryxp3kkfCsLYxKWnF
Wj1IWqz5Vza9ithpWoaM
=nbRY
-----END PGP SIGNATURE-----
--=-=-=--
