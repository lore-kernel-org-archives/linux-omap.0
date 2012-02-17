From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: smp-twd: check for uninitialized clock in twd_cpufreq_init
Date: Fri, 17 Feb 2012 16:17:17 +0530
Message-ID: <CAMQu2gzP1co6QhP-Co9wAwB_pVrjE0X_2GgGni4+t94yjHKi1g@mail.gmail.com>
References: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:36401 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878Ab2BQKri convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 05:47:38 -0500
Received: by mail-qw0-f43.google.com with SMTP id g1so716895qab.2
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 02:47:37 -0800 (PST)
In-Reply-To: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com

On Fri, Feb 17, 2012 at 4:04 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Non-smp platforms don't have local timer support, but the twd_cpufreq=
_init
> only checks for IS_ERR during init. Check against null also, to avoid
> crashes during cpufreq transitions on non-smp platforms.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
I sent a patch for the same issue which Kevin reported.

Thread.
http://www.spinics.net/lists/arm-kernel/msg160275.html

> =A0arch/arm/kernel/smp_twd.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..dae8902 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb =3D {
>
> =A0static int twd_cpufreq_init(void)
> =A0{
> - =A0 =A0 =A0 if (!IS_ERR(twd_clk))
> + =A0 =A0 =A0 if (twd_clk && !IS_ERR(twd_clk))

Checking the clock node is not enoough because you can
not have clock node and rely on calibration..
Testing twd_evt is safe to avoid the issue.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
