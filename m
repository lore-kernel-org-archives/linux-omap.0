From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: UART driver DMA support
Date: Fri, 18 Apr 2008 12:13:38 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742904131CC1@dlee13.ent.ti.com>
References: <75b29de30804172215v72ea18f4n61ec097b35f378bd@mail.gmail.com> <20080418164016.GE12099@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:45125 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755183AbYDRRNq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 13:13:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080418164016.GE12099@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rajeev seetharam <rseetharam@gmail.com>
Cc: linux-omap@vger.kernel.org

> * rajeev seetharam <rseetharam@gmail.com> [080417 22:16]:
> > Hi ,
> >
> > I am using the OMAP2EVM board based on OMAP2430  and using Linux -
> 2.6.23
> > Is the DMA support available as part of the UART driver.
> 
> Well there's an omap specific serial driver in works, which should
> make it easy to add DMA support eventually. No idea on when it will be
> available though, but some earlier patches are available at:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-
> April/009537.html
> 
> AFAIK nobody is working on adding DMA to it yet, so that might be
> worth doing.

The tar ball from the TI web site should have a working UART library
which is DMA enabled.

You likely can use that code with a little effort or can port the guts
into what Tony was pointing out.

Regards,
Richard W.
