From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: USB confusion
Date: Wed, 2 Sep 2009 09:08:25 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4ADBD@dbde02.ent.ti.com>
References: <4A9D0898.4000400@mlbassoc.com> <4A9D117D.2070105@mlbassoc.com>
 <20090901162802.GB28157@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34285 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625AbZIBDik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 23:38:40 -0400
In-Reply-To: <20090901162802.GB28157@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Tuesday, September 01, 2009 9:58 PM
> To: ext Gary Thomas
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: USB confusion
> 
> On Tue, Sep 01, 2009 at 02:20:13PM +0200, ext Gary Thomas wrote:
> > Following up on this, I made sure that CONFIG_USB_EHCI_HCD was defined.
> >
> > Now I see these messages:
> >    ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >    Clock usbhost_48m_fck didn't enable in 100000 tries
> >    ehci-omap: probe of ehci-omap.0 failed with error -22
> >
> > Any ideas what else I might be missing?
> 
> check what happens with that clock. Why is that timing out ?
> 
> I believe that message comes from clk fw. Maybe Paul could
> give us some hint. Paul ?

I faced similar issue and it got solved with increased timeout value.
Patch is already submitted for this:

[PATCH 5/9] ehci: increase timeout to fix ehci failure
http://marc.info/?l=linux-omap&m=124956053919660&w=2

-Ajay
> 
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

