From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 3/5] usb: dwc3: omap: Don't set POWERPRESENT
Date: Tue, 10 May 2016 13:33:51 +0300
Message-ID: <87mvnygq28.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-4-git-send-email-rogerq@ti.com> <87futqi6gs.fsf@linux.intel.com> <5731B118.1010705@ti.com> <874ma6i5zi.fsf@linux.intel.com> <5731B6AD.9070108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B6AD.9070108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 10/05/16 13:04, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq@ti.com> writes:
>>> On 10/05/16 12:54, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>> TRM [1] recommends that POWERPRESENT bit must not be
>>>>> set and left at it's default value of 0.
>>>>>
>>>>> [1] OMAP542x TRM - http://www.ti.com/lit/pdf/swpu249
>>>>> Section 23.11.4.5.1 Mailbox VBUS/ID Management
>>>>>
>>>>> "Because PIPE powerpresent has a different meaning in host and in dev=
ice mode,
>>>>> and because of the redundancy with the UTMI signals, the controller O=
Res
>>>>> together the appropriate PIPE and UTMI inputs to create its internal
>>>>> VBUS status. For that reason, it is recommended to leave field
>>>>> USBOTGSS_UTMI_OTG_STATUS[9] POWERPRESENT at its default value (=3D0),=
 and only to
>>>>> fill in the USB2 VBUS status fields in the same register."
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>
>>>> to make sure we avoid regressions, do you mind sharing on which
>>>> platforms you tested this patch ?
>>>>
>>> I tested this on omap5-uevm and dra7-evm.
>>> My am437x board stopped working so couldn't test on that one.
>>=20
>> would you have a colleague or perhaps an automated test-farm which could
>> run the test for you ? :-)
>>=20
>> I can take the patch, no problem, but if there are any regressions don't
>> blame me :-)
>>=20
> Don't worry, blame is on the TRM then :).

alright then, so seems like v8 will be queued. Just remember we're
pretty close to opening the merge window and I have already sent a pull
request to Greg. On the bright side, your patches will sit in linux-next
for quite some time :-) (well, until -rc1 is tagged)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbkPAAoJEIaOsuA1yqREy4UQAIiiQ5mLG3krLAxXX3z26h0U
MqHP+Dd5AVS9tpcvbpwNhBrE4h/vysoKrVLxYqnXRHXDeVtM8bwrq77Y62Ar/DO+
Vc97F9ra39u9Hf4267MS0xY25CJwnQm33tnpJxtY3NR8RpuR3n9prkSFyn5Kw6WW
cHafzlgQupnzxHVF+y122TwkKt1R1VlnER5RkzkaB0+8qEONSuiNKV80c9pOzCbM
dL3YxXIOZTECWQO7+hXoVP2ARWZVw/Phv9OAsCf/+1RbtFGlB2d7OeW7XqUZ915G
JMAiS4GN3jfh1yOP4Kt8rmuWMVxKmScAnVYFckme5IB+1itoz+7cr+jEQixY7SdD
XFIjI6j+6hgfJXiwiL6wjfNGAz91RfVW5WSXsh9yyB50Ge8SpRMctOvFnvVUsluT
gL7NjSsqfTFQhDlhf0FbxucuTnP0kmgg2wV4AlVoUdkQ9bpRTXC0nOTlNea0/+Hy
pKHL46OMUd5En/t11oFBYjOoABivWoZ6WOpvaZTuL5FiNvJO1mzz2tKyOOW1IpUu
EajKciOSOxqobuQZtKH+PiO/Tu0jCyzgtt2A5cl7po/f/UjukeFFAViLmm3SoQbE
RynU0PyMNYUcGduq6dYU+hpffjkOSGodMzipAQuq3qS8zP4iL9Vir3CZLmVFJUYr
4MSOCVqxsWg1T/OByW9O
=UGFT
-----END PGP SIGNATURE-----
--=-=-=--
