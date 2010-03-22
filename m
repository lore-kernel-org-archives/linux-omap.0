From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Question on OTG transceivers
Date: Mon, 22 Mar 2010 18:45:48 +0200
Message-ID: <20100322164547.GA3912@gandalf>
References: <4BA14B06.8050202@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03220FB2A2@dbde02.ent.ti.com>
 <4BA79588.4040409@billgatliff.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38359 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab0CVQpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 12:45:20 -0400
Content-Disposition: inline
In-Reply-To: <4BA79588.4040409@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 22, 2010 at 11:06:32AM -0500, Bill Gatliff wrote:
> Gadiyar, Anand wrote:
> >  
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

that smells like you're using the otg port.

-- 
balbi
