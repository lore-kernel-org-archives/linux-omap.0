From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
Date: Tue, 22 Sep 2009 11:57:04 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B4E@dlee02.ent.ti.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
 <notify-1253583118@atomide.com>
 <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>,<20090922162853.GC14890@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756594AbZIVRBG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:01:06 -0400
In-Reply-To: <20090922162853.GC14890@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jan Blunck <jblunck@infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

From: Tony Lindgren [tony@atomide.com]
Sent: Tuesday, September 22, 2009 11:28 AM
> * Jan Blunck <jblunck@infradead.org> [090922 07:59]:
> > On Tue, Sep 22, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > This patch has been applied to the linux-omap
> > > by youw fwiendly patch wobot.
> > >
> > > Branch in linux-omap: omap-fixes
> > >
> > > Initial commit ID (Likely to change): 9aef1066fb5ca8506068eaab1c552ecca4c85475
> > >
> > > PatchWorks
> > > http://patchwork.kernel.org/patch/47089/
> > >
> >
> 
> Added back the original Cc's that were dropped from the linux-omap
> commit message.
> 
> > Is it actually safe to do this? The framebuffer can be used directly
> > after it is registered. In this case it would mean it is used before
> > it is even fully initialized (set_fb_var(), set_fb_fix(), ... are
> > being called).
> 
> Good point, dropping the patch.

Hmm, ok. I guess i'll rework this patch considering that..

I ran some framebuffer tests with this patch applied, and they worked fine for me.

The only thing is that i didn't saw Tux on bootup...

Actually, nobody ever gave this kind of feedback, which was the initial idea.

Just people worried about booting properly.

Anyways, thanks for your time! I appreciate it.

Regards,
Sergio
> 
> Also, let's let Tomi Valkeinen deal with queueing up the omap fb code.
> I can then merge Tomi's branck into linux-omap master branch as needed.
> 
> Regards,
> 
> Tony
> 
> 