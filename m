From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: use correct timer function for AM43XX and
 TI81XX
Date: Thu, 19 Nov 2015 10:15:58 -0600
Message-ID: <87io4yezi9.fsf@saruman.tx.rr.com>
References: <4016134.4bReocePei@wuerfel> <87egfplka4.fsf@saruman.tx.rr.com>
 <6973517.kQfhdpsmVt@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3494145404370160276=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6973517.kQfhdpsmVt@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3494145404370160276==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Monday 16 November 2015 15:13:55 Felipe Balbi wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > AM43XX and TI81XX use omap3_gptimer_timer_init(), but that is only
>> > built into the kernel for OMAP3 and AM33XX, otherwise we get:
>> >
>> > arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x124): undefined refe=
rence to `omap3_gptimer_timer_init'
>> >
>> > This changes the Kconfig logic for building the function to
>> > match the callers. Consequently, we no longer need to build
>> > the omap3_secure_sync32k_timer_init and omap4_local_timer_init
>> > for the platforms that have been moved over to other functions.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>=20
>> no, AM43xx uses omap4_local_timer_init(), there's already a fix in
>> Tony's tree IIRC.
> ...
>=20=20
>> care to provide a defconfig which would cause a build error ?
>
> My mistake, the code has changed several times and I adapted it to
> the latest version each time, but the version I sent out is indeed
> useless.
>
> The only hunk that still makes sense is
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b18ebbefae09..b7ab09cc5ca2 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -494,7 +494,7 @@ void __init omap_init_time(void)
>  		clocksource_probe();
>  }
>=20=20
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
> +#if defined(CONFIG_ARCH_OMAP3)
>  void __init omap3_secure_sync32k_timer_init(void)
>  {
>  	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
>
>
> but that is harmless as it does not cause a build error, just a few extra
> bytes for an unused function in a AM43XX-only configuration.

I think that's still useful. Tony ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTfW/AAoJEIaOsuA1yqREvBUP/2tf3y6Dyn6fSs74j4Wdu/if
XuFBiIHT2OyFtZAcpP+1wOUJVdFKMcaSDF6TLXmrRh1ELNid67Ghml0upyyuGSmu
MtHzNSfl9sGMneycVO7mjaedLXwoVoDGYgsrmgxYQvl9ZIOzS+/tjW8wlEEDmHJJ
kRIt7HdEKxk0t5dYhGQRgDQ4Yr6Y+WT9jTlaWxyLa1CAsajpGGm8rsYKnojFIEJa
f5l1h7zLE12OKetzY6STDAHPxhp27NTr8DKPHc1oCReph0ebqCe3F1UrsdyFvtzQ
p/t2PcaCFE+TXxvdbieMHiNl+rSolrgYEgzrbW02bp5ceMbgT3qQ6VddwhBG7uEX
i0a/uBhF8ZpMvYX0AwiQHMyZwMK6VJilZPAez3PeDIMnErb44L/0Ey7sieWUhZkK
rYUFEtigaDeegaLJW9ebRAORcdNhsanC/bx+i/LpmN/kTcyb8mge5EWkqPoVRNKV
Y7fLq/bu4iWGA4XYBu8GRmzft0bMY69cCEk9iVK5TXOG78yYvQTWqg1JkdosGzJN
HkpkKN3McKgshH/zTyYcN5q5Mj2LVvJ6w55S1DrbFctEJiWL9L6hJP6NiZmpC2Sg
2QnU9EqvsXA4cIX1G+tHfffred18R8vhuBPQ7QQe13XwwmKgM4cicvBBpGrCIRgK
ssZb5G0Ldflc3WX9EuFm
=FS70
-----END PGP SIGNATURE-----
--=-=-=--


--===============3494145404370160276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3494145404370160276==--
