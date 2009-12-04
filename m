From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix include problem. Signed-off-by: Marek Belisko
 <marek.belisko@gmail.com>
Date: Fri, 4 Dec 2009 15:00:12 -0800
Message-ID: <20091204230012.GN24013@atomide.com>
References: <e7c6a05e0912030528k1f9c9493y11d55812a054b030@mail.gmail.com>
 <6cb013310912030729k2b42e2edqfe7a63f9c046bb89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60074 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378AbZLDXAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 18:00:09 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310912030729k2b42e2edqfe7a63f9c046bb89@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091203 07:28]:
> On Thu, Dec 3, 2009 at 5:28 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
> >
> > Hi,
> >
> > when make htcherald_defconfig on current linux-omap tree
> > (82f1d8f22f2c65e70206e40a6f17688bf64a892c) compilation fails
> > in drivers/video/omap/lcd_htcherald.c.
> >
> > Following patch fixed this problem.
> 
> Marek and I talked on IRC about this, and it turns out this is true on
> the linux-omap master branch, but for-next compiles without issue,
> possibly due to the header changes not having been done on the master
> branch yet.

Looks like Tomi's DSS2 moved this around. The DSS2 code is merged
into linux-omap master branch, but is not in omap for-next branch.

I've applied this to linux-omap master branch for now. 

Tomi, can you please add this to your fixes queue?

The patch in question is at:

http://patchwork.kernel.org/patch/64520/

Regards,

Tony
