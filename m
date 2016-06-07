From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 07 Jun 2016 16:09:14 +0300
Message-ID: <877fe1b0xx.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com> <57501E0D.4010007@ti.com> <57569543.4090007@ti.com> <5756B4E7.5000007@ti.com> <5756C1B8.1040207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5756C1B8.1040207@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

(guys, please make sure to break lines at 80-columns)

Roger Quadros <rogerq@ti.com> writes:
>>>>> @@ -2853,6 +2852,23 @@ static irqreturn_t dwc3_interrupt(int irq, voi=
d *_evt)
>>>>>    int dwc3_gadget_init(struct dwc3 *dwc)
>>>>>    {
>>>>>        int                    ret;
>>>>> +    struct resource *res;
>>>>> +    struct platform_device *dwc3_pdev =3D to_platform_device(dwc->de=
v);
>>>>> +
>>>>> +    dwc->irq_gadget =3D platform_get_irq_byname(dwc3_pdev, "peripher=
al");
>>>>> +    if (dwc->irq_gadget <=3D 0) {
>>>>
>>>> Is it expected to get -EPROBE_DEFER here?
>>>
>>> Probably not as we don't have any chance of deferring probe here. We've=
 already
>>> probed successfully and are just turning on the gadget mode here.
>>=20
>> In general, you can't say that you've been probed successfully if not
>> all resources are ready, and irq is a resource :) It's expected that
>> all resources will be requested in probe, but here you are trying to
>> get resource outside of probe. As result, it will be perfectly
>> possible to get -EPROBE_DEFER here if on some HW GPIO IRQ will be
>> used as peripheral, or host or otg irq (for example), because GPIO
>> IRQ controller might not be ready at the moment when IRQ resource is
>> requested.
>
> I agree with you.
>
> Felipe, are you ok with moving the IRQ resource obtaining code to probe?

You mean that probe() would setup all gadget_irq, otg_irq and host_irq
while the other pieces (otg.c, gadget.c and host.c) only use it?

yeah, that should be fine. No problems.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVsd6AAoJEIaOsuA1yqRE160QAKRZ2EoRdfvQE+CtF8toJx8y
G0TXqhSDeyAXR1sVKHRxWcJyeM0iYzxh/xm5/+raxB90lPdqGM1thP3ewUAzVO6j
IQAyXXGjT9SvjzO/Rp8nHPYccowm8MRMBCSyJ5E/wdHgGHlPI6k7VFFeb3dwG31Q
YxMEZMYp0eG/UY1qiZoJLcGnYY8JvxZUmeXT/GhXhj7zvLFDweGrmixz529gIF/P
qJ4FHjGCoLVHUe8bHy1EWWBfw9SJL/WXMnNbWtVBUBW82K21orj7GTnfsP0AsO73
daRiw4M10+Rps0oL4dcy/VKvxe3Umanz+XY+1fUOuWxr5gzb1sik7V2ErZMO8D9A
iPMV4ZDARwFK6Vsq+2rtygS6TypbgYHCfXj2SuGCLHWjBMDVrsvSpWybYgkIrwGy
WwdvWB2JLS4ED6Qa6VUJqUZa/CPI1lL9X9TWcYC085KRjQ1sDe+LlfQZr+yZXw5V
sdaeAzP//smrFTO9QQY7BCNUiaJ8qtksdhIXSn+ZQ3ZvpQrYtsXfx9Hhqft5CHXT
XwoZhQyD8rIUfcWG9Vj2YTN/lUWP7xD8TS3kdgPOW1CzybOT3qTXwZfnmBQdgKN/
slkUKq9OxL0rv5XkzweQHvn6jFA4Df9Y5PZfvITrQyeuxlguyoZqnFfjh0szEKc4
vNb3dTwR8kbNV8eamZSy
=3LFO
-----END PGP SIGNATURE-----
--=-=-=--
