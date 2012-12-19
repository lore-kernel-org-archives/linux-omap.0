From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] OMAP GPIO - don't wake from suspend unless requested.
Date: Wed, 19 Dec 2012 22:20:28 +0000
Message-ID: <20121219222028.6BA4A3E0AD6@localhost>
References: <20120825214459.7333a376@notabene.brown> <CAMQu2gz0-U4GxEpZFfmJec+0FRs7ugy8EYS3HyYhb1jwbMBjug@mail.gmail.com> <20120827085312.75957354@notabene.brown> <CAMQu2gwH0O+NHV7H2aF375qmv0=TKb6RweOLohTHtB4UhQ-1gQ@mail.gmail.com> <CAMQu2gw2b8HHDPuSRuHXVYn3sJ5BYi_PuOT=snpa3zD5ert=QQ@mail.gmail.com> <20120906130510.32b0b877@notabene.brown> <CAMQu2gxGNJ+NW_rcRiXNE=OMTq8Hb81_1hDZnNen6mjc2cf6BQ@mail.gmail.com> <20120906170245.10e97bdd@notabene.brown> <87627pldkj.fsf@deeprootsystems.com> <CAMQu2gwSCvw_4gVE-giD6MSzmRCNoNu4NoFBSao_dh9YnojfuA@mail.gmail.com> <87ipblahho.fsf@deeprootsystems.com> <20121214180553.5eb62c0c@notabene.brown>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:61868 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab2LSWUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 17:20:32 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so1186939wgb.33
        for <linux-omap@vger.kernel.org>; Wed, 19 Dec 2012 14:20:31 -0800 (PST)
In-Reply-To: <20121214180553.5eb62c0c@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>

On Fri, 14 Dec 2012 18:05:53 +1100, NeilBrown <neilb@suse.de> wrote:
> On Mon, 10 Sep 2012 10:57:07 -0700 Kevin Hilman <khilman@deeprootsystems.com>
> wrote:
> 
> 
> > OK thanks, I'll queue this up for v3.6-rc as this should qualify as a
> > regression.
> 
> I don't think this did actually get queued.  At least I'm still seeing the
> bug in 3.7 and I cannot see a patch in the git history that looks right.
> But then I don't remember what we ended up with - it was 3 months ago!!!
> 
> This is the last thing I can find in my email history - it still seems to
> apply and still seems to work.
> 
> NeilBrown

Kevin, let me know if I need to do anything here. Since you might have
it in one of you're trees, I'm not going to do anything unless I hear
from you.

g.
