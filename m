From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: MUSB not workin in .27rc6, was: Re: OMAP support in mainline?
Date: Fri, 19 Sep 2008 18:09:04 +0200
Message-ID: <615FFFC3-999C-4DBD-A0FE-DCAA8BF18429@student.utwente.nl>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl> <20080918095537.GD28615@gandalf.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7-867692531"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:58842 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbYISQJR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 12:09:17 -0400
In-Reply-To: <20080918095537.GD28615@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7-867692531
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable


Op 18 sep 2008, om 11:55 heeft Felipe Balbi het volgende geschreven:

> On Wed, Sep 17, 2008 at 03:23:49PM +0200, ext Koen Kooi wrote:
>>
>> Op 17 sep 2008, om 14:24 heeft Steve Sakoman het volgende geschreven:
>>
>>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi =
<k.kooi@student.utwente.nl=20
>>> >
>>> wrote:
>>>
>>>> And they aren't working too well with current l-o git either with =20=

>>>> MUSB
>>>> being
>>>> broken. There's a patch to fix client mode, but host mode still =20
>>>> isn't
>>>> working.
>>>
>>> Host mode musb is working just fine on Overo with the "set
>>> transceiver" patch.  Not sure why you are having trouble with Beagle
>>> (and can't check since I don't have my Beagle board with me at the
>>> moment)
>>
>> I should clarify: OTG mode with a host cable doesn't work in .27rc, =20=

>> it does
>> work in 2.6.26. I haven't tried specifying pure hostmode, only OTG.
>> I would try it on the evm as well, but that is having serious irq =20
>> issues
>> with .27rc, pressing a key on the keypad triggers an irq overrun, =20
>> ethernet
>> gives an oops on boot when trying to register and irq etc,etc. =20
>> 2.6.27 is
>> looking really, really bad on omap3 at the moment.
>
> Yeah, we lost some musb history when it went to mainline. I didn't =20
> test
> this patch yet cuz I've been quite busy at work, but it should make
> beagle work. Could you tell me if makes it work ?
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 9d2dcb1..f7fe91e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, =20=

> u8 musb_mode)
>
> int __init musb_platform_init(struct musb *musb)
> {
> +       struct otg_transceiver *xceiv =3D otg_get_transceiver();
>        u32 l;
>
> #if defined(CONFIG_ARCH_OMAP2430)
>        omap_cfg_reg(AE5_2430_USB0HS_STP);
> #endif
>
> +       memcpy(musb->xceiv, xceiv, sizeof(*xceiv));
>        musb_platform_resume(musb);
>
>        l =3D omap_readl(OTG_SYSCONFIG);

Ok, another datapoint: client mode (tested on beagle by M=E5ns) and host =
=20
mode (tested on overo by Steve) work with a similar patch as above, =20
OTG mode is broken (tested on beagle and evm by me).

regards,

Koen



--Apple-Mail-7-867692531
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI086iMkyGM64RGpERAje5AKCkpnuyNPHH6f3z/MVX1JgS95Y1EwCfc1yw
fllepNQ0eVa9od/TjH1H448=
=DWu6
-----END PGP SIGNATURE-----

--Apple-Mail-7-867692531--
