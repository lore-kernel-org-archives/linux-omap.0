From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 7/7] arm: omap2: clksel: fix compile warning
Date: Mon, 17 Jan 2011 13:37:41 +0530
Message-ID: <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com> <1295238680-26738-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40019 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011Ab1AQII0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 03:08:26 -0500
Received: by iwn9 with SMTP id 9so4553138iwn.33
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 00:08:22 -0800 (PST)
In-Reply-To: <1295238680-26738-8-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Jan 17, 2011 at 10:01, Felipe Balbi <balbi@ti.com> wrote:
> Fix the following compile warning:
> arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval=
':
> arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
> used uninitialized in this function
>
> While at that, also add a check to avoid using max_clkr while NULL.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> =A0arch/arm/mach-omap2/clkt_clksel.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/=
clkt_clksel.c
> index a781cd6..baf0b6b 100644
> --- a/arch/arm/mach-omap2/clkt_clksel.c
> +++ b/arch/arm/mach-omap2/clkt_clksel.c
> @@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk=
, struct clk *clk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 *f=
ield_val)
> =A0{
> =A0 =A0 =A0 =A0const struct clksel *clks;
> - =A0 =A0 =A0 const struct clksel_rate *clkr, *max_clkr;
> + =A0 =A0 =A0 const struct clksel_rate *clkr, *max_clkr =3D NULL;
> =A0 =A0 =A0 =A0u8 max_div =3D 0;
>
> =A0 =A0 =A0 =A0clks =3D _get_clksel_by_parent(clk, src_clk);
> @@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *src_c=
lk, struct clk *clk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!max_clkr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

Would it be more appropriate to move this check after the "if" check
of max_div=3D=3D0 and it's warning?
or add a warning before it returns?

> +
> =A0 =A0 =A0 =A0if (max_div =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* This indicates an error in the clks=
el data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN(1, "clock: Could not find divisor=
 for clock %s parent %s"
> --
> 1.7.3.4.598.g85356
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
