From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP totally fucked?
Date: Tue, 6 Mar 2012 15:41:28 +0000
Message-ID: <201203061541.28672.arnd@arndb.de>
References: <20120303180428.GA10293@atomide.com> <4F56261A.3090002@ti.com> <20120306150826.GA15392@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58545 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab2CFPlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:41:31 -0500
In-Reply-To: <20120306150826.GA15392@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tuesday 06 March 2012, Russell King - ARM Linux wrote:
> On Tue, Mar 06, 2012 at 03:58:34PM +0100, Cousson, Benoit wrote:
> > We added that to avoid cluttering the drivers with a bunch of #ifdef  
> > CONFIG_OF as proposed by Grant and Rob... and most drivers adaptation  
> > were done having that assumption.
> > So if we removed that today, it will be like removing the IRQDOMAIN  
> > define during the last merge window, it will break when the drivers DT  
> > adaptation will be pulled.
> 
> But aren't the OF interfaces stubbed out in linux/of.h when DT support
> is disabled?
> 
> Or are you saying that we're heading for a situation where existing
> drivers stop working when OF isn't enabled?

Most of the interfaces are stubbed out, but not all. I guess it would
be nice to add stubs for the remaining ones, too. More consistent
as well.

	Arnd
