From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 4/9] ARM: OMAP2+: gpmc-tusb6010: Adapt to use gpmc driver
Date: Wed, 13 Jun 2012 13:14:48 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998E65@DBDE01.ent.ti.com>
References: <cover.1339419379.git.afzal@ti.com>
 <9c6c6b0298e37b1985a89e2cd99c35504521a1da.1339419379.git.afzal@ti.com>
 <20120613122747.GQ12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab2FMNOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 09:14:54 -0400
In-Reply-To: <20120613122747.GQ12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jun 13, 2012 at 17:57:48, Tony Lindgren wrote:

> We can drop the old interface for non-mainline cases. In this case
> tusb6010 is only used by board-n8x0.c, so it's best to just convert
> it all to use the new interface.

Right, I will do accordingly

Regards
Afzal
