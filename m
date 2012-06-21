From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Thu, 21 Jun 2012 06:38:53 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99D5F8@DBDE01.ent.ti.com>
References: <cover.1339828867.git.afzal@ti.com>
 <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com>
 <4FDF50EA.4080506@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99C502@DBDE01.ent.ti.com>
 <4FE24A9B.6070203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682Ab2FUGi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 02:38:59 -0400
In-Reply-To: <4FE24A9B.6070203@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Thu, Jun 21, 2012 at 03:41:39, Hunter, Jon wrote:

> Ok, I see your point. So today the _set_async_mode() is really doing two
> things ...
> 
> 1. It is calculating the timings
> 2. Programming the timings and setting async mode.
> 
> I think that it would be best if we were to make _set_async_mode() into
> two functions, for example ...
> 
> 1. omap2_onenand_get_async_timings()
> 2. omap2_onenand_set_async_timings()
> 
> Where the omap2_onenand_get_async_timings() calculates the timings and
> can be used in both legacy mode and with the driver. Then
> omap2_onenand_set_sync_timings() is just used in the legacy mode where
> we don't have the driver to configure the chip-select.
> 
> Do you think that could work?
> 
> We could also do the same for omap2_onenand_set_sync_mode().

Seems it should work

Not sure whether the best time to do such kind of refactoring is
at the time of cleaning up / generalizing timing calculation, one
reason to think that way being removal of legacy mode once driver
migration is completed. Goal for this series was to do the minimal
of changes, without creating any disruptive changes to prepare for
gpmc driver series so that both interfaces would work.

Either way I will go ahead and make change as per your suggestions,
seems at least there is one advantage; w.r.t bringing setting bool
type time settings to gpmc_cs_set_timings (even though may not be
necessary for this change, it will certainly simplify it) and make
it part of driver preparation series and this will help us discover
if any board depends on these kinds of settings unknowingly with the
preparation series itself rather than hunting for it in driver series

Regards
Afzal
