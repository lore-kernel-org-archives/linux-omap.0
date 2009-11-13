From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Fri, 13 Nov 2009 11:56:08 +0200
Message-ID: <1258106168.20378.119.camel@tubuntu.research.nokia.com>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1257856848.21596.753.camel@localhost>
	 <1257929140.20378.51.camel@tubuntu.research.nokia.com>
	 <1257932641.20378.77.camel@tubuntu.research.nokia.com>
	 <20091111184208.GC24837@atomide.com>
	 <20091112161028.427787d9.sfr@canb.auug.org.au>
	 <20091112181457.GX24837@atomide.com>
	 <20091113074811.ee61948f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47520 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbZKMJ4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 04:56:37 -0500
In-Reply-To: <20091113074811.ee61948f.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>

Hi,

On Thu, 2009-11-12 at 21:48 +0100, ext Stephen Rothwell wrote:
> Hi Tony, Tomi,
> 
> On Thu, 12 Nov 2009 10:14:57 -0800 Tony Lindgren <tony@atomide.com> wrote:
> >
> > OK. The only dependency is the the move of the headers.
> > 
> > Tomi, can you please rebase your patches on top of the "7xx-iosplit-plat-merge"
> > branch in linux-omap tree? This is commit 8171d88089ad63fc442b2bf32af7c18653adc5cb,
> > and it should stay static.
> 
> OK, *if* you (Tony) guarantee that the base is stable (i.e. never
> rebased, but may have things added to it) and in linux-next, then I can
> take the DSS2 stuff separately if you want me to.
> 
> Tomi, you can, of course, merge that branch into your tree instead of
> rebasing on top of it (which ever is easiest).

I rebased DSS2 on top of 8171d88089ad63fc442b2bf32af7c18653adc5cb. It
can be found from git://gitorious.org/linux-omap-dss2/linux.git for-next
branch.

I'm ok with Tony pulling DSS2 to his next-branch, or Stephen pulling
directly, which ever works easier for you.

 Tomi


