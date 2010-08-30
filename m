From: "Matt Singer" <msinger@eastcoreng.com>
Subject: RE: OMAP3 Clock & CPU frequency
Date: Mon, 30 Aug 2010 08:32:16 -0400
Message-ID: <FD0C0605F3FF45D2B85DAAF553EE8E16@Matt4400>
References: <20100829120317.a6cb228ce30b55731ad61a39b8aeb07d.747596df1b.wbe@email00.secureserver.net> <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CF59@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa01-04.prod.phx3.secureserver.net ([72.167.82.84]:47001
	"HELO p3plsmtpa01-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751920Ab0H3Mi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Aug 2010 08:38:28 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CF59@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Gopinath, Thara'" <thara@ti.com>, linux-omap@vger.kernel.org

Is it in mainline yet or still a patch?

-----Original Message-----
From: Gopinath, Thara [mailto:thara@ti.com] 
Sent: Monday, August 30, 2010 6:29 AM
To: msinger@eastcoreng.com; linux-omap@vger.kernel.org
Subject: RE: OMAP3 Clock & CPU frequency



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org 
>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
>>msinger@eastcoreng.com
>>Sent: Monday, August 30, 2010 12:33 AM
>>To: linux-omap@vger.kernel.org
>>Subject: OMAP3 Clock & CPU frequency
>>
>>
>>Kevin Hilman wrote:
>>
>>>>FWIW, the SR hwmods are still not enabling by default because the 
>>>>clock fwk fails due to missing clockdomain.
>>>>
>>>>I've been manually working around by adding
>>>>
>>>>	.clkdm_name	= "wkup_clkdm",
>>>>
>>>>to sr*_fck, but I know that's not the correct fix.
>>>>
>>>>Kevin
>>
>>That only seems to eliminate the warning.  I'm seeing omap_hwmod:
>>sr1_hwmod: cannot be enabled (3)
>>because oh->prcm.omap2 is Null on the call to
>>omap2_cm_wait_module_ready()
>>
>>cpufreq changing does not occur.


Which version of these patches are you using?
The V2 version does have oh->prcm.omap2 populated for smartreflex.

Regards
Thara

No virus found in this incoming message.
Checked by AVG - www.avg.com
Version: 9.0.851 / Virus Database: 271.1.1/3093 - Release Date: 08/29/10
14:34:00

