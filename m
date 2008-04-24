From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/5] Updates on mcbsp driver
Date: Fri, 25 Apr 2008 00:13:03 +0300
Message-ID: <1209071583.30582.186.camel@mort>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
	 <20080424211019.GC8794@kedavra.cpe.vivax.com.br>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61739 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbYDXVSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:18:34 -0400
In-Reply-To: <20080424211019.GC8794@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>, ext Chandra shekhar <x0044955@ti.com>

On Fri, 2008-04-25 at 00:10 +0300, ext Felipe Balbi wrote:
> On Thu, Apr 24, 2008 at 11:54:20AM -0400, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> > 
> > This patch series updates mcbsp driver by transforming it into
> > a platform driver. This is a very initial implementation.
> > Basically it moves machine specific code to their correct place
> > and creates the platform driver necessary structures.
> > 
> > It must be working for previous boards. For omap34xx it should
> > work for mcbsp 1 and 2.
> > 
> > In order to do not break other places, I tryied to do not change
> > previous API. But future improvements are needed.
> > 
> > Clock definitions for  mcbsp 1 and 2 were also modified to add
> > correct support for omap34xx.
> > 
> > Comments are wellcome.
> 
> checkpatch doesn't complain, although i didn't really test it.

However I'd prefer see this patchset being merged with

[RFC/PATCH  1/1] McBSP support for 2430/34XX

and only later considered for integration.

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
