From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
Date: Wed, 13 Jun 2012 10:33:44 -0500
Message-ID: <4FD8B2D8.9000603@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com> <4FD65BA5.4020205@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com> <4FD7841D.1000202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab2FMPdo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:33:44 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 12:29 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 23:32:05, Hunter, Jon wrote:
> 
>> Well looking at the function it seems that you either return an error
>> code or 1. So if you are never going to return anything other than 1 on
>> success it may as well be 0.
> 
> Irq & memory resource creation functions returns number of resources,
> if memory function only is modified, that will cause loss of uniformity
> w.r.t irq function, even though both does similar things.

Ok, I see what you mean but from a readability standpoint it looked odd.
The other function is returning "n" where as this is just returning 1 on
success but it is not clear that this actually means 1 resource.

Jon
