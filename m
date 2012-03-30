From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 14:59:08 +0300
Message-ID: <1333108748.1932.37.camel@deskari>
References: <1333094862.1932.15.camel@deskari>
	 <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
	 <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>
	 <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>
	 <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com>
	 <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com>
	 <4F75963C.2000508@ti.com>
	 <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175deff695cbdf04bc7491ce
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48575 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934267Ab2C3L7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 07:59:15 -0400
Received: by bkwj5 with SMTP id j5so778908bkw.16
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 04:59:11 -0700 (PDT)
In-Reply-To: <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

--0015175deff695cbdf04bc7491ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-30 at 16:50 +0530, Shilimkar, Santosh wrote:

> Exactly. That's what I mean. You tweak sysconfig or clockdomain,
> both are messy.
>=20
> if one need to choose between two bad options, I guess sysconifig
> one is better because that is local to IPs and there is some way today
> for drivers to manage sysconfig directly.

If the driver touches sysconfig, isn't it possible that hwmod/something
just reverts the changes? I mean, sysconfig register is supposedly
"owned" by the arch code, and if the driver modifies it there could be a
race condition.

 Tomi


--0015175deff695cbdf04bc7491ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPdaAMAAoJEPo9qoy8lh71XVAP/Rz0Ull7RxfwnPym2n9EusKU
9YB7WlZVGjugA6c1zVmkWrgsG9P/qqEeeuyXz91luvgYIXWDtfDkEe2S3/N/io8j
JPqe5MaeFVswrZZqXmTz4cu5vAe3FxFESqU9MlgcrY3QM8TK06EQcFa6/H78Kh9G
jv6yRhRNK6w98PzqIu7XdifKg8BR865LIteicXd5tLZIxmrRvuxqviw94BoKryk4
IIXB5Og1Q/lN99JHcyDJeB20P2aE+0aTyYEHFr1LB/pPfUW8u8JuAwOlvQ/SUGdL
aKBs0BPZlJtB2R2KoBBMQmh69o+ouj0F0P2G/GXR/AP0CQ19Ja3HJ/Qx38ncE8eQ
Z5PNf6+Cl7C1FGAtdavuVHwyujiN5XEUzZXaDOkVQ9u9VZ0Et+j2MwB5lhVQsQWB
taf1i2BlQEGdUMLNpk4xUtOLAYCSlw3eM+fYDE0bNF9L1VPwqEsEpfRRKBESMn6F
wfvY9QkZr1p1tQqTHOl1NL8Z/QpwimPGNDy0sdGtSz+M/SQ6uobfbG+ZTStv0XhI
TrNhPR5tWAeWPyxs+hy2vSB+YUW8bCeL8ZvlxBHrTPRsnAF1+zZPUsciOmTl3dmO
QHV3qiRkElmCX0HRAXbseCVjWpLstshZ2Cr0Mtx7ByDAVJP3NO6QL7xKDtB0XkU1
y2Kuvk+mVZ+GP0QiWIU0
=SOpo
-----END PGP SIGNATURE-----

--0015175deff695cbdf04bc7491ce--
