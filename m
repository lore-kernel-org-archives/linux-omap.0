From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH v5 6/7] arm: omap4: support pmu
Date: Wed, 23 Nov 2011 23:17:54 +0530
Message-ID: <CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-7-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54907 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1KWRsf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 12:48:35 -0500
Received: by iage36 with SMTP id e36so1896324iag.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 09:48:35 -0800 (PST)
In-Reply-To: <1319467559-5518-7-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ming.lei@canonical.com
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Woodruff Richard <r-woodruff2@ti.com>

On Mon, Oct 24, 2011 at 20:15,  <ming.lei@canonical.com> wrote:
> =A0static struct platform_device* __init omap4_init_pmu(void)
> =A0{
> =A0 =A0 =A0 =A0int id =3D -1;
> @@ -420,6 +472,10 @@ static struct platform_device* __init omap4_init=
_pmu(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 omap4_pmu_data.handle_irq =3D omap4_pmu_handler;
> + =A0 =A0 =A0 omap4_pmu_data.enable_irq =3D omap4_enable_cti;
> + =A0 =A0 =A0 omap4_pmu_data.disable_irq =3D omap4_disable_cti;
> +
> =A0 =A0 =A0 =A0pd =3D omap_device_build_ss(dev_name, id, oh, 3, &omap=
4_pmu_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(omap4_pmu_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_p=
mu_latency,
> @@ -440,7 +496,9 @@ static void __init omap_init_pmu(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pd =3D omap4_init_pmu();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!pd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable(pd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable(&od->pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_configure_pmu_irq();

This doesn't build, because there's no "od" in this function.  I guess
you shouldn't be changing the omap_device_enable() call.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
