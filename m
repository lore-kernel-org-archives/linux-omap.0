From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Current state of AM33xx patches
Date: Wed, 4 Jul 2012 04:07:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45400 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623Ab2GDKHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:07:32 -0400
In-Reply-To: <4FEEC7F2.8070507@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On Sat, 30 Jun 2012, Daniel Mack wrote:

> Ok, thanks for the explaining this. For now, I'll add hwmod stubs for
> the components I need.

Hmm.  Which drivers are you working on?  Vaibhav Hiremath has hwmod data 
for the AM33xx.  There might be some missing integration code to build the 
devices for the newer IP blocks, though.

> Btw, has anyone yet worked on getting the MDIO/EMAC driver merged?

Mainline has:

drivers/net/ethernet/ti/davinci_emac.c
drivers/net/ethernet/ti/davinci_mdio.c

Those might work for you.


- Paul
