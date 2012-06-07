From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 7 Jun 2012 18:09:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA44DD9@DBDE01.ent.ti.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk>
 <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605Ab2FGSJO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 14:09:14 -0400
In-Reply-To: <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, Jun 07, 2012 at 12:38:50, Paul Walmsley wrote:
> Hi
> 
> On Thu, 7 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > Isn't this impact AM33xx devices, where we do not support smart idle mode???
> > Anyway, I will also test it on both OMAP3EVM and AM33xx platform now...
> 
> Thanks, please let me know how your tests go.  If it doesn't work, we'll 
> go back to the flag-based approach in the patch I posted already.  
> 

Paul,

I couldn't finish my testing today, got into continuous meetings.
Tomorrow, I will test it and update you on this.

Thanks,
Vaibhav
