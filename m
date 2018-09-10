From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with apps hanging with vm_fault_t
Date: Tue, 11 Sep 2018 08:05:03 +1000
Message-ID: <20180911080503.62cb4699@canb.auug.org.au>
References: <20180910182143.GW5662@atomide.com>
        <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j5Iubq945/9ZLGrDVNVsQoS"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca, "Darrick J. Wong" <darrick.wong@oracle.com>, Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/j5Iubq945/9ZLGrDVNVsQoS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Sep 2018 00:17:45 +0530 Souptick Joarder <jrdr.linux@gmail.com> =
wrote:
>
> On Mon, Sep 10, 2018 at 11:51 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > I'm seeing a regression with Linux next with commit 7b6ec2ae877a
> > ("fs: convert return type int to vm_fault_t") where apps can just
> > hang.
> >
> > The reproducable test case I have is to remove a distro package
> > and then add it back where adding the package back just hangs and
> > the package file seems corrupted.
> >
> > This is with ext4 rootfs on MMC, NFSroot does not have this
> > issue. Any ideas? =20
>=20
> This is a bad commit and there is a plan to remove it from all the tree.
> Not sure why it is still showing in linux-next tree.

OK, I have removed that commit (and the following fix patch) from
linux-next today (in case Andrew doesn't get around to it).

--=20
Cheers,
Stephen Rothwell

--Sig_/j5Iubq945/9ZLGrDVNVsQoS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluW6o8ACgkQAVBC80lX
0GxEtQgAgBLbg5+wsTC2pFbW0hOcgejD6qzAgavjbt8PFo7NQK6AWMjoZ3rbiYmK
cNss9cL/umRagvqVUnPJSrr7u7TAdzuRiYJ3ib5rtxRgbRDDSvnX+01JQRSu+GWA
xkEPe779xSmz8n3VYgOgDeg4/dWfprpoyGsDW4yaS+p8qL9D+Q38NCvSmMFr0enO
/wHlRYqfZp3N6ukGl58Ym9nM1RKMlBAGrSAwMw0XsyxU93xprUzAu5a6dt94ZzyS
yaHSy5KHRO/vyu3bZjehZAwB9LoxWwAnvfPoXm/5s5CLg4XCpMpLBAiSYFa+8Xi4
vKak8NAJ7FRHM0pmbKUcfCCi44dibA==
=iTSf
-----END PGP SIGNATURE-----

--Sig_/j5Iubq945/9ZLGrDVNVsQoS--
