From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 22:20:45 +1100
Message-ID: <20120113222045.37f9b4ec@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Qqc_X05s/V5_pgKESSFQ9ql"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48640 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757925Ab2AMLVA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:21:00 -0500
In-Reply-To: <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/Qqc_X05s/V5_pgKESSFQ9ql
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2012 03:05:03 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> cc Tero, Govindraj
>=20
> On Thu, 12 Jan 2012, NeilBrown wrote:
>=20
> > On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.com>=
 wrote:
> >=20
> > I spent some time exploring why cpuidle never drops below state 0 and f=
ound
> > out that the code explicitly disables other states when uart is active =
- for
> > a fairly broad definition of 'active'.
> >=20
> > I found the "sleep_timeout" setting and set them all to 1 second.  This=
 meant
> > that cpuidle started working, but I got a lot of garbage characters.
> >=20
>=20
> ...
>=20
> > Does this really mean CPU_IDLE cannot be used when you might expect cha=
rs
> > from a serial port - e.g. GPS or Bluetooth?
>=20
> Hmmm.  Looking at mach-omap2/pm34xx.c and mach-omap2/cpuidle34xx.c, it=20
> indeed prevents even the MPU from entering a low-power state when the UAR=
T=20
> is active, as you write.  That doesn't seem correct.
>=20
> Please try the following patch.  It works fine for me on v3.2 with=20
> omap2plus_defconfig on a 35xx BeagleBoard.  No dropped or garbled=20
> characters with console use.  Not too surprising, since the UART has a=20
> receive FIFO to withstand interrupt servicing delays.

Much nicer!!

I now see CPUIDLE using state1 and state2 as well as the normal state0.

I also see idle current drain drop from about 160mA to 95mA

And there are no garbled characters when I type.

Having CPUIDLE makes the DSS2 problem worse: lots of=20

[   21.085113] omapdss DISPC error: SYNC_LOST on channel lcd, restarting th=
e output with video overlays disabled

messages whenever the CPU isn't busy.

The only way to get rid of them that I have found is to blank the display:
# echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank

Also, the HDQ access to the battery 'fuel gauge' is working fine, so
presumably that gets disturbed by one of the lower power states (3,4,5).
I guess it is 4,5,6 when CORE goes to RET or OFF.  So we need some way for
HDQ to say "I'm busy" just like UART can.  omap_hdq_can_sleep() ???
There must be a cleaner way...

More experiments:
 - I enabled off_mode and started seeing state3 happening.  UART and HDQ
   still fine - as expected.
 - I set the  /sys/devices/system/cpu/cpu0/cpuidle/state?/usage values
   all to '10'.
   Now things start to break;
   Console is mostly OK, but the first char after 10 seconds of idle is bad.
   I type 'enter' and get 'C'.  In general the first char typed is mapped to
   something else in a consistent way:
      0a -> c3
      20 -> 90
      55 -> d5
      2a -> 95
   It is a bit like we are missing a start bit, and a stop bit is shifting
   down into the msb .. sometimes.

   HDQ also breaks.
   That surprised me a bit as the HDQ access is immediately after typing so
   it should be in the 10-second timeout when the UART keeps CORE powered o=
n.
   Maybe we need runtime_pm to run omap_hdq_break() again to reinitialise
   the HDQ port if CORE might have been turned off.

   Also saw states all the way down to 6.  Cannot tell if this helps current
   drain as I need HDQ working for that.

So this is real progress, but there is still room for improvement.  I might
try writing an omap_hdq_can_sleep() and use it like omap_uart_can_sleep().
And get runtime_pm working on HDQ so it turns off after a short delay, and
re-initialises if we have to turn it back on again.

Thanks for the patch, it's been:
   Tested-by: NeilBrown <neilb@suse.de>


Thanks,
NeilBrown


