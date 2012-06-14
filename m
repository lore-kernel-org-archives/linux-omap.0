From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 06:20:26 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9994C0@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2FNGUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 02:20:32 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Thu, Jun 14, 2012 at 11:47:03, Mohammed, Afzal wrote:

> gpmc_cs_set_timings() does currently convert time to clock cycles required,
> and this gpmc driver have the capability to do it.
> 
> What I was saying is a different issue, input to gpmc_cs_set_timings, which
> is time sometimes in turn is a function of time or to be exact depends on
> gpmc clock period also. So timings provided to gpmc_cs_set_timings for a
> particular frequency may not hold good for another frequency, unless we
> change the input time to gpmc_cs_set_timings based on gpmc clock.
> 
> If you see gpmc-* files, many a times, they need to know value of gpmc fclk,
> to calculate the input time to be fed for gpmc_cs_set_timings

And the way value of gpmc period has to be handled differs depending
on the peripheral.

Regards
Afzal
