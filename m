From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/5] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Wed, 22 Sep 2010 13:41:14 +0400
Message-ID: <4C99CF3A.9080901@ru.mvista.com>
References: <20100922001834.8621.76144.stgit@twilight.localdomain> <20100922001931.8621.46565.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49087 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0IVJm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 05:42:58 -0400
Received: by eyb6 with SMTP id 6so76422eyb.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 02:42:57 -0700 (PDT)
In-Reply-To: <20100922001931.8621.46565.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>

Hello.

On 22-09-2010 4:19, Paul Walmsley wrote:

> From: Rajendra Nayak<rnayak@ti.com>

> If a module's OCP slave port is programmed to be in smartidle,
> its also necessary that they have module level wakeup enabled.
> Update _sysc_enable in hwmod framework to do this.

> The thread "[PATCH 7/8] : Hwmod api changes" archived here:

> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34212.html

> has additional technical information on the rationale of this patch.

> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Partha Basak<p-basak2@ti.com>
> Signed-off-by: Beno=C3=AEt Cousson<b-cousson@ti.com>
> [paul@pwsan.com: revised patch description]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index f320cfb..3f3d61a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
[...]
> @@ -703,6 +701,10 @@ static void _sysc_enable(struct omap_hwmod *oh)
>   		_set_clockactivity(oh, oh->class->sysc->clockact,&v);
>
>   	_write_sysconfig(v, oh);
> +
> +	/* If slave is in SMARTIDLE, also enable wakeup */
> +	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
> +			_enable_wakeup(oh);

    This line is overindented...

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
