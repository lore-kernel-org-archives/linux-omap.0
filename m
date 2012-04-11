From: Archit Taneja <a0393947@ti.com>
Subject: query about _setup() in omap_hwmod.c
Date: Wed, 11 Apr 2012 15:07:10 +0530
Message-ID: <4F8550C6.9050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49469 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552Ab2DKJhk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 05:37:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I had a query about the _setup() function in 
arch/arm/mach-omap2/omap_hwmod.c:

The function enables slave clocks right in the beginning, and based on 
the value of postsetup_state, it either calls _idle(), _shutdown() or 
does nothing.

Now, for the case of _idle() or _shutdown(), I guess it's the job of 
_disable_clocks() to disable the slave clocks before we exit _setup().

If we compare how the slave clocks are enabled and disabled in _setup() 
and _disable_clocks() respectively:

static int _setup(struct omap_hwmod *oh, void *data)
{
	...
	...
	if (os->flags & OCPIF_SWSUP_IDLE) {
                                 /* XXX omap_iclk_deny_idle(c); */
                         } else {
                                 /* XXX omap_iclk_allow_idle(c); */
                                 clk_enable(c);
                         }
	}
	...
	...
}

static int _disable_clocks(struct omap_hwmod *oh)
{
	...
	...
	if (c && (os->flags & OCPIF_SWSUP_IDLE))
		clk_disable(c);
	...
	...
}

Both these functions are taking different decisions based on whether 
os->flags has OCPIF_SWSUP_IDLE or not.

Would this lead to some sort of clk_enable() and clk_disable() mismatch?

If I boot a 3.4-rc1 kernel on beagle with omap2plus_defconfig, I get:

cat /sys/kernel/debug/clock/summary | grep dss

name                parent              freq     use_count
dss_ick                        l4_ick                 83000000   4
dss2_alwon_fck                 sys_ck                 13000000   0
dss_96m_fck                    omap_96m_fck           96000000   0
dss_tv_fck                     omap_54m_fck           54000000   0
dss1_alwon_fck                 dpll4_m4x2_ck          144000000  0

dss_ick is the slave clock of all the dss hwmods on omap3. This doesn't 
seem to be right, does it?

Thanks,
Archit
