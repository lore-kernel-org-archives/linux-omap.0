From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Tue, 8 Mar 2011 07:22:32 +0530
Message-ID: <20110308015232.GA4702@maz>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
 <1299338962-5602-4-git-send-email-nm@ti.com>
 <4D738E04.5090207@ru.mvista.com>
 <4D744870.20909@ti.com>
 <4D750673.702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57820 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730Ab1CHBwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 20:52:49 -0500
Received: by gwaa18 with SMTP id a18so2510146gwa.31
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 17:52:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D750673.702@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, Mar 07, 2011 at 07:23:15PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-03-2011 5:52, Nishanth Menon wrote:
> 
> >>>Blindly setting a 1.2V setting
> 
> >>Hm, seems tautological...
> 
> >As a non native English speaker, I would like to understand how we could
> >improve this. I suppose you mean "Blindly setting 1.2V" is better here. Am i
> >correct?
> 
>    Yes.
OK, here is the update as per the suggestion:
Regards,
Nishanth Menon
From: Nishanth Menon <nm@ti.com>
Date: Tue, 15 Feb 2011 09:37:18 +0530
Subject: [PATCH V4 3/19] OMAP3+: voltage: remove initial voltage

Blindly setting 1.2V in the initial structure may not even match the
default voltages stored in the voltage table which are supported for
the domain. For example, OMAP3430 core domain does not use 1.2V and
ends up generating a warning on the first transition.

Further, since omap2_set_init_voltage is called as part of the pm
framework's initialization sequence to configure the voltage required
for the current OPP, the call does(and has to) setup the system
voltage(curr_volt as a result) using the right mechanisms appropriate
for the system at that point of time. This also overrides
initialization we are currently doing in voltage.c making it
redundant. So, remove the wrong and redundant initialization.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 56961df..1b40aa0 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -116,7 +116,6 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->volt_scale = vp_forceupdate_scale_voltage;
 	vdd->vp_enabled = false;
 
-- 
1.7.1

