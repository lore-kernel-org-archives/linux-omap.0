From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
Date: Fri, 7 Oct 2011 12:32:01 -0700
Message-ID: <CAJOA=zNwDCVjzZJs87ze0xdJ8m=CDDmp8QAApj9cMhoPsFqBuw@mail.gmail.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
 <1317343888-30892-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1110070104260.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:33733 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996Ab1JGTcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 15:32:24 -0400
Received: by wwf10 with SMTP id 10so5549680wwf.8
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 12:32:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110070104260.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 7, 2011 at 12:07 AM, Paul Walmsley <paul@pwsan.com> wrote:
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
> I've merged this patch with Jon's "ARM: OMAP3+: dpll: use DPLLs recal=
c
> function instead of omap2_get_dpll_rate" patch, which does almost exa=
ctly
> the same thing, just without the conditionals on clk->recalc. =A0Upda=
ted
> patch below. =A0Please let me know if you think I should change anyth=
ing
> about the changelog.

Heh, I hadn't realized we had overlapping patches like that.  Looks fin=
e to me.

Regards,
Mike

> - Paul
>
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 7 Oct 2011 00:53:01 -0600
> Subject: [PATCH] ARM: OMAP3+: dpll: use DPLLs recalc function instead=
 of
> =A0omap2_get_dpll_rate
>
> This is a continuation of Mike Turquette's patch "OMAP3+: use
> DPLL's round_rate when setting rate".
>
> omap3_noncore_dpll_set_rate() and omap3_noncore_dpll_enable() call
> omap2_get_dpll_rate() explicitly. It may be necessary for some
> DPLLs to use a different function and so use the DPLLs recalc()
> function pointer instead.
>
> An example is the DPLL_ABE on OMAP4 which can have a 4X multiplier
> in addition to the usual MN multipler and dividers and therefore
> uses a different round_rate and recalc function.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Misael Lopez Cruz <misael.lopez@ti.com>
> [paul@pwsan.com: merged this patch with Mike's "use clock's recalc in=
 DPLL
> =A0handling" patch; also reported by Misael]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/dpll3xxx.c | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpl=
l3xxx.c
> index 73a1595..fc56745 100644
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
> @@ -424,6 +425,7 @@ void omap3_noncore_dpll_disable(struct clk *clk)
> =A0int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rat=
e)
> =A0{
> =A0 =A0 =A0 =A0struct clk *new_parent =3D NULL;
> + =A0 =A0 =A0 unsigned long hw_rate;
> =A0 =A0 =A0 =A0u16 freqsel =3D 0;
> =A0 =A0 =A0 =A0struct dpll_data *dd;
> =A0 =A0 =A0 =A0int ret;
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
