From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference to `usb_gadget_vbus_connect'
Date: Mon, 06 Jun 2016 15:53:36 +0300
Message-ID: <87bn3ecwbz.fsf@linux.intel.com>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201606062026.EQTlXIDR%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tes=
ting/next
> head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
> commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadget: mov=
e gadget API functions to udc-core
> config: x86_64-randconfig-s1-06061834 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>
> All errors (new ones prefixed by >>):
>
>    drivers/built-in.o: In function `nop_set_peripheral':
>>> phy-generic.c:(.text+0x14423f): undefined reference to `usb_gadget_vbus=
_connect'
>    drivers/built-in.o: In function `nop_gpio_vbus_thread':
>>> phy-generic.c:(.text+0x144742): undefined reference to `usb_gadget_vbus=
_disconnect'

oh yeah, I have to fix this. I'll do it now.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVXJQAAoJEIaOsuA1yqRED/wP/iotKqHTSvw2OxyH97Vr+a7k
oH0pfPyjkVmJpxt7mk8osbsAfI/quC2RcSyI8q5ZW+w9irPaqOTvFnnCFAGvlHwh
xNw1kR6Y9C9kapV6Erchlc/zzcJGF9b2uDFncreIhcSHZFIlfwfon6wzQR+J6tOf
QY9dWITX+0Imgnf7x9L0KG9Lfg/iD3NVgsa5umwa9lev2YwYswwWgkUo6tW+bXaC
lX+CBRS3KAI1CXXnd3a0lLV1sTgjlzga4YcgnGSQAVCCuVmmTpWnCSmjZMu84Pya
ukfvDimxGXvzkIed7e2xAzBiN6Yd8maeok6xuGxqdNYEZg18UQHEKbdYtHt70Nun
wyWGSyziEbjy6SdqybSf7AwW4L2sNw1Vf2Vw8Dho7cHZKPqEcBAOfEcNHcAxLfZm
CGw7rSUhBF/WCKx03SiXsZwtUNcd+w3yJaRiMP4lfThIq2SpaRurCTl/5+c2Q0eT
pTkkr/a/cLK7IEJ18AjZVVD0nxUzk2vpnOVQs29Y3EtrAfo1oPbfZ4TO/anqNAEe
sUEx4t9XSgkKxFUi8SaouCh+MsH4bP8c+ZNN+mRHM5fVCRmurhbh8ftfBaMtazZu
5k69GJcUk+iG3l1qHcH+QOZYzY+5mafxu3x85rtQlqFEGG+4LzUwxj3hwjhJ9gQw
PxiKXK43wU3HnxX/9jrc
=nJoi
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
