From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Mon, 11 Mar 2013 16:58:15 +0100
Message-ID: <513DFF17.5010207@pengutronix.de>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-3-git-send-email-rogerq@ti.com> <51109E95.3000307@ti.com>
 <5110C655.3060305@ti.com> <20130205090920.GH32118@arwen.pp.htv.fi>
 <5110D45A.3040007@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8090482572913820535=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5110D45A.3040007-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon <kishon-l0cyMroinI0@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8090482572913820535==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QWRIMRQJILDKOKEGTLSL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QWRIMRQJILDKOKEGTLSL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/05/2013 10:43 AM, Roger Quadros wrote:
> On 02/05/2013 11:09 AM, Felipe Balbi wrote:
>> On Tue, Feb 05, 2013 at 10:44:05AM +0200, Roger Quadros wrote:
>>>>> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/=
nop-usb-xceiv.h
>>>>> index 3265b61..148d351 100644
>>>>> --- a/include/linux/usb/nop-usb-xceiv.h
>>>>> +++ b/include/linux/usb/nop-usb-xceiv.h
>>>>> @@ -6,6 +6,10 @@
>>>>>   struct nop_usb_xceiv_platform_data {
>>>>>       enum usb_phy_type type;
>>>>>       unsigned long clk_rate;
>>>>> +
>>>>> +    /* if set fails with -EPROBE_DEFER if can't get regulator */
>>>>> +    unsigned int needs_vcc:1;
>>>>> +    unsigned int needs_reset:1;
>>>>
>>>> how about u8 here?
>>>
>>> Not sure. Bitfields are usually defined as unsigned int.
>>
>> IIRC the benefit is that compiler can try to optimize those flags. I
>> mean, if you have 32 1-bit flags, compiler will combine those in a
>> single u32. Someone correct me if I'm wrong.
>>
>=20
> Yes you are right. Kishon was asking me to use u8 instead of unsigned i=
nt, which
> I don't think is necessary. AFAIK, it is a norm to use unsigned int whe=
n defining
> a bitfield. Compilers are known to behave funny with bitfields. I don't=
 mind
> using bool for each.

In the current version (rogerq/v3.8-usbhost17-dt) of this patch you've
put both needs_* into the private data struct and the pdata, but it's
only used inside the probe function.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QWRIMRQJILDKOKEGTLSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE9/xsACgkQjTAFq1RaXHOWhgCfXLUu1SsrO85DKNMpgLlsAQry
EeAAnj2kFjkQh5rLWK61G1Exc68vCfgw
=ZGO5
-----END PGP SIGNATURE-----

------enig2QWRIMRQJILDKOKEGTLSL--

--===============8090482572913820535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8090482572913820535==--
