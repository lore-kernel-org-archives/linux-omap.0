From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATCH] BQ27000/BQ27200 battery monitoring driver for OMAP34xx
Date: Tue, 29 Apr 2008 14:20:55 +0530
Message-ID: <005f01c8a9d6$250aa810$b28818ac@ent.ti.com>
References: <004201c8a6b7$283188a0$018918ac@ent.ti.com> <8ce339cf29cd530453f35b8fe91240a8@felipebalbi.com> <003501c8a924$db298fb0$018918ac@ent.ti.com> <c8e665543c8e8ca9a6717408897e69ac@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:51676 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbYD2IvL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2008 04:51:11 -0400
In-Reply-To: <c8e665543c8e8ca9a6717408897e69ac@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Felipe Balbi' <me@felipebalbi.com>
Cc: 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Monday, April 28, 2008 5:17 PM
> To: Madhusudhan Chikkature Rajashekar
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: RE: [RFC/PATCH] BQ27000/BQ27200 battery monitoring 
> driver for OMAP34xx
> 
> 
> 
> On Mon, 28 Apr 2008 17:11:51 +0530, "Madhusudhan Chikkature 
> Rajashekar"
> <madhu.cr@ti.com> wrote:
> > Hi Felipe,
> > 
> > Thanks for the comments. I will fix them and resend the patch.
> > 
> > Please note my view on the below point.
> > 
> >> > -	pdev = platform_device_alloc("omap-bq2700-battery", id);
> >> > +	pdev = platform_device_alloc("bq27000-bat", id);
> >>
> >> do you really need to change the name here?
> >> It seems that this change doesn't belong to this patch.
> > 
> > I will make this as a separate patch.As BQ27000 chip is not omap
> specific,
> > I guess the above name is not correct. Hence I intend to make that
> change.
> 
> Ok, works for me :-)
> 
> I guess bq2700-battery is ok, just remove omap- from the 
> previous name??
Yes. I will correct the name and resend the patch. I will send this one as a separate patch and followed by it will
be the battery driver patch.

> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
> 

