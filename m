From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] Fix include problem. Signed-off-by: Marek Belisko
 <marek.belisko@gmail.com>
Date: Mon, 07 Dec 2009 11:11:21 +0200
Message-ID: <1260177081.2342.57.camel@tubuntu.research.nokia.com>
References: <e7c6a05e0912030528k1f9c9493y11d55812a054b030@mail.gmail.com>
	 <6cb013310912030729k2b42e2edqfe7a63f9c046bb89@mail.gmail.com>
	 <20091204230012.GN24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57589 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144AbZLGJLU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 04:11:20 -0500
In-Reply-To: <20091204230012.GN24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, 2009-12-05 at 00:00 +0100, ext Tony Lindgren wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [091203 07:28]:
> > On Thu, Dec 3, 2009 at 5:28 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > when make htcherald_defconfig on current linux-omap tree
> > > (82f1d8f22f2c65e70206e40a6f17688bf64a892c) compilation fails
> > > in drivers/video/omap/lcd_htcherald.c.
> > >
> > > Following patch fixed this problem.
> > 
> > Marek and I talked on IRC about this, and it turns out this is true on
> > the linux-omap master branch, but for-next compiles without issue,
> > possibly due to the header changes not having been done on the master
> > branch yet.
> 
> Looks like Tomi's DSS2 moved this around. The DSS2 code is merged
> into linux-omap master branch, but is not in omap for-next branch.
> 
> I've applied this to linux-omap master branch for now. 
> 
> Tomi, can you please add this to your fixes queue?
> 
> The patch in question is at:
> 
> http://patchwork.kernel.org/patch/64520/

Yes, I'll take it. And I actually anyway need to re-check before sending
pull request that all includes are correct, as there may have been new
LCDs/board files.

 Tomi


