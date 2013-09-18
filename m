From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/11] omapdss: HDMI: create a HDMI PLL library
Date: Wed, 18 Sep 2013 10:00:08 +0300
Message-ID: <52394F78.5010603@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com> <1379401597-27222-3-git-send-email-archit@ti.com> <20130917093813.27384.67975@quantum> <523828A7.8050204@ti.com> <CAPtuhTh-6JJnpqp=0FCQqkPS2yBUmj7-zniY4vRQR9xq+t8htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jcbHqcPmgPNHXsqgSLuiafsd29wn9nloi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45932 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3IRHAM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 03:00:12 -0400
In-Reply-To: <CAPtuhTh-6JJnpqp=0FCQqkPS2yBUmj7-zniY4vRQR9xq+t8htg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Archit Taneja <archit@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

--jcbHqcPmgPNHXsqgSLuiafsd29wn9nloi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/09/13 22:40, Mike Turquette wrote:

> I hope that the existing CLK_SET_RATE_PARENT flag could help you get
> the frequency you need; it causes a call to clk_set_rate(leaf_clk,
> target_rate) to walk up the chain of parents and configure rates as
> needed.

Hmm, I'm not quite sure what that does, but it doesn't sound like it
would help. The only way I know to find good clocks is to iterate over
the dividers for each clock on the path.

And to complicate things, clocks from the "middle" of the path are used
for some purposes, so it's not only the final clock that we're
interested in.

For example, DSI: DSI PLL produces a high freq clock that goes to DSI
PHY. That one is used for the DSI bus clock. The high freq clock from
DSI PLL also goes to two dividers, of which one goes to DSI IP, and the
second goes to DISPC. DISPC clock is then divided with two dividers in
row, and the resulting clock goes also to DSI IP.

All those different clocks have restrictions and dependencies to each
other, like this one needs to be higher than that one, or ClkA =3D N *
ClkB, etc.

> However I have been looking at standardizing a way to define clock
> rate tables, possibly in DT. In many cases it is a board-specific
> issue (e.g. different oscillators or other reference clocks that feed
> into the SoC) and specifying rate tables in DT is one way to store
> known-good configurations for complex clock subtrees.

Well, for some boards, which only have an LCD, we could probably get the
clock from a table. But if the display used (say, external monitor)
supports multiple resolutions, such a table is not feasible. We could
have some clocks there in the table, but we'd still need a dynamic way
to figure out the dividers for other clock rates.

 Tomi



--jcbHqcPmgPNHXsqgSLuiafsd29wn9nloi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOU94AAoJEPo9qoy8lh71bsoP/A7yJSVHHoXtCT+0Scn7BYOD
zJ60R3bpOjtMRQOn+3bHAxvM8e53OwtoQx0tx+5t44/iLLWSaFONsptRbOlxmFlg
GAwqMdNE0uUERugXbF21KDCHXWlMThlepj/c/tuCwekgnijTyVx3dQ1FKk298rXI
DR0DNmJ+kVHVn0avgjSjULbtZEWsPVyiINMZ4PSeQIwIYls00F3R39R9tx56HZPs
T/ZMPR9uk0CYJDO0jt64+nzlr13OhrAfzwEw2JbXqjLPibRtisj/VinOPPeJnqpx
t+kGTAX7j5Coygve8UQ4fDllKO21Kt9ZXy2oRMCoP0imw8uaoUMR+CCzX7DVbFFf
3ufXMF5INMOZhYtvwqS2nZFM15BWui4Y0u4pEX0B/KAROVOa/pAJdJDx07BAh8Dy
SsI0IqvRUcVleSay87pSaxaBKAtBxktMmnYRzT8YYKYIpMSptjBv2jMoLXCAymZv
0oHrNqugyg3LoT7+SX2vQyPYs4cUdCIFoPcoE0Qhe7adp/ZQdCO9frOPDsXe68Oz
943h4OB7onBDZy0MWd5Lw6o3LBriBJ9K6+Fz9akcE+klee218H5wjNRpiZPNgODe
TkpbVKMYN8cvK3OmXityPTWiAc5e86g0hI8SLiWsoCeDIkrXncJ0eJn6gwEAC8JZ
XnvQRIjv4LjuzolWRZac
=mw5u
-----END PGP SIGNATURE-----

--jcbHqcPmgPNHXsqgSLuiafsd29wn9nloi--
