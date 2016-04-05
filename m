From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Tue, 05 Apr 2016 08:18:24 +0300
Message-ID: <878u0s63bz.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com> <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com> <87egashxz8.fsf@intel.com> <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com> <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com> <871t6pahg8.fsf@intel.com> <56FE4378.3030205@ti.com> <87shz58wbw.fsf@intel.com> <56FE54DB.5000201@ti.com> <878u0x8ru4.fsf@intel.com> <56FEBAC1.2040509@oracle.com> <87oa9p7url.fsf@intel.com> <57029232.1080103@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57029232.1080103@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

santosh shilimkar <santosh.shilimkar@oracle.com> writes:
> On 4/3/2016 11:28 PM, Felipe Balbi wrote:
>> santosh shilimkar <santosh.shilimkar@oracle.com> writes:
>>> +Arnd, RMK,
>>>
>>> On 4/1/2016 4:57 AM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>> On 04/01/2016 01:20 PM, Felipe Balbi wrote:
>>>
>>> [...]
>>>
>>>>> commit 7ace8fc8219e4cbbfd5b4790390d9a01a2541cdf
>>>>> Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>> Date:   Mon Jul 13 18:10:05 2015 +0900
>>>>>
>>>>>       usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
>>>>>
>>>>>       The dma_map_single and dma_unmap_single should set "gadget->dev=
.parent"
>>>>>       instead of "&gadget->dev" in the first argument because the par=
ent has
>>>>>       a udc controller's device pointer.
>>>>>       Otherwise, iommu functions are not called in ARM environment.
>>>>>
>>>>>       Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.=
com>
>>>>>       Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>>>
>>>>> Above actually means that DMA configuration code can be dropped from
>>>>> usb_add_gadget_udc_release() completely. Right?:
>>>>
>>>> true, but now I'm not sure what's better: copy all necessary bits from
>>>> parent or just pass the parent device to all DMA API.
>>>>
>>>> Anybody to shed a light here ?
>>>>
>>> The expectation is drivers should pass the proper dev pointers and let
>>> core DMA code deal with it since it knows the per device dma properties.
>>
>> okay, so how do you get proper DMA pointers with something like this:
>>
>> 	kdwc3_dma_mask =3D dma_get_mask(dev);
>> 	dev->dma_mask =3D &kdwc3_dma_mask;
>>
>> This doesn't anything.
>>
> Drivers actually needs to touch dma_mask(s) only if the core DMA
> code hasn't populated it it.

that's fair, but when driver _do_ touch it, I'd rather it be useful ;-)

> I see Grygorii pointed out couple of things already.

yeah

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXA0qgAAoJEIaOsuA1yqRELsgP/RifF0K7uK36UA7I7WDUZiad
5lc9MotMgaQumSZtWZwScko7lx9XqPbh4ZRPCNGjGQivgbxhOFOurDIoJPe4kuMZ
whwOwiH6ncIqiyHVmZqPjKTnqt899H7GZ/mOgPpmFC53lAErcAyA6PiTEhWnWcVy
kYZYLcz/Gcbpj38ea4UEWObcmiY/CgHE/f+VdDObRbGFMX5JWOlQkcd0GMYLjLTS
kSXDBANZh8EE8AibBJBUGXk9yyq35lHck3rsP8LF6kRa7JiQiTaGdWznx95oJ6rJ
sEEBI9019u0TOzsDxGvRtIi9pzyCq8Oi4/uCsIBItPmMrXpLdERxSN6i4ENwjlPs
HXuTPbDObHxkZqFDePMVKztf8Nf2PwBaccjhsFT87wyq/CM6ynjQNkEG0KZjUwDD
yg7m5+I6xtU3e/pusSJiRa2VV8RgqkPyKGWTZLATP61fOZ4/7JMa0Bkd/I7OSf/W
VnhJoGDrKxiuhhzDoSnD4SYramtqaKaihG1ImiQPShZLLKxv+HEI66DUm3gUdgZa
+IljohZwuiLnLSvvVtB5+RWXlX+od1QwG4UT/ICxvEFzyPKS83EnX9+rPIA3V89n
yJMqveeHGUw2mbzvLq6qHYQl3tw/X+F07jsc+bEWQKtCfB7bl0I/m2yHVl/dqEkf
8XALQCvaTM3IWIIvrthB
=ZHYk
-----END PGP SIGNATURE-----
--=-=-=--
