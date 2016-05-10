From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Tue, 10 May 2016 11:12:32 +0300
Message-ID: <87twi6ib67.fsf@linux.intel.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com> <1462191537-10314-4-git-send-email-rogerq@ti.com> <20160506094103.GF32359@shlinux2.ap.freescale.net> <57305C42.90300@ti.com> <20160510031401.GA3748@shlinux2.ap.freescale.net> <57318F19.7000506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57318F19.7000506@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 10/05/16 06:14, Peter Chen wrote:
>> On Mon, May 09, 2016 at 12:45:38PM +0300, Roger Quadros wrote:
>>> On 06/05/16 12:41, Peter Chen wrote:
>>>> On Mon, May 02, 2016 at 03:18:46PM +0300, Roger Quadros wrote:
>>>>> The OTG core will use struct otg_hcd_ops to interface
>>>>> with the HCD controller.
>>>>>
>>>>> The main purpose of this interface is to avoid directly
>>>>> calling HCD APIs from the OTG core as they
>>>>> wouldn't be defined in the built-in symbol table if
>>>>> CONFIG_USB is m.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>>>
>>>> Roger, after thinking more, I still think current dependency between
>>>> OTG, HCD and gadget are too complicated. Since the OTG can't work
>>>> if it is built as module, I suggest letting OTG depends on HCD &&
>>>> USB_GADGET, and it is a boolean, in that case, we don't need to
>>>> export any HCD and gadget ops, things will be much simpler.
>>>> What's your opinion?
>>>
>>> How will it work if HCD and USB_GADGET are modules and OTG is built-in?
>>>
>>=20
>> The OTG will not be compiled at this situation, since it is boolean.
>> In fact, like I mentioned at above, OTG or USB function can't work if
>> it is built as module.
>
> Isn't this a limitation?

I agree, it should work built-in or module.

> As per the current implementation dual role works fine even with both
> USB_GADGET and HCD as module.
>
> In the real world it is unlikely that GADGET and HCD will be built-in.

we can't make this assumption, however :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMZfxAAoJEIaOsuA1yqRE0v0P/1Cq2/hiwSqK5XSEead2gNDT
EEqATXrusScuG6mYUuYOHJcFLWVSRk3XY2GlyGrYD+yFNg+rKWigNGGcwSAI53f2
X/EMAtxTwz8QvYPQT3bR52ydwccEXJClzTk/u00Zyo5rgmpwMWh2JFlSQLvP3rP5
BFFSQPk6eG6/q6BP4dzS5f30gZb8cTWVAwr4tJkxbAXobSGlQR+ljn9t9MYwHcgr
b23EUv37G8hVZ6Q0oOQnv/D8Y4RAgY5XXVUbnAiu0aIz/0wf3nw4hVX1nbRRUO4l
B2UhI7IrK/H7R3BD9Xc6rNZzzhqKxx32tL5Bot3u+K5uavJ1M/BkSIJcWCcyRi6B
qZHQx1mDz1GbIMvlzU2YYpqv6y5izRufqt2XwvKyxl6xd/xpIuD55Y5nDThzScT5
sQO9gLmAOT1vbvBtovCDSxnhgJiTmSO390TGQGnWJljbgD5HFA8jfrv/35kI0mnM
qgWEWGwrZXTB0/4Rt8rUHXA7wBbwxsdLXlXTC1xEh7inn70TFgBCX5JSVJC1gJDy
QeADIHxiUWQ3HFE4BLUo3uVA3IGVkkYkgrrCs6iSGNAUrpsv+9iHYQmvh7lJaUUJ
JvOU9gFT3kaH8AaMBTVIh76bmoFsOfmWiZqb/hxctXy9uIZrumqm9n9lcoE/gBnN
GPNMIw5Fbrwz7F/p+OtS
=ZkuX
-----END PGP SIGNATURE-----
--=-=-=--
