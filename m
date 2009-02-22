From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Sun, 22 Feb 2009 19:11:01 +0200
Message-ID: <20090222171100.GC2135@frodo>
References: <20090220125109.GL16942@scadufax.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02F565683F@dbde02.ent.ti.com> <94a0d4530902220551x62dfeb8w248528922afbcd8c@mail.gmail.com> <57969b5c0902220759n55798b71y64a5b17b7bdc7f98@mail.gmail.com> <20090222165056.GA2135@frodo> <57969b5c0902220904q2c8fbbaft8d9f8ed4b91ba19f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56797 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbZBVRLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 12:11:10 -0500
Content-Disposition: inline
In-Reply-To: <57969b5c0902220904q2c8fbbaft8d9f8ed4b91ba19f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@gmail.com>
Cc: me@felipebalbi.com, Felipe Contreras <felipe.contreras@gmail.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Sun, Feb 22, 2009 at 10:34:03PM +0530, Anand Gadiyar wrote:
> I must have missed the patchset, or I wasn't on the CC list. Anyway,
> let's end this here and figure out how to get the driver functional,
> cleaned-up and in mainline. I'm willing to help out in any way I can.
> 
> I've got hardware if you would like to test something. I've got a
> decent bit of knowledge on the controller hardware, (plus tons of
> knowledge on it's failings ;) )
> 
> Plus partially done work...
> 
> Let me know how you would like to go about this.

cool, mailed you a tarball with my preliminary patches. This should get
ehci better for the eyes and hopefully I got rid of all infinite loops.
Later I wanna work on getting AUTOIDLE re-enabled and get this driver
reach off mode.

> P.S. I'm out of office taking my first break in months. I can only
> start once I get back next week.

have fun ;-)

-- 
balbi
