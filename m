From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 1/2 v4] ARM: OMAP2+: omap_hwmod: Add api to enable/disable
 module level wakeup events
Date: Fri, 1 Jun 2012 04:29:44 -0500
Message-ID: <CAOMWX4eQfOXBv9zP303RU-E09g=ZoZtNu8974Q=nn2J67cuW6A@mail.gmail.com>
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com> <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37182 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759233Ab2FAJaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 05:30:11 -0400
Received: by wibhn14 with SMTP id hn14so348503wib.10
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 02:30:08 -0700 (PDT)
In-Reply-To: <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Apr 25, 2012 at 2:17 AM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
[...]
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -289,6 +289,13 @@ static inline int omap2_prm_deassert_hardreset(s=
16 prm_mod, u8 rst_shift,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not suppose to be used on omap4\n");
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +static inline void omap2_prm_enable_prcm_module_wakeup(s16 prcm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 prm_reg_id, u8 prm_reg_shift, bool s=
et_wake)
> +{
> + =A0 =A0 =A0 WARN(1, "prm: omap2xxx/omap3xxx specific function and "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not suppose to be used on omap4\n");
> + =A0 =A0 =A0 return 0;
^^^^^ minor comment - we should not return a value in a function return=
ing void

[...]
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
