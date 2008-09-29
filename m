From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] watchdog: fix typo in omap_wdt.c
Date: Mon, 29 Sep 2008 14:59:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC98B5@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC959A@dbde02.ent.ti.com>
 <20080926175237.GD9890@frodo>
 <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC95BB@dbde02.ent.ti.com>
 <20080926192746.GG9890@frodo>
 <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC9707@dbde02.ent.ti
 <20080929092528.GE30555@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbYI2J3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:29:46 -0400
In-Reply-To: <20080929092528.GE30555@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> On Mon, Sep 29, 2008 at 09:56:06AM +0530, Gadiyar, Anand wrote:
> > <snip> 
> > 
> > > > > Those patches weren't applied to linux-omap yet, so this change should
> > > > > be melded into the patch that introduced it. It's better to resend that
> > > > > patch then to create a messed up bisect line.
> > > > > 
> > > > > -- 
> > > > > balbi
> > > > 
> > > > Of course they were merged. I saw this warning when I compiled linux-omap,
> > > > when sending in that pin-muxing patch.
> > > 
> > > You're right, at first look I thought this was for omap_hdq.c :-p
> > > 
> > > Anyways, this patch should go also to Wim. Please send a copy of this
> > > patch to him so he can apply to his tree as well, btw, here's 
> > > his mail:
> > > 
> > > Wim Van Sebroeck <wim@iguana.be>
> > > 
> > 
> > Done. I'm guessing I don't need to CC linux-omap on that. 
> Let me know if
> > I should have. I've sent it to Wim, with a CC to you (Felipe).
> 
> I think you can send it to l-o so we avoid these kinds of bugs. Tony,
> what do you say ?
> 

I meant, I've already sent it to l-o, and I sent the same patch out to
Wim... When I sent it out the second time, I thought I need not CC l-o
on that second mail. Now I'm thinking I should have. So never mind.

- Anand
