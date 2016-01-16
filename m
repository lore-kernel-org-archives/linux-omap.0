From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 1/2] usb:dwc3: Enable support for 64-bit system
Date: Fri, 15 Jan 2016 21:28:47 -0600
Message-ID: <8760yu6w40.fsf@ti.com>
References: <1452748125-31639-1-git-send-email-tqnguyen@apm.com> <1452748125-31639-2-git-send-email-tqnguyen@apm.com> <87h9ig9n88.fsf@ti.com> <CAKrQpStmh6NHY_eUTgU0op-cuuWRUutuVHLVXGN6YhCvzh70Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKrQpStmh6NHY_eUTgU0op-cuuWRUutuVHLVXGN6YhCvzh70Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Thang Q. Nguyen" <tqnguyen@apm.com> writes:
> Hi Balbi,
>
> On Thu, Jan 14, 2016 at 10:47 PM, Felipe Balbi <balbi@kernel.org> wrote:
>>
>>
>> Hi,
>>
>> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
>> > Add 64-bit DMA operation support to the USB DWC3 driver.
>> > First attempt to set the coherent DMA mask for 64-bit DMA.
>> > If that failed, attempt again with 32-bit DMA.
>> >
>> > Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
>> > ---
>> >  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)
>> >
>> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> > index 22b47973..9818d6b 100644
>> > --- a/drivers/usb/dwc3/core.c
>> > +++ b/drivers/usb/dwc3/core.c
>> > @@ -829,6 +829,21 @@ static int dwc3_probe(struct platform_device *pde=
v)
>> >       dwc->mem =3D mem;
>> >       dwc->dev =3D dev;
>> >
>> > +     /* Try to set 64-bit DMA first */
>> > +     if (WARN_ON(!pdev->dev.dma_mask))
>>
>> why the WARN_ON() ?
>
> In my opinion, pdev->dev.dma_mask is expected to be set correctly. And

sure is, but a WARN_ON() will print out a stack dump, which looks
scary. Besides, if it's not set you're already fixing the problem.

> the issue happen just in case of DT boot and CONFIG_DMA_CMA=3Dn, the
> pdev->dev.dma_mask value is not set. So, I set WARN_ON there to notify

why isn't it set ?

> that we expect pdev->dev.dma_mask set but not.

why don't you fix that case, instead ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWmbjwAAoJEIaOsuA1yqREVd8P/jAflPR4ebKzte/qxfPFRBrX
4av5KwbVSAeGtgK2DRSckPBl9hDodBTa8soD56NAoaZujvO+y/EPI2ei8jkyo4kQ
eD1FkN9THslx3aR+3oLLPzm8xTeDPP/hZmQMXoy26QHg/fcrePC0fCC/IEqsUjN0
ZoDL7xhjOwZ4/tkXmVvbd8uuhvOwmFmJjocGYDXWFEHCeF832QzGSNJmOv9mIt5W
XsBsZcR3Rz+cquD5+JUvF08wnob+lKzGH+8dS4fBcNaqXpyjwY8aKGVnY2KhOFo/
2tDK37pfNuU2tYdA3VaUg1AIPwQ/4HJJ9NQBBTzyrL+aXYop8D5XP1Xqez2ULv+J
PX5SlA7pmO9j27ywK6eFQobZzyNPxH0JB2715sewLImHKtb7gs449IZ22WjcpO8Y
rNXDEAZvEglgbl3bJMDJrUYMlVLsXIR+YkTXW8lRXjFomxTkssD+YQL5MHliOgmn
n4uMqGHyp36pBl3BtlEwA8v5brS4G8IPWFAOVhto0dccFEWd/9EyoeatmmP2b0PF
rW1Mdkjl/HvXTx/O+MxKV/oDWlFLkBVi8B2O9TX0J/LBu1eWITm9Cf03gueCHLcd
YIMZIHjst+zLgtAVYLmU6nYrjX7g3pX3SQIjWhZrJH7lpzdVtS7VW7roqrBqYzd3
HhwoBxWoKSUK0APxrx1A
=ihXc
-----END PGP SIGNATURE-----
--=-=-=--
