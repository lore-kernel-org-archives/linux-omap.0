From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2 patch series
Date: Thu, 5 Aug 2010 12:36:27 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41342 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758832Ab0HEHGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 03:06:34 -0400
In-Reply-To: <1280825023.3436.111.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> 
> Also, we should think how to reduce if (cpu_is_omap44xx()) 
> lines. There should be some kind of DSS capability list 
> somewhere, which would tell the features available. I haven't 
> thought this more, but it'd be very nice if we could use the 
> DSS HW version number to decide what features there are.
> 
> However, TI answered that information about DSS HW version 
> numbers is not available, and thus cannot be used =(. Perhaps 
> you could try to dig out some information from inside TI?
> 

I read the DSS_REVISON, DISPC_REVISION etc registers on 3430, 3630, 4430:

3430: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 1.0, VENC rev 2
3630: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 1.0, VENC rev 2
4430: DSS rev 4.0, DISPC rev 4.0, DSI rev 3.0, RFBI rev 3.5

I haven't tried on OMAP2 yet..

Don't you think these revision numbers are enough to differentiate the
features of each IP block?

For example, if there are changes in the bit field lengths of video pipeline
Registers from omap2 to 3, we can use the dispc revision number to decide to
include the feature instead of having a cpu_is_omap24xx() change? Same for
global alpha, new color modes and so on.

Similarly, if a new video pipeline is introduced in OMAP4, we can use the DISPC
revision number to decide the number of pipelines. We could use DSS Revision numbers
to introduce changes like new interrupt lines, clocks and addition or removal of IP
blocks.

Do you mean something else by DSS HW version numbers? Would it be different/more precise
compared to the read from the DSS_REVISON register?

Thanks,

Archit



