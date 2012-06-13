From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Wed, 13 Jun 2012 07:37:56 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD6783D.9030208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com>
 <4FD78748.2080504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56009 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab2FMHiF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 03:38:05 -0400
In-Reply-To: <4FD78748.2080504@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 23:45:36, Hunter, Jon wrote:

> GPMC_WAITPIN_IDX0 = 0
> GPMC_WAITPIN_0 = 1
> 
> So, GPMC_WAITPIN_IDX0 = GPMC_WAITPIN_0 - 1, assuming that you want idx =
> 0 and not 1. Or you could change you shift value too. I was just
> highlighting that they are not equal but one set of definitions could be
> used.

In that case we would be directly depending on user flag whose value may
or may not change and I don't think it is good to directly depend on it
for waitpin # calculation.

Regards
Afzal
