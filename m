From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
Date: Tue, 22 Sep 2009 09:28:54 -0700
Message-ID: <20090922162853.GC14890@atomide.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com> <notify-1253583118@atomide.com> <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60704 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZIVQ2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 12:28:55 -0400
Content-Disposition: inline
In-Reply-To: <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Blunck <jblunck@infradead.org>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net

* Jan Blunck <jblunck@infradead.org> [090922 07:59]:
> On Tue, Sep 22, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> > This patch has been applied to the linux-omap
> > by youw fwiendly patch wobot.
> >
> > Branch in linux-omap: omap-fixes
> >
> > Initial commit ID (Likely to change): 9aef1066fb5ca8506068eaab1c552ecca4c85475
> >
> > PatchWorks
> > http://patchwork.kernel.org/patch/47089/
> >
> 

Added back the original Cc's that were dropped from the linux-omap
commit message.

> Is it actually safe to do this? The framebuffer can be used directly
> after it is registered. In this case it would mean it is used before
> it is even fully initialized (set_fb_var(), set_fb_fix(), ... are
> being called).

Good point, dropping the patch.

Also, let's let Tomi Valkeinen deal with queueing up the omap fb code.
I can then merge Tomi's branck into linux-omap master branch as needed.

Regards,

Tony
