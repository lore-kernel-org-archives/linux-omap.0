From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] watchdog: fix typo in omap_wdt.c
Date: Mon, 29 Sep 2008 12:25:29 +0300
Message-ID: <20080929092528.GE30555@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC959A@dbde02.ent.ti.com> <20080926175237.GD9890@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC95BB@dbde02.ent.ti.com> <20080926192746.GG9890@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC9707@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57298 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYI2JZi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:25:38 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC9707@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, tony@atomide.com

On Mon, Sep 29, 2008 at 09:56:06AM +0530, Gadiyar, Anand wrote:
> <snip> 
> 
> > > > Those patches weren't applied to linux-omap yet, so this change should
> > > > be melded into the patch that introduced it. It's better to resend that
> > > > patch then to create a messed up bisect line.
> > > > 
> > > > -- 
> > > > balbi
> > > 
> > > Of course they were merged. I saw this warning when I compiled linux-omap,
> > > when sending in that pin-muxing patch.
> > 
> > You're right, at first look I thought this was for omap_hdq.c :-p
> > 
> > Anyways, this patch should go also to Wim. Please send a copy of this
> > patch to him so he can apply to his tree as well, btw, here's 
> > his mail:
> > 
> > Wim Van Sebroeck <wim@iguana.be>
> > 
> 
> Done. I'm guessing I don't need to CC linux-omap on that. Let me know if
> I should have. I've sent it to Wim, with a CC to you (Felipe).

I think you can send it to l-o so we avoid these kinds of bugs. Tony,
what do you say ?

-- 
balbi
