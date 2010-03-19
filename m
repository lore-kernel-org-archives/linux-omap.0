From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PM-WIP-OPP][PATCH 4/4] omap3: srf: remove hardcoded opp
 dependency
Date: Fri, 19 Mar 2010 16:47:48 +0200
Message-ID: <20100319144747.GV18995@nokia.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
 <1268937891-19445-5-git-send-email-nm@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60930 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0CSOsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 10:48:46 -0400
Content-Disposition: inline
In-Reply-To: <1268937891-19445-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>

On Thu, Mar 18, 2010 at 07:44:51PM +0100, ext Nishanth Menon wrote:
>@@ -131,5 +133,16 @@ void __init omap3_pm_init_opp_table(void)
> 	r |= opp_init_list(OPP_L3, omap3_opp_def_list[1]);
> 	r |= opp_init_list(OPP_DSP, omap3_opp_def_list[2]);
> 	BUG_ON(r);
>+
>+	/* First get the l3 thresh from highest l3 opp */
>+	freq = ULONG_MAX;
>+	opp = opp_find_freq_floor(OPP_L3, &freq);
>+	l3_thresh = freq * 4 / 1000;
>+	/* Now setup the L3 bandwidth restrictions for right mpu freqs */
>+	freq = cpu_is_omap3630() ? 500000000 : 600000000;

I also don't like this. Don't you have somewhere else you could pick ?

>+	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq))) {
>+		opp_store_data(opp, "l3thresh", (void *) l3_thresh);
>+		freq++;
>+	}

this is a good example of what I mean. Instead of saving l3_thresh, why 
don't you group all those data in a structure (which could even be 
defined per-cpu really, you already have cpufreq34xx, so you could have 
cpufreq24xx 36xx 44xx, etc) and just store that in a void * ??

-- 
balbi
