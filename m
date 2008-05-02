From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: [PATCH 1/7] ARM: OMAP: Add basic board support for OMAP LDP.
Date: Fri, 2 May 2008 06:44:16 -0500
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D03A4495D@dlee13.ent.ti.com>
References: <6dfcaa3c0e34f764879c9ec7090e5cea@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:54927 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757017AbYEBLo1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 07:44:27 -0400
Content-class: urn:content-classes:message
In-Reply-To: <6dfcaa3c0e34f764879c9ec7090e5cea@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Filipe,

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
>
[. . .]

> > +	ads7846_dev_init();
> > +	omap_serial_init();
> > +	hsmmc_init();
> 
> no usb?
> How about usb_musb() here?
> 
> Could you try that ?
> 
> you'll need to include <asm/arch/usb-musb.h>
> 
> if it works, just append to this patch ;-)

Last time I tried, it didn't work straight off the bat. I'll send it in
another patch once it works..

Regards,
Nishant
