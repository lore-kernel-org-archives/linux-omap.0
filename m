From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] otg.c:undefined reference to `usb_gadget_vbus_disconnect'
Date: Mon, 13 Jun 2016 08:50:39 +0300
Message-ID: <87vb1d4oy8.fsf@linux.intel.com>
References: <201606081642.T1wpsuI1%fengguang.wu@intel.com> <87k2i09f1k.fsf@linux.intel.com> <20160612023955.GA22054@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160612023955.GA22054@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> On Wed, Jun 08, 2016 at 12:59:51PM +0300, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git =
testing/next
>> > head:   fc4d1f3f522648d92d0c046beedbc1469979499a
>> > commit: 74e51eb7b5b4f7ab33c099c20def3dce0c699006 [64/67] usb: gadget: =
move gadget API functions to udc-core
>> > config: i386-randconfig-h1-06081244 (attached as .config)
>> > compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
>> > reproduce:
>> >         git checkout 74e51eb7b5b4f7ab33c099c20def3dce0c699006
>> >         # save the attached .config to linux build tree
>> >         make ARCH=3Di386=20
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> >    drivers/built-in.o: In function `nop_set_peripheral':
>> >    phy-generic.c:(.text+0x59f7a6): undefined reference to `usb_gadget_=
vbus_connect'
>> >    drivers/built-in.o: In function `nop_gpio_vbus_thread':
>> >    phy-generic.c:(.text+0x59f8a1): undefined reference to `usb_gadget_=
vbus_connect'
>> >    phy-generic.c:(.text+0x59f925): undefined reference to `usb_gadget_=
vbus_disconnect'
>> >    drivers/built-in.o: In function `gpio_vbus_set_peripheral':
>> >    phy-gpio-vbus-usb.c:(.text+0x59ff45): undefined reference to `usb_g=
adget_vbus_disconnect'
>> >    drivers/built-in.o: In function `gpio_vbus_work':
>> >    phy-gpio-vbus-usb.c:(.text+0x5a02dd): undefined reference to `usb_g=
adget_vbus_disconnect'
>> >    phy-gpio-vbus-usb.c:(.text+0x5a0333): undefined reference to `usb_g=
adget_vbus_connect'
>> >    drivers/built-in.o: In function `ci_handle_vbus_change.part.6':
>> >>> otg.c:(.text+0x605e3b): undefined reference to `usb_gadget_vbus_disc=
onnect'
>> >>> otg.c:(.text+0x605e49): undefined reference to `usb_gadget_vbus_conn=
ect'
>> >    drivers/built-in.o: In function `isp1704_charger_work':
>> >    isp1704_charger.c:(.text+0x648335): undefined reference to `usb_gad=
get_disconnect'
>> >    isp1704_charger.c:(.text+0x64839d): undefined reference to `usb_gad=
get_connect'
>> >    drivers/built-in.o: In function `isp1704_charger_probe':
>> >    isp1704_charger.c:(.text+0x648760): undefined reference to `usb_gad=
get_disconnect'
>>=20
>> thanks, fixed:
>>=20
>
> Hi Felipe,
>
> Your patch does not fix above issue, I have tried. At least, I can
> reproduce phy-gpio-vbus-usb build error if it is build in, and
> USB_GADGET is module.

alright, I'll look at this today.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXXkmvAAoJEIaOsuA1yqRE7jMQAIEJgFasw7OcKZcy8NyHQALA
D5C9piuZVXlxYyIj3H7AWeS6Xp72zjr0JBpgLflHKWyev8zuR4BiKeE7Z8jxGnTa
AAzKwfnNJuZal23VC8enlDEyGI4lWMG0ks/6RPdPKG6sX3mvaTci5XdM5ReI520V
9aGMJJZeyWZtQXRWHNWtxOSjnmWlcM7OrWmkP4lXD12P2Zfr7kPOeM1OO5kH6pn7
Z/0f3jUUdw7nWNk+qd3F7jibO5UDIu680awQN5L3s3Kg1bK2upcGIR/vuhne1TD2
g5I5xP1L5dEW4odhIIrurXEnLsdoJVdgJiYE9mrIjp/QKwhz5SsocwZ9aC6UNf3h
onCMsX6Pr+LqidlDTvUxASDHf2myhF9Kuhnq/pw1Piluvlt/BOSKANe/OoJB5Jhw
X3Gxx0dwo1r2Dk7K+SPO/av/Rz6iXwOvsmJxsbkvZeATHJCxyWM8+RVRoJw/JWxM
FC8YsdJ1rjUARoge8H0U1Cw7tc1mOcm2khnKa2cOBjIfpmL6QZksyYs2xTaICIAx
e7ODSQC4UXsY4qU3VWd7H3o0QNNEHl9YHvk4siU/okAVn78Tv/yzSMNXJkU8X2LG
/0XPBhnPtmzYj52jrpirvPmmFC5pTehdkKOCTIpGxPqBPGTuKFUJ4bhmQTXxrwvG
leMI3wDXdnPFDbXn189r
=YtT4
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
