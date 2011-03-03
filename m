From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/19] omap3+: sr: introduce class init,deinit and priv data
Date: Wed, 02 Mar 2011 16:08:07 -0800
Message-ID: <87r5apvzfc.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56135 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753377Ab1CCAIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:08:10 -0500
Received: by mail-pz0-f52.google.com with SMTP id 36so95788pzk.39
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:08:09 -0800 (PST)
In-Reply-To: <1298116918-30744-10-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Certain class drivers such as class 1.5 drivers, will need specific
> notification that they have to be started up or stopped independent
> of smart reflex operation. They also may need private data to be
> used for operations of their own, provide the same.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Basic principle looks fine, but some naming comments below...

[...]

> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
> index 6568c88..8b6ecd9 100644
> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
> @@ -167,6 +167,8 @@ struct omap_sr_pmic_data {
>   *
>   * @enable:		API to enable a particular class smaartreflex.
>   * @disable:		API to disable a particular class smartreflex.
> + * @class_init:		API to do class specific initialization (optional)
> + * @class_deinit:	API to do class specific initialization (optional)

The 'class_' prefix here is not needed.

The changelog uses 'start' and 'stop' instead of init & deinit.  I
prefer those names to [de]init.

Kevin
