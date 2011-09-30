From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
Date: Thu, 29 Sep 2011 18:33:06 -0700
Message-ID: <CAJOA=zOwcV5EoXWFVbqiF1jUVQaEVqZy7OEzeRFC5hCF396GiQ@mail.gmail.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
 <1317343888-30892-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1109291925120.26728@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40877 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000Ab1I3Bd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Sep 2011 21:33:27 -0400
Received: by mail-wy0-f177.google.com with SMTP id 11so797287wyi.36
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 18:33:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109291925120.26728@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 29, 2011 at 6:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 29 Sep 2011, Mike Turquette wrote:
>
>> Not all DPLLs are identical; some require special consideration such=
 as
>> OMAP4's ABE DPLL, which can have an additional 4x multiplier added t=
o
>> it's clock rate based on programming the REGM4XEN bit in it's CLKMOD=
E
>> register.
>>
>> Unfortunately the clock framework makes a few assumptions that all D=
PLLs
>> can have their rates calculated the same way which has led to incorr=
ect
>> rates for OMAP4's DPLL_ABE in some cases. =A0This patch fixes the sa=
me by
>> replacing explicit calls to omap2_dpll_get_rate with clk->recalc if
>> .recalc is populated for a clock. =A0If .recalc is NULL then fall ba=
ck to
>> omap2_dpll_get_rate.
>>
>> Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>
> The conditional in the second hunk of this patch has been simplified =
for
> readability. =A0Updated patch below. =A0Please let me know if I screw=
ed
> something up. =A0Otherwise, queued for 3.2 fixes.

Looks good to me.

Regards,
Mike

> thanks
>
>
> - Paul
>
> From: Mike Turquette <mturquette@ti.com>
> Date: Thu, 29 Sep 2011 17:51:28 -0700
> Subject: [PATCH] ARM: OMAP2+: clock: use clock's recalc in DPLL handl=
ing
>
> Not all DPLLs are identical; some require special consideration such =
as
> OMAP4's ABE DPLL, which can have an additional 4x multiplier added to
> it's clock rate based on programming the REGM4XEN bit in it's CLKMODE
> register.
>
> Unfortunately the clock framework makes a few assumptions that all DP=
LLs
> can have their rates calculated the same way which has led to incorre=
ct
> rates for OMAP4's DPLL_ABE in some cases. =A0This patch fixes the sam=
e by
> replacing explicit calls to omap2_dpll_get_rate with clk->recalc if
> .recalc is populated for a clock. =A0If .recalc is NULL then fall bac=
k to
> omap2_dpll_get_rate.
>
> Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> [paul@pwsan.com: simplified conditional]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/dpll3xxx.c | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpl=
l3xxx.c
> index f77022b..fe4533f 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -390,7 +390,8 @@ int omap3_noncore_dpll_enable(struct clk *clk)
> =A0 =A0 =A0 =A0 * propagating?
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (!r)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D omap2_get_dpll_rate(clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D (clk->recalc) ? clk->reca=
lc(clk) :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_get_dpll_rate(clk=
);
>
> =A0 =A0 =A0 =A0return r;
> =A0}
> @@ -425,6 +426,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, =
unsigned long rate)
> =A0{
> =A0 =A0 =A0 =A0struct clk *new_parent =3D NULL;
> =A0 =A0 =A0 =A0u16 freqsel =3D 0;
> + =A0 =A0 =A0 unsigned long hw_rate;
> =A0 =A0 =A0 =A0struct dpll_data *dd;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -435,7 +437,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, =
unsigned long rate)
> =A0 =A0 =A0 =A0if (!dd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 if (rate =3D=3D omap2_get_dpll_rate(clk))
> + =A0 =A0 =A0 hw_rate =3D (clk->recalc) ? clk->recalc(clk) : omap2_ge=
t_dpll_rate(clk);
> + =A0 =A0 =A0 if (rate =3D=3D hw_rate)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0/*
> --
> 1.7.6.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
