From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Date: Wed, 22 Dec 2010 10:57:17 -0800
Message-ID: <20101222185717.GA7771@atomide.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
 <20101221202133.GJ5829@atomide.com>
 <20101222085638.226a1269.jhnikula@gmail.com>
 <1293011118.6829.0.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38682 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab0LVS5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 13:57:21 -0500
Content-Disposition: inline
In-Reply-To: <1293011118.6829.0.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [101222 01:45]:
> On Wed, 2010-12-22 at 08:56 +0200, ext Jarkko Nikula wrote:
> > On Tue, 21 Dec 2010 12:21:33 -0800
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > * Jarkko Nikula <jhnikula@gmail.com> [101221 09:25]:
> > > > Hi
> > > > 
> > > > Commit 60d24ee "Added video data to support tvout on rx51" broke the
> > > > framebuffer on N900. Here are two patches where 1st one does a little cleanup
> > > > to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
> > > > are working.
> > > 
> > > Tomi, do you want to pick these three DSS/video related patches from Jarkko?
> > > 
> > > If so:
> > > 
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > else please ack and let me know if you want me to take them.
> > > 
> > I think these should go to linux-omap since the breakage is there and
> > anyway touch only the rx51 board files.
> 
> I agree, I don't have that commit in my tree. So Tony, please take the
> patches.
> 
> For both patches:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

OK, thanks will queue.

Tony
