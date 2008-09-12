From: David Brownell <david-b@pacbell.net>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 14:15:09 -0700
Message-ID: <200809121415.09398.david-b@pacbell.net>
References: <20080912121024.GG759@gandalf.research.nokia.com> <200809121330.02192.david-b@pacbell.net> <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:25656 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755664AbYIMAmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 20:42:15 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Friday 12 September 2008, Gadiyar, Anand wrote:
> 
> > Sounds like code that can live in mach-omap2 and be called
> > when the drivers start or stop.
> 
> 
> Yup. Then a lot of the code in that ehci-omap.c file would need
> to be moved there to avoid duplicating code. Will do that when
> I add the OHCI bus-glue. 

OK.  To clarify:  it could also be argued that such stuff
should be in some bit of drivers/usb/host code ... but from
my previous exposure to OMAP USB stuff, I assume this kind
of code will be a lot more SOC-sensitive (revisions etc)
than we like to see in the USB tree.  The setup bits (how
to mux pins and configure the transceiver) clearly belongs
in mach-omap2/usb-SOMETHING.c and if anything clearly doesn't
belong there, it can move.
 


