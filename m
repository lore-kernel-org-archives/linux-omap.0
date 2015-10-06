From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: omap2: timer: don't disable our timers
Date: Tue, 6 Oct 2015 10:00:29 -0500
Message-ID: <8737xo3uuq.fsf@saruman.tx.rr.com>
References: <1444092332-9011-1-git-send-email-balbi@ti.com>
 <20151006080028.GI23801@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7305089937281874127=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151006080028.GI23801@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============7305089937281874127==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Tony Lindgren <tony@atomide.com> writes:

> * Felipe Balbi <balbi@ti.com> [151005 17:49]:
>> We actually want these devices to be created because
>> we will be moving timers to drivers/clocksource and
>> this will prevent them from probing.
>
> Great. Is this safe to appy on it's own? We are not getting
> system timers re-inited to the default values?

not that I could notice. I booted on BBB and AM4. If you give me a few
minutes I can boot again and save console logs for reference.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE+IOAAoJEIaOsuA1yqREQ9EP/0UtMq5D7WluF+N0nEPg1ysz
ceaZUymF3aMpRRVzMj8obV03sAsSFK+GXEcCT89ziHtzlpUZD1Uiio/baD5mTNLo
oUztWnHqrQTpyNLUS82cYoCNU6+fZzM+FpBAXahNF5skZfvskmH88kjSH1Ydy/NO
5qXelCcLZedAGQXiW6DFPjeoJ8DupEbEwjYLn0Yy3NpidJjcRzJ0Ye2YcOF9Naq2
yD6AMc4/KlBo6JHqcbXOhtKtfzIEWXS9101ZZlVJse1PAcf6GmkUhEzfgubrQrQ/
pXPSv2nJ7Vpdyc3VPHyk24AOYHueVM8eA4/M6UIk1ub4evh8FLaE3txfnniRTwCe
Nu0Lai+kmFBQuBRI9Hb4iIvor2SscAeJ4YfdpJzOjdEvqmGbXVziIura1skYhPac
P3pl8CTUItyfPCOTK5Pa/RZEAEcIo2fdF3VXT/pAndXS2wB8+f1SmaOaR+W/t0cv
07a96YXpv2ti1hAvWCy5bv7cq/HSrc7zoDlPKz3vqokOQjrnSOoOBl+cveTBqq9a
vckmMct6UC6WPmZ5jiGDNFbiHR4+vTefDUgfsqsoufC/q95mMhkhJMWK9CA42UEN
BiSrPQ/oSGy2jkmKoOvjJ53Sb+7OTIU0r7zvUWSRrJr207qFZqY7LuYvMkS8d4Iw
u3y0C8fUG+lqGGUaAKe5
=+XFB
-----END PGP SIGNATURE-----
--=-=-=--


--===============7305089937281874127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7305089937281874127==--
