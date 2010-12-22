From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Date: Wed, 22 Dec 2010 11:45:18 +0200
Message-ID: <1293011118.6829.0.camel@tubuntu>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
	 <20101221202133.GJ5829@atomide.com>
	 <20101222085638.226a1269.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:33238 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab0LVJp3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 04:45:29 -0500
In-Reply-To: <20101222085638.226a1269.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2010-12-22 at 08:56 +0200, ext Jarkko Nikula wrote:
> On Tue, 21 Dec 2010 12:21:33 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Jarkko Nikula <jhnikula@gmail.com> [101221 09:25]:
> > > Hi
> > > 
> > > Commit 60d24ee "Added video data to support tvout on rx51" broke the
> > > framebuffer on N900. Here are two patches where 1st one does a little cleanup
> > > to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
> > > are working.
> > 
> > Tomi, do you want to pick these three DSS/video related patches from Jarkko?
> > 
> > If so:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > else please ack and let me know if you want me to take them.
> > 
> I think these should go to linux-omap since the breakage is there and
> anyway touch only the rx51 board files.

I agree, I don't have that commit in my tree. So Tony, please take the
patches.

For both patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tomi


