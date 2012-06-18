From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 16:11:11 +0300
Message-ID: <1340025071.4012.27.camel@deskari>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340007094.1859.3.camel@lappyti>
	 <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	 <1340016865.4012.10.camel@deskari>
	 <CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
	 <1340022276.4012.23.camel@deskari>
	 <CAJe_ZhdoEjyf0ejjsJJpznt83bTJTR0UW3aqaYAZdcm01GBp_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ys41bnN1QSPO4mK7hJrw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52625 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992Ab2FRNLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 09:11:14 -0400
Received: by lbol5 with SMTP id l5so4589254lbo.20
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 06:11:11 -0700 (PDT)
In-Reply-To: <CAJe_ZhdoEjyf0ejjsJJpznt83bTJTR0UW3aqaYAZdcm01GBp_A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Ys41bnN1QSPO4mK7hJrw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-18 at 18:37 +0530, Jassi Brar wrote:
> On 18 June 2012 17:54, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2012-06-18 at 17:16 +0530, Jassi Brar wrote:
>=20
> >> So preferably I would move request_threaded_irq() to after
> >> hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable()  and convert the
> >
> > No, you can't move the check. If you move it, the HPD state could chang=
e
> > between the check and the request_irq, and we'd miss it.
> >
> Wouldn't we then get an irq, and hence another hdmi_check_hpd_state(), fo=
r that?

No, if we haven't requested the irq yet. So what could happen:

- initially the cable is unplugged
- ti_hdmi_4xxx_phy_enable() calls hdmi_check_hpd_state(), nothing is
done as cable is unplugged
- cable plugged in
- ti_hdmi_4xxx_phy_enable() calls request_irq. No irq raised, as the
cable's state doesn't change.

We wouldn't know that cable is actually plugged in at that point.

 Tomi


--=-Ys41bnN1QSPO4mK7hJrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP3yjvAAoJEPo9qoy8lh714wgP/jcSgYC1xIc/YfYdCyBN2U43
2ognCDMEtZ+2CVWg2s1FNT5PNFcW693E9m1Uo62/6eqlUPdK0rY5jjFpRLUyoSt0
P6YyUHyI6hPXgFiimYrmch8z5gHQwhCjw41UOSn/2WmkIyOkaKzTHCM7AJBfEzdy
uS32B6KwLLZa/mX1olmFIqqhmQWW44NH7gYqpfyszcZM8rIwHpfc+48xda7Ejpjo
AQ8hMg247aVsyYZTQqVQD0lDqHUDfJwPt110bSvB/oIfPt6ZJZqxUPZhXlSYKEbc
Z6Od1XKBKExCox0BIyyMKHC1rXwud8zkT3RWVTmr4ag5vizEKLxtdbQ/BG7jInv/
TbOJs0WEd1vGu/sKCTp+pPOuij+3fSELM9zDBj3DDgNAggE7ZGM4X+lRvYKu1ZzT
U+3HJdRC6ZczEUParE8Mz1YXKzTu0YwuG4V0h5Ssrb8w82/Bvlxw0Zx/BKDMfxDT
gYDsWJpOptXEDjM8ZTSkKWmR3ebrSYRz2+1DhT2UuDUIP2YemQrtXePf3MY70K45
hKZh49UUYwslxI3c+bhKoLgQ7uZl9L4XSRmmH4nttmDZVqsfYDrtMxgZ4MKagQPr
M8jSeX5YNgQjyQE93re6I1I8mCsPs+CaOdrZRhzcbZr/tLOjLQ27mqcN1NjX1TNc
NDHaUYmcEki49c7o7p/P
=BUYN
-----END PGP SIGNATURE-----

--=-Ys41bnN1QSPO4mK7hJrw--

