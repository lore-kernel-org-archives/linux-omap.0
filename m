From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix section mismatch warning.
Date: Thu, 20 Nov 2008 16:14:44 -0800
Message-ID: <200811201614.45094.david-b@pacbell.net>
References: <1227102749-19536-1-git-send-email-premi@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com> <20081120125529.GE7476@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:37372 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754893AbYKUAOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 19:14:47 -0500
In-Reply-To: <20081120125529.GE7476@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "ext Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 20 November 2008, Felipe Balbi wrote:
> > > > -static struct twl4030_platform_data omap3evm_twldata = {
> > > > +static struct twl4030_platform_data __initdata omap3evm_twldata = {
> > > 
> > > ... and that's incorrect in any case, since that data is used 
> > > by probe() code that's doesn't sit in an init section.
> 
> __initdata_or_module would do the trick for static and dynamically
> linked modules.

Not in this case.  Recall there are several drivers who
would all need to be using non-hotpluggable structures ...
but since the root of their tree must be hotpluggable,
they can't work that way.


> When building it statically, we'd get a bit of 
> shrinkage, right ?

Can't work that way.
 


