From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Mon, 18 Feb 2013 08:08:09 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED22A16@DBDE01.ent.ti.com>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
 <alpine.LFD.2.03.1302160035240.6419@syhkavp.arg> <511F1DB4.8030400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab3BRIIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 03:08:25 -0500
In-Reply-To: <511F1DB4.8030400@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

On Sat, Feb 16, 2013 at 11:18:36, Shilimkar, Santosh wrote:
[...]
> >>
> >> For the duplicate ioremapping, I don't think there's any need to
> >> do it if we get things right.
> >
> > Note that if the ioremap matches a static map area there is no cost to
> > ioremap it multiple times.
> >
> >
> Thats true though now on OMAP we removed most of the static mappings.
> The main issue is waste of IO space because, we end up mapping same
> area two times for all the OMAP drivers. This can be optimized with
> a arch ioremap caller hook but as discussed here, its nice to have
> rather than something important.
> 

Err.. I was looking at the iotable_init for OMAPx in mainline and it looks
like most (all?) of the peripherals are already covered in the static mappings?

Regards,
Vaibhav
