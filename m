From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Wed, 27 Jan 2010 23:42:31 -0600
Message-ID: <4B6123C7.5010203@ti.com>
References: <1264657260-12310-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47660 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833Ab0A1Fmm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 00:42:42 -0500
In-Reply-To: <1264657260-12310-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Andrew Murray <amurray@mpc-data.co.uk>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Menon, Nishanth had written, on 01/27/2010 11:41 PM, the following:
> We had removed the frequency for OPP1 L3 when we used to use frequency
> to enable/disable frequencies. It is better to populate the same
> instead of confusing future readers of the code. The OPP1 remains
> disabled as explained in the discussion.
> 
> Discussion: http://marc.info/?t=126453821900001&r=1&w=2
Clarification: This is for pm-wip-opp branch. apologies on the spam :(

-- 
Regards,
Nishanth Menon
