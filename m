From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 31/41] drivers/usb/mtu3/mtu3_qmu.c:261:25: warning: format '%p' expects argument of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}'
Date: Tue, 17 Oct 2017 13:32:47 +0300
Message-ID: <87a80qjc8g.fsf@linux.intel.com>
References: <201710171811.AsEcP6nY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201710171811.AsEcP6nY%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
> head:   f2fedb17e8946a24c9cf2bd20ee466fb8659196a
> commit: 46ed5b0c1fac208e727c8cea6c2db44a77fc256a [31/41] usb: mtu3: suppo=
rt 36-bit DMA address
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 46ed5b0c1fac208e727c8cea6c2db44a77fc256a
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dmips=20
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/printk.h:329:0,
>                     from include/linux/kernel.h:13,
>                     from include/asm-generic/bug.h:15,
>                     from arch/mips/include/asm/bug.h:41,
>                     from include/linux/bug.h:4,
>                     from include/linux/scatterlist.h:6,
>                     from include/linux/dmapool.h:14,
>                     from drivers/usb/mtu3/mtu3_qmu.c:30:
>    drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_tx_gpd':
>>> drivers/usb/mtu3/mtu3_qmu.c:261:25: warning: format '%p' expects argume=
nt of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}=
' [-Wformat=3D]
>      dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=3D%p, enq=3D%p, qdma=3D%pa=
d\n",
>                             ^
>    include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dy=
namic_dev_dbg'
>       __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                           ^~~
>    drivers/usb/mtu3/mtu3_qmu.c:261:2: note: in expansion of macro 'dev_db=
g'
>      dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=3D%p, enq=3D%p, qdma=3D%pa=
d\n",
>      ^~~~~~~
>    drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_rx_gpd':
>    drivers/usb/mtu3/mtu3_qmu.c:300:25: warning: format '%p' expects argum=
ent of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int=
}' [-Wformat=3D]
>      dev_dbg(mep->mtu->dev, "RX-EP%d queue gpd=3D%p, enq=3D%p, qdma=3D%pa=
d\n",
>                             ^
>    include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dy=
namic_dev_dbg'
>       __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                           ^~~
>    drivers/usb/mtu3/mtu3_qmu.c:300:2: note: in expansion of macro 'dev_db=
g'
>      dev_dbg(mep->mtu->dev, "RX-EP%d queue gpd=3D%p, enq=3D%p, qdma=3D%pa=
d\n",
>      ^~~~~~~

odd, printk-formats.txt tells me pad is for dma_addr_t:

DMA addresses types ``dma_addr_t``
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

::

	%pad	0x01234567 or 0x0123456789abcdef

For printing a ``dma_addr_t`` type which can vary based on build options,
regardless of the width of the CPU data path. Passed by reference.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnl3E8ACgkQzL64meEa
mQahzRAAt6qRB+vXK+GNQaTa2LdlyiHC5qWXEgwmK3rCOgMv2r8hCsQqEHQpUNu5
CszwplPdt/MUlSbJWO0sMOFNmiMfqSgW3F4V9cGHoKUn+8wA0Xp5tMr5kcYokE1n
KbkrrnrRgMdnW5iMco0Yh5lV9A34so+50aORwpZcNH3m6JTb3uM0UZnKYlxx8kEl
bXHfUnu5RX359zCz675nvdT5CGyk60ak7MLE4WFC0Utzi9fK1TvJb5z9o5gOwAoE
fR7ph2qNZsI2LVMFIqffTYUUFry8RW83f3Baw7F0X//wvf3YoczfAucWGYaqqLUK
vwKWXqEUO2VaGsxA5BaxVyZ/ttS3tEnLxsLVLWk0B6LUwxgVCUST4SlSyHJWZy+L
qgHjRxDo9IZAeV/WNC2Dei9xHGzbJ0vMUWikuhpQEyy5n5kkNfRGrNNgtIbsQEQm
i8LIodf1c7GhJ3dIUO+4i2PDRIY00GioxPyS503vpa4j1PpyB8vF7Rxn4QSUAIdY
JQNik2/ZSVIRxRbq2QcjemdPMjXthV7qcdXMkn7qsAjEOhu7Q3uFzT0lVETkwva+
x0E5YhE7lH790bawEO5QJke1JQF8G9k3E4lME7mt8GaWHrTGij1fnix4m1hE3Wc3
ss1H2NaGxf77TNRLxovmXA05rdvhlEcv9YcZ+K6I0j+rYXvLcsM=
=9yU3
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
