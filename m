From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFT 5/8] ARM: OMAP: clock: remove unused CK_3505 flag
Date: Mon, 30 Apr 2012 11:05:41 +0200
Message-ID: <CAORVsuVgNKUcsM+GuQfahp0r5U=24qBQhrX1E-DewhNvh0hk7g@mail.gmail.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
	<1335482993-14035-6-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61556 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2D3JFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 05:05:41 -0400
Received: by vbbff1 with SMTP id ff1so1891414vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 02:05:41 -0700 (PDT)
In-Reply-To: <1335482993-14035-6-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> This flag is no longer used since clock init all AM35x devices
> is now the same.
>
> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/clkdev_omap.h | =A0 =A03 +--
> =A01 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm=
/plat-omap/include/plat/clkdev_omap.h
> index b299b8d..45afa4d 100644
> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -34,7 +34,6 @@ struct omap_clk {
> =A0#define CK_243X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 5) =A0 =A0 =A0=
 =A0/* 243x, 253x */
> =A0#define CK_3430ES1 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* 34xxES1 only=
 */
> =A0#define CK_3430ES2PLUS (1 << 7) =A0 =A0 =A0 =A0/* 34xxES2, ES3, no=
n-Sitara 35xx only */
> -#define CK_3505 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
> =A0#define CK_3517 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 9)
If this is the only flag remaining, should it better be renamed to CK_3=
5XX?

> =A0#define CK_36XX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 10) =A0 =A0 =A0=
 /* 36xx/37xx-specific clocks */
> =A0#define CK_443X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 11)
> @@ -44,7 +43,7 @@ struct omap_clk {
>
>
> =A0#define CK_34XX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(CK_3430ES1 | CK_34=
30ES2PLUS)
> -#define CK_AM35XX =A0 =A0 =A0(CK_3505 | CK_3517) =A0 =A0 /* all Sita=
ra AM35xx */
> +#define CK_AM35XX =A0 =A0 =A0CK_3517 =A0 =A0 =A0 =A0 /* all Sitara A=
M35xx */
> =A0#define CK_3XXX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(CK_34XX | CK_AM35X=
X | CK_36XX)
>

Regards,
Jean

>
> --
> 1.7.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
