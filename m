From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 34/43] drivers/usb/mtu3/mtu3_qmu.c:261:2: note: in expansion of macro 'dev_dbg'
Date: Tue, 17 Oct 2017 12:37:51 +0300
Message-ID: <87infejes0.fsf@linux.intel.com>
References: <201710171728.UXKlCAtU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201710171728.UXKlCAtU%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tes=
ting/next
> head:   39325b9a22301178ef684effade7c8bce04b5246
> commit: 8706b37e87e58cd4d4dea593767d34447321610a [34/43] usb: mtu3: suppo=
rt 36-bit DMA address
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8706b37e87e58cd4d4dea593767d34447321610a
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dxtensa=20
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/printk.h:329:0,
>                     from include/linux/kernel.h:13,
>                     from include/asm-generic/bug.h:15,
>                     from ./arch/xtensa/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:4,
>                     from include/linux/scatterlist.h:6,
>                     from include/linux/dmapool.h:14,
>                     from drivers/usb/mtu3/mtu3_qmu.c:30:
>    drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_tx_gpd':
>    include/linux/dynamic_debug.h:74:16: warning: format '%llx' expects ar=
gument of type 'long long unsigned int', but argument 7 has type 'dma_addr_=
t' [-Wformat=3D]
>      static struct _ddebug  __aligned(8)   \
>                    ^
>    include/linux/dynamic_debug.h:110:2: note: in expansion of macro 'DEFI=
NE_DYNAMIC_DEBUG_METADATA_KEY'
>      DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, 0, 0)
>      ^
>    include/linux/dynamic_debug.h:132:2: note: in expansion of macro 'DEFI=
NE_DYNAMIC_DEBUG_METADATA'
>      DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
>      ^
>    include/linux/device.h:1351:2: note: in expansion of macro 'dynamic_de=
v_dbg'
>      dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
>      ^
>>> drivers/usb/mtu3/mtu3_qmu.c:261:2: note: in expansion of macro 'dev_dbg'
>      dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=3D%p, enq=3D%p, qdma=3D%ll=
x\n",
>      ^

fixed it myself. Changed to %pad.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnlz28ACgkQzL64meEa
mQZ3xBAAiJbw1XbSWI2wqVkBVE2hGnZdRbZj6UbQ4Vxe4two6hh9aw3X4mTwX2x4
8iywI4PjUlNaNwVoOIm1GoEsYMPgqbT8rqW9WkhGgQ/Efx0n6TdAFrHnAwz0p+O+
MVc3K3rp5+rmXh/nKGwr9cVeUigfY20GvP2GiL4Xqs5yQX1SD1cCWNJN1PAJ4k9u
6t6tBP2FLXZ+R/a6+HGHJ1RZu2TV6sMBtXvx96NY3ANcDFXg1ZsDYwNMG78m43wA
AvJXR54rSo3f5Ipnr37utKe37EIcUMJDjQwaFwR3J6XMbh8VVtrffsIaI/4o3LHY
8nqQIJH5mNWyGFJ2/jR7Jx3sk4gqrX3VZ7/HqNUeLoBLp/ssjMh7YG7IHAqfq7u8
NEknWn0H5J8JwzL8h5a8j1VLiLcZOdnUzBRiE5+JxsmpOUXGZyPTA+sCpWPg3/+n
psn5/1WXC4bfTDTdzSihApeyxlwGD5l99x6QSVbRzKvwR2byQJHr36FUS1Rw6oMs
PhbozXiHlyvm6EeoaDPKjTqoyGkPE6BWbYRnc/ZWaFg8b3+IK8HpD6CGY4kQYiIi
t+aKiLdXC+RBPtU2/R2xtzNq35I9JZd4IHW1FNgMvdZ3GqpCt4gplaiKbFv0Ltww
oWHmqnQycqtVWVoFSPWNDNYVLQqrMEgdnhE0QiaR5eS22bQPzKQ=
=E8o7
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
