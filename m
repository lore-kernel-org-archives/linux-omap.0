From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Question on OTG transceivers
Date: Fri, 26 Mar 2010 16:15:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032221B333@dbde02.ent.ti.com>
References: <4BA14B06.8050202@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03220FB2A2@dbde02.ent.ti.com>
 <4BA79588.4040409@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab0CZKpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 06:45:24 -0400
In-Reply-To: <4BA79588.4040409@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Bill Gatliff wrote:
> Gadiyar, Anand wrote:
> > Actually, the way the ehci-omap driver is currently written, it assumes
> > the transceiver is present and available - you don't need a separate
> > driver to access it.
> >
> > For that matter, the same probably holds for the OTG driver as well - you
> > really don't need a driver for transparent transceivers like the SMSC332x.
> >   
> 
> But I get an OOPS and the system halts when I don't have a transceiver
> driver...
> 

Care to post a bootlog and your .config file? Maybe it's just a simple CONFIG option that
you are missing?
