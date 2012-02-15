From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2] ARM: OMAP: clock: cleanup CPUfreq leftovers
Date: Wed, 15 Feb 2012 11:23:22 -0800
Message-ID: <CAORVsuUvv0Z36FK19J90uj8g16T9tvWzubpEF5s==wm_fXBB3w@mail.gmail.com>
References: <1329333165-29646-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57935 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab2BOTXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 14:23:23 -0500
Received: by vcge1 with SMTP id e1so998181vcg.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 11:23:23 -0800 (PST)
In-Reply-To: <1329333165-29646-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

HI Kevin,

On Wed, Feb 15, 2012 at 11:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -272,7 +272,7 @@ struct clk {
> =A0#endif
> =A0};
>
> -struct cpufreq_frequency_table;
> +/* struct cpufreq_frequency_table; */
This needs to be removed.

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
