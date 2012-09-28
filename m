From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()
Date: Fri, 28 Sep 2012 12:42:12 +0200
Message-ID: <CAORVsuWGPw6Q4Z-nnPqMMBAf=tYXGydHqXSnd-JdXRV9NtGP=A@mail.gmail.com>
References: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42482 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab2I1KmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 06:42:14 -0400
Received: by bkcjk13 with SMTP id jk13so3153956bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:42:12 -0700 (PDT)
In-Reply-To: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 27, 2012 at 7:54 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function voltdm_lookup() returns NULL
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 9cb5ced..ab15e5c 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -176,7 +176,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>         }
>
>         voltdm = voltdm_lookup(vdd_name);
> -       if (IS_ERR(voltdm)) {
> +       if (!voltdm) {
>                 pr_err("%s: unable to get vdd pointer for vdd_%s\n",
>                         __func__, vdd_name);
>                 goto exit;

This looks good, so here is the ack:
Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
