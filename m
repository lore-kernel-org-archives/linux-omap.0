From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
 MDK (Re: LDP support)
Date: Fri, 8 May 2009 08:57:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
References: <4A03A64D.2000809@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656AbZEHD1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 23:27:18 -0400
In-Reply-To: <4A03A64D.2000809@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Stanley.miao wrote:
> Russell King - ARM Linux wrote:
> > On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
> >   
> >> Hi, Tony,
> >>
> >> Now the kernel can't boot on LDP. The attached file is the boot log.
> >>     
> >
> > No boot log found.
> >
> >
> >   
> Sorry, forgot to attach the boot log.
> 
> It is linux-omap master branch.
> 
> Stanley.

Looks like you used the CodeSourcery 2007q3 toolchain. This had been
reported earlier. Switching to 2008q3 works.

- Anand


