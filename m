From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2 patch series
Date: Thu, 05 Aug 2010 11:09:42 +0300
Message-ID: <1280995782.3436.205.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22168 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0HEIJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 04:09:59 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-08-05 at 09:06 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> > 
> > Also, we should think how to reduce if (cpu_is_omap44xx()) 
> > lines. There should be some kind of DSS capability list 
> > somewhere, which would tell the features available. I haven't 
> > thought this more, but it'd be very nice if we could use the 
> > DSS HW version number to decide what features there are.
> > 
> > However, TI answered that information about DSS HW version 
> > numbers is not available, and thus cannot be used =(. Perhaps 
> > you could try to dig out some information from inside TI?
> > 
> 
> I read the DSS_REVISON, DISPC_REVISION etc registers on 3430, 3630, 4430:
> 
> 3430: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 1.0, VENC rev 2
> 3630: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 1.0, VENC rev 2
> 4430: DSS rev 4.0, DISPC rev 4.0, DSI rev 3.0, RFBI rev 3.5
> 
> I haven't tried on OMAP2 yet..
> 
> Don't you think these revision numbers are enough to differentiate the
> features of each IP block?

Perhaps. The problem is, I don't know what the version numbers mean, ie.
when are they changed, what are the changes. I would hope you that you
could find some internal info inside TI that would explain the
differences =).

We can of course reverse engineer the version numbers, and hope that we
decipher them correctly. For OMAP3430/3630/4430 the differences look
clear.

But how about OMAP rev changes? For example, at some 3430 revision the
bitfield lengths of video timing registers were changed. Does it show on
DSS/DISPC version numbers? I don't think I have boards with those revs,
so I can't check.

 Tomi


