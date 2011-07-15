From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 10:58:26 +0300
Message-ID: <20110715075825.GB2611@legolas.emea.dhcp.ti.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
 <20110715075024.GO5783@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38834 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964935Ab1GOH6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 03:58:31 -0400
Received: by gxk19 with SMTP id 19so464513gxk.3
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 00:58:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110715075024.GO5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sshtylyov@mvista.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 15, 2011 at 12:50:24AM -0700, Tony Lindgren wrote:
> * Jan Weitzel <J.Weitzel@phytec.de> [110714 01:34]:
> > Am Donnerstag, den 14.07.2011, 00:34 -0700 schrieb Tony Lindgren:
> > > * Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> > > > Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> > > >=20
> > > > >=20
> > > > >     Have you added that 'i' at the end intentionally?
> > > > >=20
> > > > Thank you. It was a tribute to vim.
> > >=20
> > > :i)
> > >=20
> > > I'll fold the fixed patch into your original patch. Will also
> > > keep the new board files in testing-board because of the code
> > > coalescing and device tree conversion effort.
> >=20
> > So there is no way to get the board mainline yet?
>=20
> Well we can add it even before device tree support if it makes
> sense from code coalescing point of view. In this case it would
> mean creating board-panda-common.c or similar so the code can
> be shared amongst the panda variants.
>=20
> It seems that some GPIO pins are different and there are some
> difference in devices connected, but big parts of the code can be
> shared.

isn't it easier than to just add a few if (machine_is_xxxx()) checks and
another MACHINE_START() to board-omap4panda.c rather than creating a new
file, shuffling code around and then adding a new board file ??

--=20
balbi

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/MhAAoJEAv8Txj19kN1m+YH/RMaC6mcv32zJItNPEYcOiQb
c/JyURh5dEZXrIMEXItoQf8wvVuU0jBIaNlxxTQgzVcBr0GFwcGbsCSYnwbulPTk
hPLLy5rn8O8zzUWYCqBZhQUoDqHZLhLGgKP9fTfKWuK4UT3/Y2dVI/HgYv989KJF
frAFVxdmEiMKUwBzLaFRXmqM1UVsxGq/pZ4SgZA+WvqEVfWwHIMAQV+aE4CyiuSB
4GZlzNapfzlLzRUg1kjX4sh/lV8HsWFPPea8UobreuQiU3LxqmQasnWSZBPVev0i
XDA/bFgFt/PCIR5teH3QkGfCHdvcXqhQ/ebW9HZ6DHMwNxyxIbrkC173ZvrjbxQ=
=2HpZ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
