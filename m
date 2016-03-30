From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Wed, 30 Mar 2016 16:55:07 +0300
Message-ID: <87egashxz8.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com> <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FBDA0D.4030507@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "Thang Q. Nguyen" <tqnguyen@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> [ text/plain ]
> On 03/30/2016 04:10 PM, Felipe Balbi wrote:
>> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
>>=20
>>> [ text/plain ]
>>> From: "Thang Q. Nguyen" <tqnguyen@apm.com>
>>>
>>> The xhci-hcd child node needs to inherit archdata attribute to use
>>> dma_ops functions and attributes. This patch enables the USB DWC3
>>> driver to pass archdata attributes to its xhci-hcd child node.
>>>
>>> Changes from v2:
>>> 	- None
>>>
>>> Changes from v1:
>>> 	- None
>>=20
>> changes should be between tearline and diffstat.
>>=20
>
> uh. This become a real problem :(, especially with LPAE enabled.
> DMA properties need to be inherited not only here, but also in
> usb_add_gadget_udc_release(). And probably in other places
>  where devices are created manually - the worst case : device is created
> manually but doesn't belong to any bus.
>
> And DMA configuration must include dma_pfn_offset also!
> And how about iommu staff?
>
> FYI. Solution used for PCI
> c49b8fc of/pci: Add of_pci_dma_configure() to update DMA configuration
>
> Rejected: introduce dma_init_dev_from_parent() or smth. like this
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/378317

I like this very much. Meanwhile, we need something (although, $subject
is not very good).

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+9q8AAoJEIaOsuA1yqREdIcP/14WcUtrYdQ1FcMtFdbzjxQS
YkCX6cGjbFyF/lkG49x3FdPrk7GoAcH+hZ5NN3odu3qbHTUHnrlay0XVgXYncFd2
TZ48bRDw5wphjWM4f7fsClQjztH+wjiTNUn5cJlWTj5SLksivOtaLR1iLyD0HnDG
S1vHdGSV2FOMWFgYBy9de/u6Y3DJ/TpxiLPCe8++nnaWzsUoccc1Rj38EXYi3Omb
6nfpJLUINhrszrnqcFPiQ8DX31JHx/L5bbikQWtYWgEQYjSGwhRyY/EuUI8AiuEw
WQBkntGk8nN7qc8mLsCD53MERy+77QTX5Llff3aoZvKzjj2L8IXvGo8oGDqHbH+r
FEPGCluF/0iLbvGPyUiirA+n9E7s1zyxOkHQhVv6OAuoGCoOGEiFMERf1J6LSiNT
4idqQANnn6Ehnk1ALvoY1WGeaZIpYp4HPbZ9x2g1tkg/wQfHxTmd6oC0jJ4QJ1YF
fbPIzFucTbo4MbsszE5ggnliC34VKvPZkG/C/lFWU/0QiYYUtQ7FDmPtOP9E0tCB
8XNk+dB95sWuUG2Us66xPRaRSpR/R+YGPmZnc77eAdWNYRl0xGew9+DbcqKqtpAo
21Po5paGM69XfO+M7mFKiQUFHqtw8tvPf57E6F13F5DAIIAM97aEc2BwHAHYEYHz
0yiAaEk4NgzPedkAo12I
=aEka
-----END PGP SIGNATURE-----
--=-=-=--
