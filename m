From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: TWL4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 19:42:36 +0200
Message-ID: <20081120174236.GQ7476@gandalf.research.nokia.com>
References: <ef0d8a250811200202o5852dabct8c5b135b86141f67@mail.gmail.com> <31e679430811200255w33198a1r810f516b7326f414@mail.gmail.com> <20081120173206.GL4927@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20837 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbYKTRnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 12:43:15 -0500
Content-Disposition: inline
In-Reply-To: <20081120173206.GL4927@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>, naveen krishna ch <naveenkrishna.ch@gmail.com>, linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

On Thu, Nov 20, 2008 at 09:32:07AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <felipebalbi@users.sourceforge.net> [081120 02:55]:
> > This list has been moved to linux-omap@vger.kernel.org
> > 
> > Please, keep that in Cc, also for ASoC development, send it also to the
> > proper alsa mailing list alsa-devel@alsa-project.org
> > 
> > Tony, I think you should apply this patch in mainline tree:
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8dae455..54c8e90 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4010,6 +4010,13 @@ P:       Alex Dubov
> >  M:     oakad@yahoo.com
> >  S:     Maintained
> > 
> > +TI OMAP
> > +P:     Tony Lindgren
> > +M:     tony@atomide.com
> > +L:     linux-omap@vger.kernel.org
> > +T:     git kernel.org:/pub/scm/linux/tmlind/linux-omap-2.6.git
> > +S:     Maintained
> > +
> >  TI OMAP MMC INTERFACE DRIVER
> >  P:     Carlos Aguiar, Anderson Briglia and Syed Khasim
> >  M:     linux-omap@vger.kernel.org
> 
> 
> Yeah sure. Let's also add maintainers for omap subsystems that have
> maintainers while we're at it.

sounds good. At least mmc is already there.

-- 
balbi
