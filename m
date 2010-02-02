From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 1/2 v2] DSPBRIDGE: remove dependency of mpu freq
Date: Tue, 2 Feb 2010 15:00:44 +0200
Message-ID: <20100202130044.GB4048@annwn.felipec.org>
References: <1265095046-25253-1-git-send-email-nm@ti.com>
 <1265095046-25253-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52078 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab0BBNBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:01:04 -0500
Content-Disposition: inline
In-Reply-To: <1265095046-25253-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Romit Dasgupta <romit@ti.com>

On Tue, Feb 02, 2010 at 08:17:25AM +0100, Nishanth Menon wrote:
> Current DSPBridge uses hardcoded logic which is not scalable
> across OMAP3 silicons. introduce a structure based implementation
> this allows for dsp frequency table indices to be generated runtime
> instead of being compile time.

You forgot to mention the impact of this patch: DVFS is effectively
disabled until the next patch is applied. Right?

> +static int get_opp_table(struct dspbridge_platform_data *pdata)
> +{
> +#ifdef CONFIG_BRIDGE_DVFS
> +	/* Do nothing now  - fill based on PM implementation */
> +#endif
> +	return 0;
> +}

-- 
Felipe Contreras
