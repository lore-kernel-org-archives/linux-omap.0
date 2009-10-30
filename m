From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH] omap-pm: Fixes behaviour of some shared resource
 framework functions
Date: Fri, 30 Oct 2009 13:28:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE16F61A@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com>
	<87iqejktan.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com>
	<003201ca581b$256863c0$544ff780@am.dhcp.ti.com>
	<87hbtj3zpc.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA9DDEF056E@dnce01.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE16F1FC@dbde02.ent.ti.com>
 <87zl7a1a0t.fsf@deeprootsystems.com> <4AEA0B37.5070604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbZJ3H6e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 03:58:34 -0400
In-Reply-To: <4AEA0B37.5070604@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'Paul Walmsley' <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Titiano, Patrick" <p-titiano@ti.com>

> An assumption in this thread is that ondemand/conservative can't scale
> fast enough, but that is not true.  The Android UI sluggishness
> mentioned by Benoit was solved by lowering the cpufreq
> transition_latency time from 10 million ns to 300,000ns.  I have not
> gotten the exact worst case time that it takes for voltage to scale up
> and down from the hardware guys, but through some email exchanges it was
> agreed that this value is safe.
> 
This has the effect of arming the timers more frequently and hence more power consumption! But I guess as Kevin says, if the user wants to sacrifice power for performance this might be ok. 
