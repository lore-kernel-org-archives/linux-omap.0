From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: RE: Help needed USB hub disconnected at resume
Date: Tue, 4 Mar 2014 23:01:16 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE0AA85FFF0@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
 <53146225.8040403@ti.com> <531472B3.1060104@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E7F2@MARCM-SBS2011.marcmltd.local>
 <5315761D.8080103@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local>
 <20140304224427.GA31462@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout05.bt.lon5.cpcloud.co.uk ([65.20.0.125]:8905 "EHLO
	smtpout05.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754614AbaCDXBv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 18:01:51 -0500
In-Reply-To: <20140304224427.GA31462@saruman.home>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'balbi@ti.com'" <balbi@ti.com>
Cc: 'Igor Grinberg' <grinberg@compulab.co.il>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: 04 March 2014 22:44
> To: Marc Murphy
> Cc: 'Igor Grinberg'; Roger Quadros; linux-omap@vger.kernel.org
> Subject: Re: Help needed USB hub disconnected at resume
> 
> Hi,
> 
> On Tue, Mar 04, 2014 at 10:34:56PM +0000, Marc Murphy wrote:
> > static __init void tam3517_ehci_init(void) {
> >     /* Configure GPIO for EHCI port */
> >     omap_mux_init_gpio(TAM3517_EHCI_RESET, OMAP_PIN_OUTPUT);
> >
> >     gpio_request(TAM3517_EHCI_RESET, "USB_RESET");
> >     gpio_direction_output(TAM3517_EHCI_RESET, 1);
> >     gpio_export(TAM3517_EHCI_RESET, 0);
> 
> why are you exporting this gpio ?

I thought I needed to so that the Phy is reset.  I will try with it disabled.

Regards
Marc

> 
> --
> balbi
