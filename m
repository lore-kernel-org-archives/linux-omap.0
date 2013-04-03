From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 3 Apr 2013 15:04:55 +0300
Message-ID: <20130403120454.GX25837@arwen.pp.htv.fi>
References: <509420D8.1030307@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com>
 <51312430.6060306@gmail.com>
 <87sj4cunp6.fsf@dell.be.48ers.dk>
 <5133E268.5010604@gmail.com>
 <51388D64.9000005@gmail.com>
 <513A1580.90303@gmail.com>
 <514863BD.5010503@gmail.com>
 <87620nwmd2.fsf@dell.be.48ers.dk>
 <515C19D7.6080702@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="35rzUHtxHARXKmYf"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <515C19D7.6080702-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--35rzUHtxHARXKmYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(sorry, being really busy lately)

On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
> >  >> I know this patch reintroduces bits that have been intentionally
> >  >> removed before, in particular by 032ec49f53 ("usb: musb: drop
> >  >> useless board_mode usage"), but I don't know how this usb driver is
> >  >> supposed to work in host mode without taking the configured port
> >  >> mode into account. If anyone can explain to me which information I'm
> >  >> missing here, I can happily test a patch. For now, this works for
> >  >> me.
> >=20
> >  Daniel> Hmm, nobody, really? Am I the only one who's running the musb
> >  Daniel> driver in host-only mode?
> >=20
> > Sorry, I'll be needing host mode as well, but am currently stuck working
> > on non-am335x stuff - So I'm definately interested in getting it to
> > work, but don't have free cycles to look into it right now.
> >=20
>=20
> Another two weeks passed with no answer at all, which makes me wonder
> whether the changes were made considering the setup at all that at least
> Peter, Koen and me are using.
>=20
> Felipe, could you explain the background on how the dsps driver is
> supposed to work in host mode at boot time with the rework of the driver
> you did for 3.7? It might just be me not understanding the rationale
> behind all these changes, but appearantly, I'm not the only one who's
> affected by that.

right, so the idea with that was to drop the huge amount of ifdeferry
hack from the MUSB driver. It would be great if someone would send
*CLEAN* patches adding Kconfig-based role choices again.

DWC3 and Chipidea are doing it very nicely.

patches are highly welcome.

--=20
balbi

--35rzUHtxHARXKmYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXBrmAAoJEIaOsuA1yqRENhgQAJ4f0XCYSGXiTUufpRawUXg4
m+DoxT0XOx8OStXgeeqhw3hPYWBHm4YKo/qYXliPtEuLyNCJVN4NXspVix6/wqY0
8XaPW0ze44QKQH2qcWplRANtV1onLJ9PlSTpEKIVHSs7qS6eOuk53WV/J6q+EHru
gdGP/Ezxa5dkFY9u9Ga5S7FldOTSZv5q/+JyFNhuD58z3tUtHn8xNevgMcjE9SSd
/XVfUZGwqgqfgNXq3ok2RRHD3uhmwlb48VsEc8FfhtleyMxMlS2UqnSxDCx91Yx0
oapKQDH5Ya4zwlSbN2GwCEevin0uXdpmzJrfC6oHuIZYOJUXT3LDiQjVoxIpg2c9
pEP2WrL/+kf+qTKqTy8v0PpCLTm3wrn8OtCihE691q3DbT8GGfYS/HpA1chHkdy+
2c39wSbn6y5pTl0ks86v/9qo1qOHAhe9L4QI/lXBeEBDm7iADQ4AKQBo/Gxd4qtA
3znWZhKM5RdEp3hN0OZZyvQ+O41D1XCzbR1exB/ruTPrNFcpCVdMFCCWbX0Pi8RX
3FczS/DaBL1FrYfZgiynxFMa6UlscHndTsBjWaTBI47LVen7JNfXecuzVTExbpp3
ta0qLo81aat+wtFY/0edKcs4uD42GSs2id07ttqIl7y4WXLVznNqrwyZmUEot+cB
JM2arm3E7ce/KrWdEGfk
=5k/9
-----END PGP SIGNATURE-----

--35rzUHtxHARXKmYf--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
