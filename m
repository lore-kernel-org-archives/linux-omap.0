From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] OMAP1 clock: Add missing clocks for OMAP 7xx
Date: Tue, 22 Dec 2009 17:28:00 -0700
Message-ID: <6cb013310912221628m1b2b820fy1a96a9a9102274e5@mail.gmail.com>
References: <alpine.DEB.2.00.0912220901360.5563@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:32834 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbZLWA2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 19:28:21 -0500
Received: by pzk1 with SMTP id 1so203940pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 16:28:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912220901360.5563@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Dec 22, 2009 at 9:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> From: Cory Maccarrone <darkstar6262@gmail.com>
>
> This change adds in some missing clocks that were needed as a result
> of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
> mach-omap1/clock_data.c). =C2=A0Prior to this, it was just assumed th=
at
> these clocks existed for all devices, and it was used directly instea=
d
> of calling it out with a clock_get call or similar. =C2=A0So, not hav=
ing
> the CK_7XX meant these clocks weren't being used anymore for omap 7xx
> devices, which broke things badly.
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> [paul@pwsan.com: commit message edited]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =C2=A0arch/arm/mach-omap1/clock_data.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/c=
lock_data.c
> index ab995a9..31fba07 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -599,7 +599,7 @@ static struct clk i2c_ick =3D {
> =C2=A0static struct omap_clk omap_clks[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* non-ULPD clocks */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_ref", =C2=
=A0 =C2=A0 =C2=A0 &ck_ref, =C2=A0 =C2=A0 =C2=A0 =C2=A0CK_16XX | CK_1510=
 | CK_310 | CK_7XX),
> - =C2=A0 =C2=A0 =C2=A0 CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_dpll1", =C2=
=A0 =C2=A0 &ck_dpll1, =C2=A0 =C2=A0 =C2=A0CK_16XX | CK_1510 | CK_310),
> + =C2=A0 =C2=A0 =C2=A0 CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_dpll1", =C2=
=A0 =C2=A0 &ck_dpll1, =C2=A0 =C2=A0 =C2=A0CK_16XX | CK_1510 | CK_310 | =
CK_7XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CK_GEN1 clocks */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_dpll1ou=
t", =C2=A0&ck_dpll1out.clk, CK_16XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_sossi",=
 =C2=A0 =C2=A0 &sossi_ck, =C2=A0 =C2=A0 =C2=A0CK_16XX),
> @@ -627,7 +627,7 @@ static struct omap_clk omap_clks[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "tc2_ck", =C2=
=A0 =C2=A0 =C2=A0 &tc2_ck, =C2=A0 =C2=A0 =C2=A0 =C2=A0CK_16XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "dma_ck", =C2=
=A0 =C2=A0 =C2=A0 &dma_ck, =C2=A0 =C2=A0 =C2=A0 =C2=A0CK_16XX | CK_1510=
 | CK_310),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "dma_lcdfre=
e_ck", &dma_lcdfree_ck, CK_16XX),
> - =C2=A0 =C2=A0 =C2=A0 CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "api_ck", =C2=A0=
 =C2=A0 =C2=A0 &api_ck.clk, =C2=A0 =C2=A0CK_16XX | CK_1510 | CK_310),
> + =C2=A0 =C2=A0 =C2=A0 CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "api_ck", =C2=A0=
 =C2=A0 =C2=A0 &api_ck.clk, =C2=A0 =C2=A0CK_16XX | CK_1510 | CK_310 | C=
K_7XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "lb_ck", =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&lb_ck.clk, =C2=A0 =C2=A0 CK_1510 | CK_310),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "rhea1_ck",=
 =C2=A0 =C2=A0 &rhea1_ck, =C2=A0 =C2=A0 =C2=A0CK_16XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "rhea2_ck",=
 =C2=A0 =C2=A0 &rhea2_ck, =C2=A0 =C2=A0 =C2=A0CK_16XX),
> --
> 1.6.6.rc2.5.g49666
>

I'd like to amend this patch -- there's more wrong in this file than
simply missing clocks, as it turns out.  I'll submit my new patch for
review shortly.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
