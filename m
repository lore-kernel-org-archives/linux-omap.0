From: Tony Lindgren <tony@atomide.com>
Subject: Re: [TRIVIAL PATCH] Fix compilation of
	arch/arm/mach-omap1/mailbox.c
Date: Mon, 15 Jun 2009 02:01:41 -0700
Message-ID: <20090615090141.GI4474@atomide.com>
References: <20090612235059.GJ6704@earth.li> <20090615.090229.214241346.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50988 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZFOJBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 05:01:41 -0400
Content-Disposition: inline
In-Reply-To: <20090615.090229.214241346.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: noodles@earth.li, linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090614 23:02]:
> From: ext Jonathan McDowell <noodles@earth.li>
> Subject: [TRIVIAL PATCH] Fix compilation of arch/arm/mach-omap1/mailbox.c
> Date: Sat, 13 Jun 2009 01:50:59 +0200
> 
> > This fixes the positioning of " in MODULE_AUTHOR, which is currently
> > causing a build failure on latest git with CONFIG_OMAP_MBOX_FWK=m; the
> > original breakage appears to date from the end of last year in
> > a5abbbe52b7e89a7633319c5417bd4331f7ac8ed
> > 
> > Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> Thank you. Tony, please get this in.

Will add to omap-fixes, can you please reply with your official *-by: ack?

Tony

> 
> > 
> > -----
> > diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> > index 0af4d6c..6810b4a 100644
> > --- a/arch/arm/mach-omap1/mailbox.c
> > +++ b/arch/arm/mach-omap1/mailbox.c
> > @@ -203,5 +203,5 @@ module_exit(omap1_mbox_exit);
> >  
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
> > -MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
> > +MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
> >  MODULE_ALIAS("platform:omap1-mailbox");
> > -----
> > 
> > J.
> > 
> > -- 
> > ] http://www.earth.li/~noodles/ []     "Making the impossible very     [
> > ]  PGP/GPG Key @ the.earth.li   []     difficult" -- The OpenGALEN     [
> > ] via keyserver, web or email.  []              website.               [
> > ] RSA: 4096/2DA8B985            []                                     [
