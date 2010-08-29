From: <msinger@eastcoreng.com>
Subject: OMAP3 Clock & CPU frequency
Date: Sun, 29 Aug 2010 12:03:17 -0700
Message-ID: <20100829120317.a6cb228ce30b55731ad61a39b8aeb07d.747596df1b.wbe@email00.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpoutwbe05.prod.mesa1.secureserver.net ([208.109.78.207]:42706
	"HELO smtpoutwbe05.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753606Ab0H2TJ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 Aug 2010 15:09:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Kevin Hilman wrote:

>>FWIW, the SR hwmods are still not enabling by default because the clock
>>fwk fails due to missing clockdomain.
>>
>>I've been manually working around by adding
>>
>>	.clkdm_name	= "wkup_clkdm",
>>
>>to sr*_fck, but I know that's not the correct fix.
>>
>>Kevin

That only seems to eliminate the warning.  I'm seeing omap_hwmod:
sr1_hwmod: cannot be enabled (3)
because oh->prcm.omap2 is Null on the call to
omap2_cm_wait_module_ready()

cpufreq changing does not occur.



