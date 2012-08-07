From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: VENC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 11:51:04 +0300
Message-ID: <20120807085103.GM8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <75e516de4cb0787d52e4a9173d123df6903d561a.1343912533.git.cmahapatra@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59259 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703Ab2HGIyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 04:54:39 -0400
Received: by lagk11 with SMTP id k11so978064lag.30
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 01:54:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <75e516de4cb0787d52e4a9173d123df6903d561a.1343912533.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 01:58:17PM +0530, Chandrabhanu Mahapatra wrote:
> OMAP4 checks are removed from VENC to provide it a cleaner interface. The=
se
> checks were introduced by patches "HACK: OMAP: DSS2: VENC: disable VENC o=
n OMAP4
> to prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> =
and
> "OMAPDSS: VENC: fix NULL pointer dereference in DSS2 VENC sysfs debug att=
r on
> OMAP4" (cc1d3e032d)  by Danny Kukawka <danny.kukawka@bisect.de> to preven=
t VENC
> from crashing OMAP4 kernel. An alternative approach is used to do the sam=
e in
> later patches.

in later patches ? This means you're causing a regression here. Just
swap the patches around to avoid it.

--=20
balbi

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQINb3AAoJEIaOsuA1yqRE5egP/iSaGaYkJ92tZ5GuUg62Z9bZ
gPkXdA3pcygCwiPs4QYMLE1hvKUNvDST/lZULx9w0o7sDmHkN44012H7YtLcQbWl
CokJOz09MgZISh2PmVi104qcDWjPJVJp3+KTsdWtKirUsRN8KM4RWZU3KrYyzPAn
Vloiak6OPbYtZbwlwxqVphEn7YBzcAhVvAwDNWJeQT9CINF0AZgMrOgy3JkEQbdw
4gP7UVicoX9vZnEQ7GR1lZc7lJcJRPg+2LYTv3rsW9N68Vb55GYMqa/bZLlTQhOm
JfSZ6ZLW+wK3X7pt9/VBvYEmigJrL+z7VhTXIhxrq2cXy4U7EDaCoZeAx1AQYcxk
XWbneCSxo7x3xM/XO3gq0bs95Q6ujPvpABrnEzSEC9lNYIKGrTu03ot+mlh4Jb2V
1zULHRAD0eTOCNX053KvO8wk/e1NhzG4wUBnTTV6S6KsCFud0mSiKekYn8POE3xE
JcAo9wZEZfff+6IF2Fkn9ZlXiBCKgupnrloBBEQDU/wWU7++ABZwTmTpgzr9QWZO
um/sEdzjszzM89yolrXvhGnMqOoRokAeEC8ZCLnrtRr0quDmy7CrrKusFLXcryRB
H4nBGPOQm1YuEYysHDfjDLaPJXpqyIu/gktx8uFMBsIA8O+U+rguJ8t6NUIpQsFe
gYoCmpXjixWp9EYRpLPS
=WJNl
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
