From: Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: support autofocus / autogain in libv4l2
Date: Tue, 25 Apr 2017 12:53:27 -0400
Message-ID: <1493139207.19105.16.camel@ndufresne.ca>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170425080538.GA30380@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1921373196724414719=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170425080538.GA30380@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: ivo.g.dimitrov.75@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, Sakari Ailus <sakari.ailus@linux.intel.com>, pali.rohar@gmail.com, Sakari Ailus <sakari.ailus@iki.fi>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============1921373196724414719==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-uUBuJLUvjKqsAuLefAlK"


--=-uUBuJLUvjKqsAuLefAlK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 25 avril 2017 =C3=A0 10:05 +0200, Pavel Machek a =C3=A9crit=C2=A0:
> Well, fd's are hard, because application can do fork() and now
> interesting stuff happens. Threads are tricky, because now you have
> locking etc.
>=20
> libv4l2 is designed to be LD_PRELOADED. That is not really feasible
> with "complex" library.

That is incorrect. The library propose an API where you simply replace
certain low level calls, like ioctl -> v4l2_ioctl, open -> v4l2_open().
You have to do that explicitly in your existing code. It does not
abstract the API itself unlike libdrm.

Nicolas
--=-uUBuJLUvjKqsAuLefAlK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlj/fwcACgkQcVMCLawGqBwWjwCggHGJKIR3hv6WOAR1NUhArSdK
DtQAn1OB95Bio0qArsO40ujhje/XsvnQ
=bFy2
-----END PGP SIGNATURE-----

--=-uUBuJLUvjKqsAuLefAlK--



--===============1921373196724414719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1921373196724414719==--
