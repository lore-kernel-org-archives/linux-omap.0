From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 07:03:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37840 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2FNHDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 03:03:13 -0400
In-Reply-To: <4FD8A906.8080202@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 20:21:50, Hunter, Jon wrote:
 
> If the clk handle for the gpmc is passed to the gpmc driver, then there
> is no reason why the driver cannot do this.

I believe passing clk details through platform data is an abuse of
clock framework.

Regards
Afzal
