From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Fri, 15 Jun 2012 05:42:46 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
References: <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
 <20120614122930.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999C13@DBDE01.ent.ti.com>
 <20120614165337.GO12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2FOFm6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 01:42:58 -0400
In-Reply-To: <20120614165337.GO12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Thu, Jun 14, 2012 at 22:23:37, Tony Lindgren wrote:
 
> Sounds like the tusb6010 non-ns tick value is the only remaining
> issue.

t.clk_activation = gpmc_ticks_to_ns(1);

was used so that gpmc_cs_set_timings would do gpmc_ns_to_ticks over
it & hence effectively 1 tick would get programmed in the register
for clock activation.

A value of 1 for clk_activation also should work due to rounding
effect.

But I am unable to find reason for failure upon using
gpmc_ticks_to_ns(1), which seems to me right thing to be used.
Let me try to invoke tusb6010 functions in beagle board,
observe timings so that at least I will get an idea
what is going on here (even though it is guaranteed to crash)

Regards
Afzal
