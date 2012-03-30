From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 15:06:34 +0300
Message-ID: <1333109194.1932.42.camel@deskari>
References: <1333094862.1932.15.camel@deskari>
	 <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
	 <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>
	 <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>
	  <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com>
	 <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com>
	 <4F75963C.2000508@ti.com>
	 <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com>
	 <1333108748.1932.37.camel@deskari>  <4F75A0F1.4030904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0ce0ad4a20b9b004bc74ac00
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47160 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933847Ab2C3MGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 08:06:39 -0400
Received: by bkcjm19 with SMTP id jm19so519131bkc.11
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 05:06:36 -0700 (PDT)
In-Reply-To: <4F75A0F1.4030904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Archit Taneja <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

--000e0ce0ad4a20b9b004bc74ac00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-30 at 14:02 +0200, Cousson, Benoit wrote:
> On 3/30/2012 1:59 PM, Tomi Valkeinen wrote:
> > On Fri, 2012-03-30 at 16:50 +0530, Shilimkar, Santosh wrote:
> >
> >> Exactly. That's what I mean. You tweak sysconfig or clockdomain,
> >> both are messy.
> >>
> >> if one need to choose between two bad options, I guess sysconifig
> >> one is better because that is local to IPs and there is some way today
> >> for drivers to manage sysconfig directly.
> >
> > If the driver touches sysconfig, isn't it possible that hwmod/something
> > just reverts the changes? I mean, sysconfig register is supposedly
> > "owned" by the arch code, and if the driver modifies it there could be =
a
> > race condition.
>=20
> No because we had to expose API from hwmod core code to do that already=
=20
> because of various HW bugs.
> So you will not access it directly but through the hwmod API.

Ah. What functions would be needed to solve this case?

> The only issue is that these API are exposed today through pdata=20
> function pointers, and thus this is not usable in a DT case :-(

That's ok (for now), we will anyway have this "omapdss" higer level
driver, which is not HW driver (i.e. not mentioned in the DT data), but
created in arch/arm code. I have put all the current function pointers
there already, so I can add a few more.

 Tomi


--000e0ce0ad4a20b9b004bc74ac00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPdaHKAAoJEPo9qoy8lh71cjkP/3+GmDMFnA9jhIU80K17h/Pf
3xekDbpb/ZIgnV9l8CbXN6tPyWY9vS222XNA566v3LwqatjnS3A7VxEmRc0BmuIX
1nVCIbURrMLxMokZI0X93IYG7DdfZuzyUxXPJuE4rUEYFy1Epra18ZqFkq5T//DP
T8a2XFgNRmOdm7klcLB36skM+I3tUyYbtBIcYvnJqXYm7pZBw1kIja3ZbM2M276u
Nu6hGEOpleETRVqIoa6xhp6TvRSknVVXhPKlMTDwsDubogEFI91zTuUxC3ZNlrMk
o29MxOEYbUdsXrbohAy8uxMJYp2k+UbUvPxV2iD5UH6i28y/g7cpfV+BLTiiiv9g
cKhoR57Kn7J+FTnEw7e0Sth1NMeu5HeFgJf8UGFQGN20i1irRvEkgAJSCWdbjJt9
2CM4Bgais5uWJTZQJK8iEw9wXR3Z4HMe709VJO5cpyJCTQMu8T3mPmYUBeGWz/n7
FUGtXW5hTTOM0vE6iuaSOY8H84My51r30zJgnbQx1vuNGqYweXFotht6AAByOUia
eDsS47OFvg3uxJVXlahvuBNk9+cK+3mTuMpkS19Fnl5RWHUpWGFUcYa8YTnizFM/
KpXFv0n5A5AiimolqJWjnBA7Vw2aHKnblSd9A2TeRHLA3oF2FVdF0FygZtb9z1dC
gs55Kn8NrdbMWDnAcZsn
=NuIx
-----END PGP SIGNATURE-----

--000e0ce0ad4a20b9b004bc74ac00--
