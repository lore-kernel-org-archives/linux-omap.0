From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference to `usb_gadget_vbus_connect'
Date: Tue, 07 Jun 2016 12:36:13 +0300
Message-ID: <87wpm1basy.fsf@linux.intel.com>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com> <87bn3ecwbz.fsf@linux.intel.com> <878tyicva6.fsf@linux.intel.com> <20160607015405.GB17095@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160607015405.GB17095@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> On Mon, Jun 06, 2016 at 04:16:17PM +0300, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>> > [ Unknown signature status ]
>> >
>> > Hi,
>> >
>> > kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=
 testing/next
>> >> head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
>> >> commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadget:=
 move gadget API functions to udc-core
>> >> config: x86_64-randconfig-s1-06061834 (attached as .config)
>> >> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
>> >> reproduce:
>> >>         git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
>> >>         # save the attached .config to linux build tree
>> >>         make ARCH=3Dx86_64=20
>> >>
>> >> All errors (new ones prefixed by >>):
>> >>
>> >>    drivers/built-in.o: In function `nop_set_peripheral':
>> >>>> phy-generic.c:(.text+0x14423f): undefined reference to `usb_gadget_=
vbus_connect'
>> >>    drivers/built-in.o: In function `nop_gpio_vbus_thread':
>> >>>> phy-generic.c:(.text+0x144742): undefined reference to `usb_gadget_=
vbus_disconnect'
>> >
>> > oh yeah, I have to fix this. I'll do it now.
>>=20
>> In order to fix this, I'll have to add something like below:
>>=20
>> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
>> index 3644a3500b70..bd67e4ac4b61 100644
>> --- a/drivers/usb/chipidea/Kconfig
>> +++ b/drivers/usb/chipidea/Kconfig
>> @@ -19,6 +19,7 @@ config USB_CHIPIDEA_OF
>>  config USB_CHIPIDEA_PCI
>>  	tristate
>>  	depends on PCI
>> +	depends on USB_GADGET=3Dy || USB_GADGET=3DNOP_USB_XCEIV
>>  	depends on NOP_USB_XCEIV
>>  	default USB_CHIPIDEA
>
> Hi Felipe,
>
> It causes any drivers which use symbols from gadget.h needs to build
> USB_GADGET even it only wants to be host function. Any significant
> benefits after moving it to udc-core.c?

why is a host-only function calling into the gadget API?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVpWNAAoJEIaOsuA1yqRErigQAKPPXseDdLiX6cXa/9utcpgB
UaKM0QEu+7OwFsdh5rk8c7lhKlQqXigb7eEeQ54FDtB0UvOpx2QUHRE1sWWW3a7z
WS+hIefdJNwkZ1EzV226PqKLfh/EDg5sa2F0WMa/GHCWScvStv9LOHiDi1pIdZUt
AFSp0SB5bJ47cfqvKJGcyz9X4eb8e/cyaeWcqWOgTBMkbVNFvzLZIDoY3GStnw5f
4Yj+iV/N3SEMOic/kihJXnU/TRrHjXQmUVSm8ySpPKxEX6tLfMuiMRGDjJfMYV35
BWHXeYw9ccMppirt/976oqgzhABCvxtpgJ8J9qaOzrDhtfnbrF9pTG/AVO1gdMAr
Zzta5XOQEuTqZqnU3muNba2/izClLHtFpaGm/GWQxfXZhAcCH4O0xI6Tml71zt1u
cHx4jJVTq2P2h+2yMiIypfoEH8KEfqHCINdwMQt/PvI5STrWq2CXQ4+/AWcLaicd
+Uik4wPUwLThqsCyzEUNMGYEqwy/KOuSQkN2AMhv5UMp/wUPK8WjWGiBAinBc9TY
RGHDo6cQcpSqbX5BKtDTnKfa/EVHjFRRsytEVJZiz9GdrkKPatK6Aw4sNzP0CsNS
SzGR1xw0Wkx+VgS232ZeO8HSojbMMvI7Iy7xWTOpBW5S4bHwKr8G1OjnYcg5EAI3
i11gzyO6TNBuiDe3tzby
=zTd+
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
