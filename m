From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with frequency
Date: Thu, 16 Feb 2012 11:24:22 -0800
Message-ID: <CAORVsuUsnp8gMygbsrQh7O6048eUyjTrT3Ob_Jop5JKQyxiMOA@mail.gmail.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56283 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab2BPTYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 14:24:22 -0500
Received: by mail-vw0-f46.google.com with SMTP id k17so1710977vbj.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 11:24:22 -0800 (PST)
In-Reply-To: <1329420043-32656-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Kevin,

On Thu, Feb 16, 2012 at 11:20 AM, Kevin Hilman <khilman@ti.com> wrote:
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 8a36342..140c032 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -89,6 +89,8 @@ int voltdm_scale(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0ret =3D voltdm->scale(voltdm, target_volt);
> =A0 =A0 =A0 =A0if (!ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0voltdm->nominal_volt =3D target_volt;
> + =A0 =A0 =A0 printk("KJH: %s: %d\n", __func__, target_volt);
> + =A0 =A0 =A0 dump_stack();
The debugging letfovers need to be removed.

>
> =A0 =A0 =A0 =A0return ret;
> =A0}

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
