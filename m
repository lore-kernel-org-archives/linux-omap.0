From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host bus-suspend/resume
Date: Wed, 10 Jan 2018 14:57:13 +0200
Message-ID: <876089zxau.fsf@linux.intel.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org> <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Manu Gautam <mgautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> Hi Manu,
>
> On 27/09/17 14:19, Manu Gautam wrote:
>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>> resume. While this works fine for gadget mode but in host
>> mode there is not re-initialization of host stack. Also, resetting
>> bus as part of bus_suspend/resume is not correct which could affect
>> (or disconnect) connected devices.
>> Fix this by not reinitializing core on suspend/resume in host mode
>> for HOST only and OTG/drd configurations.
>>=20
>
> All this seems correct but we (TI) were relying on dwc3_core_exit() to be=
 called
> during dwc3_suspend() to have the lowest power state for our platforms.
>
> After this patch, DWC3 controller and PHYs won't be turned off thus
> preventing our platform from reaching low power levels.
>
> So this is a regression for us (TI) in v4.15-rc.
>
> Felipe, do you agree?
>
> If yes I can send a patch which fixes the regression
> and also makes USB host work after suspend/resume.

A power consumption regression is still a regression. But it's super
late in the -rc cycle, I think we need to get this merged after 4.16-rc1
and make sure to Cc stable.

Should be more than enough time to review and test patches.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlpWDaoACgkQzL64meEa
mQbh6A/9GPqNgSfwASqxiOpi5qrnqXTJ+3+DXolv2XJ+aebTJQaJo2odmHyy2iK7
YZNuWy6ad0ov7adCPwhLBElWPpQOSH85ctnulS2Qo+qTxRMh3BE7npbOd5iAZj2U
AgF28E4m03QKDIUXm8pFRMo7HQJKstqT/W28ryzSrTzxbBp0MVhxXv53WXvEUVrF
lO0FvEApYK8WAsOqYc3ERQ634RysysPDXTHkEDClEvF1bPRXxSGd5rGFlYLIS8w/
PykHuBcQMoBQieMmpJqFlxEfEfJTS7UWnJPJx16Y7KEqmLhwWR1P/Iv8Ws7pbuwi
yGj1POcoWeSfqTomq/OelNJC2THd9PXwiyF07mKVOvH0A6Yz/RZw1ytPzkip8/x5
q9h/FRy81+JDzYhGZ0d+5ZDApS9/XzbzvDNcjgSlxJrsI5j9hL/WglOX+7y/w9uy
/uN+hlusMIqNLC/Ny9nH/jLPDtt6jxyptznZI1IRf1vXcNuezuLfLAUohI6apMDD
Wptugnh77UdwHblc6gFhxlWLMdnwfexoTtBoofnMFe6EhiboqQ9h0OdUfdXEI3PE
u4aI4tSTwS1xTDKHJHPH0BIeHOjoy+Dddl21hODc/MfHaBLj2Gpol5g4Ka2uSMy4
RVPnJmPnABE9pImO7G6M0WvSq2Nu06G8HZLDvINwBbmYGUkKxco=
=y/ad
-----END PGP SIGNATURE-----
--=-=-=--