>=20
>=20
> - Paul
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 13 Jan 2012 02:10:30 -0700
> Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states even
>  when the UART is active
>=20
> For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdle
> driver prevent the MPU powerdomain from entering low-power modes when
> any UART isn't asleep.  Possibly it is intended to minimize the ARM
> wakeup latency when UART activity arrives, but the UART has a FIFO
> that should handle this for most cases, with no dropped characters.  I
> may be forgetting something important, though.  And CORE/PER low-power
> states are a different matter entirely.
>=20
> Thanks to NeilBrown <neilb@suse.de> for reporting the problem.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joe Woodward <jw@terrafix.co.uk>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    8 +++-----
>  arch/arm/mach-omap2/pm.h          |    1 -
>  arch/arm/mach-omap2/pm34xx.c      |   10 ----------
>  3 files changed, 3 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpui=
dle34xx.c
> index 942bb4f..4ef32d4 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -183,6 +183,9 @@ static int next_valid_state(struct cpuidle_device *de=
v,
>  			core_deepest_state =3D PWRDM_POWER_OFF;
>  	}
> =20
> +	if (!omap_uart_can_sleep())
> +		core_deepest_state =3D PWRDM_POWER_ON;
> +
>  	/* Check if current state is valid */
>  	if ((cx->valid) &&
>  	    (cx->mpu_state >=3D mpu_deepest_state) &&
> @@ -244,11 +247,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device=
 *dev,
>  	struct omap3_idle_statedata *cx;
>  	int ret;
> =20
> -	if (!omap3_can_sleep()) {
> -		new_state_idx =3D drv->safe_state_index;
> -		goto select_state;
> -	}
> -
>  	/*
>  	 * Prevent idle completely if CAM is active.
>  	 * CAM does not have wakeup capability in OMAP3.
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 4e166ad..eac6fce 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -18,7 +18,6 @@
>  extern void *omap3_secure_ram_storage;
>  extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
> -extern int omap3_can_sleep(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> =20
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index efa6649..1c49824 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -484,21 +484,11 @@ console_still_active:
>  	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
> =20
> -int omap3_can_sleep(void)
> -{
> -	if (!omap_uart_can_sleep())
> -		return 0;
> -	return 1;
> -}
> -
>  static void omap3_pm_idle(void)
>  {
>  	local_irq_disable();
>  	local_fiq_disable();
> =20
> -	if (!omap3_can_sleep())
> -		goto out;
> -
>  	if (omap_irq_pending() || need_resched())
>  		goto out;
> =20


--Sig_/Qqc_X05s/V5_pgKESSFQ9ql
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxATjjnsnt1WYoG5AQKAoQ//fWhynGuGNapE7ZFYxTNQ0sYlD0QP0DaE
QyF+sAqWMeXSd/G3d9NMT812OQoRKZAmM26qsCHYXHGK2AKNnVQF/6UpQWmPrP+K
QiaHC5D4UD9tOEZN+mXkDhEpXhoK6ih/TqiXg9bPArV8uXnRelJgrCuABp5fDt0q
zvkqGXgRcqD73hT7le1OxtHydbs8kRA9nzspIJtQ4sFf8Egshoc0brCGh2L9/lR9
WbuW0davrqRvSYo+KVJXKvPq5C57vYmYcuwl/3P7zwVjxyUKDKCfl127WRfupFl5
9EWeuL5ZwvC4YlDhq2QnC+wkn05uFRg2pEVsy/ageXps6KxYpUwM0p9Qb7V2QMgz
h4GSwpaELevoylwFVYDWrEDEDWjYEMCdns52t94BepRxnOAnlw9sjxxHnCKGaa8B
IW29ooqqleGEPKIEyTFC8jokOMhy8pgsESKDaam4XMaJZH9pwXXa5/q/bukd45Kj
tvtCLMPvHi0txJhdxngfNSsZIIs75WevDi6Y9ySJ//zpkJa8IOjD/NiQmvg62D7J
Vae/Eb8PYz0bTwFdZj/ea5j6njRt91+WRlnyqq2cYnMEjWsm6vef75E2BTXkv5SS
QoylSDvUQGXs/nbLIAOeTfgSVn4YuQh2BEgssjwwNh6aWzPEwAVuUlWydy8r2wQz
sHCYUKI+hZY=
=jyJv
-----END PGP SIGNATURE-----

--Sig_/Qqc_X05s/V5_pgKESSFQ9ql--
