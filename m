From: Neil Brown <neilb@suse.de>
Subject: Re: [RFC PATCH 0/3] pwm: omap: Add PWM support using dual-mode timers
Date: Mon, 19 Oct 2015 12:46:55 +1100
Message-ID: <87oafvlje8.fsf@notabene.neil.brown.name>
References: <5620ED2C.1090107@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <5620ED2C.1090107@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch is based on an earlier patch by NeilBrown which is based on
> a older patch from Grant Erickson which provided PWM devices using
> the 'legacy' interface.
>
> The pwm driver was renamed to not be confused with the OMAP4 PWM dedicated
> hardware and was cleaned with the review from Thierry Reding.
>
> The first patch introduces a way to select to dmtimer clock source via a
> clocks binding and a dedicated function wit the legacy fallback.
>
> In order to prepare for the future form of the dmtimer (clksource or whatever)
> the first patch introduces the PWM driver with all the dmtimer calls into a
> platform data structure.
>
> The structure is then filled in plat-omap and added as auxdata for the
> ti,pwm-dmtimer-omap compatible nodes.
>
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
>
> Neil Armstrong (3):
>   arm: plat-omap: dmtimer: Add clock source from DT
>   pwm: Add PWM driver for OMAP using dual-mode timers
>   arm: plat-omap: Add PWM dmtimer platforma data quirks
>
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
>  arch/arm/mach-omap2/pdata-quirks.c                 |  23 ++
>  arch/arm/plat-omap/dmtimer.c                       |  32 +-
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++++++++
>  include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
>  7 files changed, 472 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
>  create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
>  create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h
>

Thanks for much for doing this!
I haven't looked and wont have a chance for a least a couple of weeks,
but I'm very encouraged that someone is pursuing it.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJEuPAAoJEDnsnt1WYoG5ETkP/Rmvy1qaFpERnfnufImzZVOI
dggm8FMgq176pdOim69YLhut2JIyg+tsqp41xWECvKpPPsdLl2Dtsp4uQnrDzUCp
mRfomzoXcDORT9D1nGX8+Y9A4JeMxnGPaF90PjJO4h0z81EeNu5PCQl1BI6mn/Ow
bC+Y0ifXZIUVvH+aze3SxRe1h6HxZabExOdT9OnLA5iNEtePyaq94SYI5vVS3HBA
n+k+B4gBOpbIpzbtkmUDurJizxO2ufXEO9CZ158DNoiz7qQOwmZoCXWMe0qOiDrC
4MpjFPQFwokb9j439OpSbWnYaYGcErXnX9/ftiK7KNZWfpESk/FKnbqnY9kFB4bn
EgAWoKlUaw9Bwg6C41ygmro+B2VRegoC+kx1oTbHu+F1MU6ifwde8voEWFk57oOa
5nyqKWfV52jgxKgv3qH7E19+LLpX+zTJcotyeXZp7bXJKcQKrdAxH62VRITTfEO7
lyL08iTmcjE/crrETF2a4dG4lN8OhSRiVaGfhYvt7e+Ub27WMczXwTBfBuVwbmxq
MpJKICx4l4nrlziyj4Dwhtg5p3J+z4ixjBpkhOWRwemg6XGKK8mcQhXAPfvOpnqG
XDArAzfCccOfUWkIdluX/D/4qlN7kLTX7kdmeNlIVxX2FaXxV88vDjpglg5t9HXJ
x9M6cEelGwnrYvR1VtfC
=UxEJ
-----END PGP SIGNATURE-----
--=-=-=--
