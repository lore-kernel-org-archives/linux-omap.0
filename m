From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed
 variants of readl/writel
Date: Thu, 17 Apr 2014 16:52:28 -0500
Message-ID: <20140417215228.GD8504@saruman.home>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-6-git-send-email-nm@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397767775-10965-6-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
> Currently we use __raw_readl and writel in this driver, however, there

__raw_* and *_relaxed variants are the same, just have a look <asm/io.h>

297 #define readb_relaxed(c) ({ u8  __r =3D __raw_readb(c); __r; })
298 #define readw_relaxed(c) ({ u16 __r =3D le16_to_cpu((__force __le16) \
299                                         __raw_readw(c)); __r; })
300 #define readl_relaxed(c) ({ u32 __r =3D le32_to_cpu((__force __le32) \
301                                         __raw_readl(c)); __r; })
302=20
303 #define writeb_relaxed(v,c)     __raw_writeb(v,c)
304 #define writew_relaxed(v,c)     __raw_writew((__force u16) cpu_to_le16(=
v),c)
305 #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(=
v),c)

--=20
balbi

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTUE0cAAoJEIaOsuA1yqREPNQQAJ6YO6d3r7ym37ziV38L87kT
QcI8dPbJYm/a20WFKZOk/K3a9YPfOVdDvoFY9bKVaU6Gsj18mMr2qcpi4N0cxcuz
tL6F87DeRaoRjal2OtKexaAwRF3NBfhLLxP/Vtai80GMJxzCGVdSqWnHMr7SzTF7
UVWW5EWDj90NBC5m2KsdVTzaKUmX8scOC3EkRrESkzB8u15vNzhLW7zNiFkOtU6t
3HUJ5/WCuCW3LstoVuVE4b9tsjsVeF2JDada0tzzeH+BrtnEAJo8rlKu0N0s/Fdz
g5RnB/9GR5xff8B4qVeyfRswakLJmUTX/fM+ljS3D7Ft0Pcl5Zny1SkBsVFbdZ/Q
5gr2G19BjeQfD7r5xgtxVuQm5Ibeu3k6W8TCg0KTbYsWaYMPAMRsgLWJuOvJ0K4m
qMV/RB6C3Hg+/c7AnyxQUrw0fWFE7q6WsRHOhiXPBDN8NmrqXvns3vAVVpx0RxdH
0H/IJJ2/HWkwEwtgaI5izLlidcWUdWEsj6CInKyBGS/YL4R+oIkAWgKrwVkjjnEi
iKFs6Y5KNm7O8xCbHtdhyVkkNTgJNMRtAg+f4PjzF1b1xt+ZkxpTSBJPM7RXuxxx
oSbu/SqwX9DyMNY4Nbm25UmfZbEm/9ELQnLIkv6A/FBlV4vklsoWKLivRCsaIEQF
TR5GThiF8i2uQToSt9YD
=DLhY
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
