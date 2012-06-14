From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 07:07:52 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99959E@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <20120613120208.GN12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
 <4FD8ACD9.1010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60376 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2FNHIB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 03:08:01 -0400
In-Reply-To: <4FD8ACD9.1010507@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 20:38:09, Hunter, Jon wrote:
> On 06/13/2012 08:05 AM, Mohammed, Afzal wrote:

> > Do you mean that gpmc driver should have the capability to calculate peripheral
> > timings at runtime based on frequency ?, I am not sure how this can be handled
> > by gpmc driver as calculation for different peripherals are done in different
> > way, requiring gpmc driver to know about connected peripheral, that would imply
> > that gpmc driver would not be peripheral agnostic.
> 
> I guess I still don't agree with this. From the gpmc timing point of
> view it should not care what device is connected, it just needs to know
> the associated timings. Therefore, the gpmc driver just needs the time
> associated with the different timings fields in the various GPMC_CONFIGx
> registers and then convert to clocks based upon the gpmc fclk. The only
> item that is device specific here is the actual timing values and these
> can be passed to the driver.
> 
> Furthermore, gpmc_cs_set_timings function is completely device agnostic.
> Why can we not call this from within the driver? Why does it need to be
> called outside the driver?

As mentioned in one of my previous mails, input to gpmc_cs_set_timings
sometimes are a function of gpmc clock, and that function can vary with
the type of peripheral connected.

Regards
Afzal
