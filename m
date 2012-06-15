From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Fri, 15 Jun 2012 10:49:36 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A55E@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
 <20120614122930.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999C13@DBDE01.ent.ti.com>
 <20120614165337.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A2C4@DBDE01.ent.ti.com>
 <20120615104542.GR12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57893 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621Ab2FOKtm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 06:49:42 -0400
In-Reply-To: <20120615104542.GR12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Fri, Jun 15, 2012 at 16:15:43, Tony Lindgren wrote:

> something yesterday when manually patching the clk_activation, maybe
> I put the clk_activation value into async timings instead as I was
> seeing the tick value set to 0 for the sync mode.

I too thought like that initially, but when you told that putting
value of 1 tick made it work, I thought it is some different issue

Regards
Afzal
