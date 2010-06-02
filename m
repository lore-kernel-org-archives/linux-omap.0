From: Tony Lindgren <tony@atomide.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 18:01:08 +0300
Message-ID: <20100602150105.GN5980@atomide.com>
References: <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
 <20100602135709.GK5980@atomide.com>
 <20100602171427.5024be97.jhnikula@gmail.com>
 <20100602144547.GM5980@atomide.com>
 <20100602145456.GC11744@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57599 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0FBPBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 11:01:24 -0400
Content-Disposition: inline
In-Reply-To: <20100602145456.GC11744@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Koen Kooi <koen@dominion.thruhere.net>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100602 17:50]:
> 
> I have to agree modules are not supposed to change platform stuff.
> On the other hand, that could be used by EHCI/OHCI to implement port
> handoff on runtime:
> 
>  mux all usb ports to ehci, if enumeration fails, remux ports to
> ohci  and try again.

To do that all we have to do is to do is have the pin remux function
in mach-omap2/*hci.c, then pass a pointer to that function to the
*hci glue driver.

Regards,

Tony
