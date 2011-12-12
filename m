From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
Date: Mon, 12 Dec 2011 13:45:48 +0530
Message-ID: <CAMQu2gxvYNjL2rrzs=H+ougB16po6GL-31hNd_wV42kNDBYBvA@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
 <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
 <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com> <CAJOA=zP0zs=eKsQXQPt5dj8EHQFnZ50Jnm_Ho425yH-NZkgY5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:40104 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904Ab1LLIQM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 03:16:12 -0500
Received: by qadc16 with SMTP id c16so345612qad.14
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:16:11 -0800 (PST)
In-Reply-To: <CAJOA=zP0zs=eKsQXQPt5dj8EHQFnZ50Jnm_Ho425yH-NZkgY5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 9, 2011 at 4:32 AM, Turquette, Mike <mturquette@ti.com> wro=
te:
> On Fri, Sep 30, 2011 at 2:15 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Fri, Sep 30, 2011 at 3:00 AM, Linus Walleij <linus.walleij@linaro=
=2Eorg> wrote:
>>> 2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>>>
>>>> Local timer clock is sourced from the CPU clock and hence changes
>>>> along with CPU clock. These per CPU local timers are used as
>>>> clock-events, so they need to be reconfigured on CPU frequency
>>>> change as part of CPUfreq governor.
>>>
>>> This requires patch 6956/2 right?
>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D69=
56/2
>>>
>>> Can I add your Tested-by: to the patch as well?
>>>
>> Sure.
>
> Santosh,
>
> I've taken in Linus' patch as well as this patch while testing clk
> notifiers (part of common clk framework code).
>
> Linus' patch matches the clk based on dev_id, but the clkdev entry in
> your patch populated dev_id with NULL and con_id with "smp_twd" so
> things never worked correctly. =A0Below changed fixed it for me:
>
You are right.
When I picked up the patch while changing the
OMAP44XX stuff to OMAP4430, looks like I miss-placed it.

> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
> b/arch/arm/mach-omap2/clock44xx_data.c
> index ae8c292..0f8cf68 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -4114,7 +4114,7 @@ static struct omap_clk omap44xx_clks[] =3D {
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "l4_div_ck",
> &l4_div_ck_hw.clk, =A0 =A0 =A0CK_443X),
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "lp_clk_div_ck",
> &lp_clk_div_ck_hw.clk, =A0CK_443X),
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "l4_wkup_clk_mux_ck",
> &l4_wkup_clk_mux_ck_hw.clk, =A0 =A0 CK_443X),
> - =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "smp_twd",
> &mpu_periphclk_hw.clk, =A0CK_443X),
> + =A0 =A0 =A0 CLK("smp_twd", =A0NULL, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &mpu_periphclk_hw.clk,
> =A0CK_443X),
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "ocp_abe_iclk",
> &ocp_abe_iclk_hw.clk, =A0 CK_443X),
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "per_abe_24m_fclk",
> &per_abe_24m_fclk_hw.clk, =A0 =A0 =A0 CK_443X),
> =A0 =A0 =A0 =A0CLK(NULL, =A0 =A0 =A0 "per_abe_nc_fclk",
> &per_abe_nc_fclk_hw.clk, =A0 =A0 =A0 =A0CK_443X),
>
> A better change might be for the code in smp_twd.c to match on con_id
> but I'll let you guys sort that out.

I guess we can stick to what Linus and others have followed.
Will post an updated patch. Thanks for catch.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
