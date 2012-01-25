From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: Clock: Force a DPLL clkdm/pwrdm ON before a
 relock
Date: Wed, 25 Jan 2012 12:05:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251205220.5324@utopia.booyaka.com>
References: <1327000976-30912-1-git-send-email-ameya.palande@ti.com> <CAHFNHeWH24iSwumFKwjB+8Tx=+t-XbWjO5YqzH2R9ta0FZWvAQ@mail.gmail.com> <CAHFNHeVXNNnZc=kLV2zrur6D3uVd5SKwog57ZEUMbWZbQo9mBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-666841224-1327518345=:5324"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40553 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2AYTFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:05:46 -0500
In-Reply-To: <CAHFNHeVXNNnZc=kLV2zrur6D3uVd5SKwog57ZEUMbWZbQo9mBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande, Ameya" <ameya.palande@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-666841224-1327518345=:5324
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Tue, 24 Jan 2012, Palande, Ameya wrote:

> Any update on this?

Looks good to me, but have the scripts been updated?

Also could you please cc linux-arm-kernel@lists.infradead.org?

- Paul

>=20
> On Fri, Jan 20, 2012 at 11:53 AM, Palande, Ameya <ameya.palande@ti.com> w=
rote:
> > Any update on this?
> >
> > On Thu, Jan 19, 2012 at 11:22 AM, Ameya Palande <ameya.palande@ti.com> =
wrote:
> >> From: Rajendra Nayak <rnayak@ti.com>
> >>
> >> All DPLLs except USB are in ALWON powerdomain. Make sure the
> >> clkdm/pwrdm for USB DPLL (l3init) is turned on before attempting
> >> a DPLL relock. So, mark the database accordingly.
> >>
> >> Without this fix, it was seen that DPLL relock fails while testing
> >> relock in a loop of USB DPLL.
> >>
> >> CC: Nishanth Menon <nm@ti.com>
> >> Tested-by: Ameya Palande <ameya.palande@ti.com>
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> ---
> >> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A01 +
> >> =A01 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap=
2/clock44xx_data.c
> >> index 08e86d7..9519374 100644
> >> --- a/arch/arm/mach-omap2/clock44xx_data.c
> >> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >> @@ -974,6 +974,7 @@ static struct clk dpll_usb_ck =3D {
> >> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &omap3_dpll_recalc,
> >> =A0 =A0 =A0 =A0.round_rate =A0 =A0 =3D &omap2_dpll_round_rate,
> >> =A0 =A0 =A0 =A0.set_rate =A0 =A0 =A0 =3D &omap3_noncore_dpll_set_rate,
> >> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> >> =A0};
> >>
> >> =A0static struct clk dpll_usb_clkdcoldo_ck =3D {
> >> --
> >> 1.7.4.1
> >>
>=20


- Paul
--155748971-666841224-1327518345=:5324--
