From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH 15/20] Use platform device to get DSS base addr
Date: Tue, 31 Aug 2010 18:25:31 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA765@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com>
 <1282579089-10487-12-git-send-email-svadivu@ti.com>
 <1282579089-10487-13-git-send-email-svadivu@ti.com>
 <1282579089-10487-14-git-send-email-svadivu@ti.com>
 <1282579089-10487-15-git-send-email-svadivu@ti.com>
 <1282579089-10487-16-git-send-email-svadivu@ti.com> <4C72EB70.7000606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44194 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757337Ab0HaM6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 08:58:04 -0400
In-Reply-To: <4C72EB70.7000606@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Tuesday, August 24, 2010 3:13 AM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com; Hilman, Kevin
> Subject: Re: [PATCH 15/20] Use platform device to get DSS base addr
> 
> On 8/23/2010 5:58 PM, Guruswamy, Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >
[...]
> > +	struct resource *dss_mem;
> >
> > -	dss.base = ioremap(DSS_BASE, DSS_SZ_REGS);
> > +	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
> 
> platform_get_resource can fail, so you have to check the 
> returned value.
> Please note that this comment applies as well to all the 
> other patches 
> from 16 to 19.
> 
[Senthil]  Yes, I would incorporate in my next version.
> Benoit
> 
> > +	dss.base = ioremap(dss_mem->start, resource_size(dss_mem));
> >   	if (!dss.base) {
> >   		DSSERR("can't ioremap DSS\n");
> >   		r = -ENOMEM;
> 
> 