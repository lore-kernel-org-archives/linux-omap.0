From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: use correct timer function for AM43XX and
 TI81XX
Date: Mon, 16 Nov 2015 15:13:55 -0600
Message-ID: <87egfplka4.fsf@saruman.tx.rr.com>
References: <4016134.4bReocePei@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4313149615516855995=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4016134.4bReocePei@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============4313149615516855995==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> AM43XX and TI81XX use omap3_gptimer_timer_init(), but that is only
> built into the kernel for OMAP3 and AM33XX, otherwise we get:
>
> arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x124): undefined referen=
ce to `omap3_gptimer_timer_init'
>
> This changes the Kconfig logic for building the function to
> match the callers. Consequently, we no longer need to build
> the omap3_secure_sync32k_timer_init and omap4_local_timer_init
> for the platforms that have been moved over to other functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

no, AM43xx uses omap4_local_timer_init(), there's already a fix in
Tony's tree IIRC.

> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || defined(=
CONFIG_SOC_TI81XX)

[...]

> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(C=
ONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)

someone doesn't like to run checkpatch.pl

care to provide a defconfig which would cause a build error ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWSkcTAAoJEIaOsuA1yqREf/QP/0eaQRCWWGjVCGc038ofM6NR
UcdkPAj0bOLyKhEwyHap/R1Asxoz2b6a13fujBpqRQ5EakUt11D6o1aTluU4wEaM
yiiN57Re2h3RRB8+TRQ1pFQ/+/WSR6Ehe38Fa5cT17FfRtPkQNM5QpnkRjRXIO4L
OYBdS9gNRvNU0y07ec9IarH0U0/mNtmJXs21gAnCRd2WtjcOD6oA0TpXSfWTHGln
712RKMKJ2ntJZgI0w98Oq3EXOzm+NlzKE4MJHEVDlfuMKfxnZdNGYG9ZacpK5gNR
U0YowE0GRgcOmvduHZRjhrimJmo/xpsuSQuBD6TJqqmNbHw7Z3jmUkOMdOsRAPYV
oTEu7K2jyW47zSrNfa/FAmgSziER6uTqRURJkTMGkSMAIbgGRH1Rw4X/qzlCrGii
iW+OcAOGC/+DDtTiXVg8qfINk5vIoD6CPN3t9k0vWm11qUaQFIMvs7t21DfIY69r
iyitcC23lE2YEUZXigF7+9F9dwpnVnXISP9eKpSv8WXISPXXHqDmcOdm37NHFkXm
178hiNY6GTj0sKil6zyQgG6iNlZktmGR6EUGTw4NrAf2Ol0KE0bm1LbzmYCzKL9f
nWwBKRA6WazrB/ACeaM4jke1G7C7hhkIJUtyattJiA/G4DJpAv2LrU5b0MONTdTO
1uK60m+U4NRrS/KlbOz8
=6aHe
-----END PGP SIGNATURE-----
--=-=-=--


--===============4313149615516855995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4313149615516855995==--
