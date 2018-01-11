From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host bus-suspend/resume
Date: Thu, 11 Jan 2018 10:14:58 +0200
Message-ID: <87r2qwyfp9.fsf@linux.intel.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org> <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com> <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Manu Gautam <mgautam@codeaurora.org>, Roger Quadros <rogerq@ti.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Manu Gautam <mgautam@codeaurora.org> writes:
>> On 27/09/17 14:19, Manu Gautam wrote:
>>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>>> resume. While this works fine for gadget mode but in host
>>> mode there is not re-initialization of host stack. Also, resetting
>>> bus as part of bus_suspend/resume is not correct which could affect
>>> (or disconnect) connected devices.
>>> Fix this by not reinitializing core on suspend/resume in host mode
>>> for HOST only and OTG/drd configurations.
>>>
>> All this seems correct but we (TI) were relying on dwc3_core_exit() to b=
e called
>> during dwc3_suspend() to have the lowest power state for our platforms.
>>
>> After this patch, DWC3 controller and PHYs won't be turned off thus
>> preventing our platform from reaching low power levels.
>>
>> So this is a regression for us (TI) in v4.15-rc.
>>
>> Felipe, do you agree?
>>
>> If yes I can send a patch which fixes the regression
>> and also makes USB host work after suspend/resume.
>>
>
> I think it will be better to separate runtime_suspend and pm_suspend hand=
ling for
> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across s=
ystem
> suspend-resume should be ok but doing that for runtime suspend-resume is =
not
> correct.

it sure is. It's part of hibernation-while-disconnected programming sequence

> Let me know if that sounds ok, I can provide a patch for same instead of
> reverting this which affects runtime PM with dwc3 host.

nope, that would break platforms using hibernation

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlpXHQIACgkQzL64meEa
mQYrvw//W28huIeF3CzYNv/HyJS+b4RcOEsQXRp7WGhcbEeVRT7ECW4u5ppJwaxK
lhlJfwZqTDYSASDq4teyIEJOPvbMdc8Qi95xcy4rq9XqEIdL6vQwRdlPEdbJI7OU
rZAe1c+ShiL2EuG/TX5K24oEexUlE/aN+uWJkkDX4WQVBenrzWQUNy34RJX8+Aao
iDCTB0KOZJAnZKDewqibzy3LEi/OGG4xh9m5Y4QQD4Ays/V6qnb7qhPrW+yKQ29K
yukBfpr3Uj932ynL1IWzuaWZDJIjebUCbyKAdTwCX6guYTcB0hjUb/raksSP/z/w
zZdQHxPimi4zwjwUra6Izj69KkWxBmtYhNZ1RnLyJxntKqHN6dYChOrDsxqdUX8Y
oyKbwGT5alUqQt7TfbH4ZyjPawkC86JKLw5bmtBKxvtjkubZf2+E/NCyk6Nb1wFj
NL7NWZvOIPlx0GLVjh4fC+prnxBYIYbWRLTXcyBVG82MKfDGGYSSkbADiZC231rG
r5Sq5unR2hF01ZNx9dW4jkZD/UCetlpwrEjxtoAdhO7qtYZMuqDz33LVYuq5suuG
UUG8PzEGvbehO+hYKS4wGobvNauxcJPtBouO6OJYRQP1Q/I233Em8FrKzj0r73qg
7ybpLCqaB2cwzisCok9JeBrXmbzTUEB6dfjl4llUBaNGaSuSnLE=
=P+Yo
-----END PGP SIGNATURE-----
--=-=-=--
