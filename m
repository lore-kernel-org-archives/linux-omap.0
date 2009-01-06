From: "Anuj Aggarwal" <anuj.aggarwal@gmail.com>
Subject: Fwd: [PATCH v2 20/23] OMAP2/3 clock: omap2_clk_enable(): fix usecount decrement bug
Date: Tue, 6 Jan 2009 17:13:15 +0530
Message-ID: <2ee9e08d0901060343y65a4f582i24cfb75203cf20eb@mail.gmail.com>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
	 <20090105023459.12661.1871.stgit@localhost.localdomain>
	 <2ee9e08d0901060342q36a5ebd2i448d87ba55bb034d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:51906 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZAFLnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 06:43:16 -0500
Received: by an-out-0708.google.com with SMTP id d40so2504689and.1
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2009 03:43:15 -0800 (PST)
In-Reply-To: <2ee9e08d0901060342q36a5ebd2i448d87ba55bb034d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>

I also found the same issue while reviewing the code. Thanks for the patch.

Regards,
Anuj Aggarwal

On Mon, Jan 5, 2009 at 8:05 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> If _omap2_clk_enable() fails, the clock's usecount must be decremented by
> one no matter whether the clock has a parent or not.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clock.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 55f43d0..a9a2bbf 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -502,12 +502,10 @@ int omap2_clk_enable(struct clk *clk)
>        ret = _omap2_clk_enable(clk);
>
>        if (ret != 0) {
> +               clk->usecount--;
>                omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
> -
> -               if (clk->parent) {
> +               if (clk->parent)
>                        omap2_clk_disable(clk->parent);
> -                       clk->usecount--;
> -               }
>        }
>
>        return ret;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Best Regards,
Anuj Aggarwal



--
Best Regards,
Anuj Aggarwal
