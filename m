From: Nishanth Menon <nm@ti.com>
Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
Date: Tue, 23 Mar 2010 17:49:08 -0500
Message-ID: <4BA94564.8030803@ti.com>
References: <20100322212025.GW11448@atomide.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com> <20100323152709.GD11448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab0CWWtT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 18:49:19 -0400
In-Reply-To: <20100323152709.GD11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pais, Allen" <allen.pais@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>

Tony Lindgren had written, on 03/23/2010 10:27 AM, the following:
[...]
> Then at least one issue remains for zoom3 to be usable..
> I'm getting tons of MMC errors trying to mount root on it:
> 
> mmcblk1: error -110 transferring data, sector 2097024, nr 8, card status 0x900  
> end_request: I/O error, dev mmcblk1, sector 2097024
> ...
> 
I have seen this on few platforms and seem to be related to eMMC usage.

> Any ideas if that's fixed somewhere also?
Madhu, any comments?

-- 
Regards,
Nishanth Menon
