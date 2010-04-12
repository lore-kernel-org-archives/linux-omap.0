From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Mon, 12 Apr 2010 15:02:29 +0300
Message-ID: <1271073749.2690.52.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
	 <1270129320.2704.114.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044E053D83@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25870 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0DLMCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 08:02:39 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E053D83@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-04-12 at 13:47 +0200, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Thursday, April 01, 2010 7:12 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > 
> > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > In case of 720P with 90/270 degree rotation, the system reports
> > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able to
> > fill
> > > the FIFO as per requirement.
> > >
> > > In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> > >
> > > "To improve the performance on 90 degree rotation, split the data access
> > on
> > > write side and not read side."
> > >
> > > That means, read should always happen on 0 degree and write should go to
> > > respective rotation view.
> > 
> > I haven't had time to look at this patch yet. I'll try to do it next
> > week.
> [Hiremath, Vaibhav] Tomi,
> 
> Have you had a chance to look at this patch/issue?

Sorry, no I haven't. It's on my list. But did you consider my
explanation? Does your implementation support changing the rotation
dynamically?

 Tomi


