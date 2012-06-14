From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
Date: Thu, 14 Jun 2012 08:44:01 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9996BE@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
 <4FD7841D.1000202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
 <4FD8B2D8.9000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51459 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab2FNIoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 04:44:13 -0400
In-Reply-To: <4FD8B2D8.9000603@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 21:03:44, Hunter, Jon wrote:
> On 06/13/2012 12:29 AM, Mohammed, Afzal wrote:

> > Irq & memory resource creation functions returns number of resources,
> > if memory function only is modified, that will cause loss of uniformity
> > w.r.t irq function, even though both does similar things.
> 
> Ok, I see what you mean but from a readability standpoint it looked odd.
> The other function is returning "n" where as this is just returning 1 on
> success but it is not clear that this actually means 1 resource.

Ok, I will add comments to make it clear

Regards
Afzal
