From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 5/7] i2c: omap: wait for transfer completion before
 sending STP bit
Date: Thu, 25 Oct 2012 17:15:55 +0300
Message-ID: <20121025141555.GE16564@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-6-git-send-email-balbi@ti.com>
 <50893846.3020106@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0373976033515413676=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50893846.3020106@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: michael@amarulasolutions.com, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============0373976033515413676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline

--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Thu, Oct 25, 2012 at 06:31:58PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >Later patches will come adding support for
> >reporting amount of bytes transferred so that
> >client drivers can count how many bytes are
> >left to transfer.
> >
> >This is useful mostly in case of NACKs when
> >client driver wants to know exactly which
> >byte got NACKed so it doesn't have to resend
> >all bytes again.
> >
> >In order to make that work with OMAP's I2C
> >controller, we need to prevent sending STP
> >bit until message is transferred. The reason
> >behind that is because OMAP_I2C_CNT_REG gets
> >reset to original value after STP bit is
> >shifted through I2C_SDA line and that would
> >prevent us from reading the correct number of
> >bytes left to transfer.
> >
> >The full programming model suggested by IP
> >owner was the following:
> >
> >- start I2C transfer (without STP bit)
> >- upon completion or NACK, read I2C_CNT register
> >- write STP bit to I2C_CON register
> >- wait for ARDY bit
> >
> >With this patch we're implementing all steps
> >except step #2 which will come in a later
> >patch adding such support.
> >
> Will this not break the bisect since CNT and
> NACK, completion is added in later patch

not really. It keeps current behavior.

--=20
balbi

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiUmaAAoJEIaOsuA1yqREpAYQAKHH66CBlC2/x9jYzZLNRBVt
UUmXLIYq8M6V9z/kQHZKKdz7aVVB7MmFyfDotKsONl7JMesHecWYeoghRHr02J+R
6NWTsQ2Xy18dTRLsxsBTX7un7RppEr7Ek2GsZ0J2VR+WD7HCHshLcx1Uxs/f98t7
fC/ehpmnr0Q4hBK1x7M4DyOZum+V8B64J05FgHnDpfKd5PobXJEyujzguu41kjD6
syonEc9qnW0yYqZy1gyTui8JoIPHoPamFuAqZOs+l7dXOvM4cAOw2sMfEoILcfQQ
nzuSVu5Om4A6HAAJ6/Y3iqz5hqjwZaeccqDEx3EnQ6FCxhk14HSem8KM6w31wryV
ur06j3e63Tl7dFpkC1cduJYZPN5/OXNgpqVHtgboiFaWUUBJRG5geEL0zHrzkCMV
bv9oQpCps8FH/E0LLOMDQuiHaR14BJRv5HpiLh7+h8U0Pdl4YxlvaWmLRR9ACLY7
ddDUohesLMIbj8SALSxoxmPyOKf1wgkMZuCKO7hWNEYgZuZNKArIs5Tv2iDn7m7V
EHIMb11wuB+tRgypOs6Dj1mEdddPtyijkfJAdq3e/Liq7yumNj/thJ2yk7fhUXIK
XajJnwZpN6UUipdVxOgLe8K6lUskJ0AepvmKr2GBsF7ZhEvEavqzv+9IxQu9rwUh
dMu17xBNQKTpPi+COrW1
=bUbP
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--


--===============0373976033515413676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0373976033515413676==--
