From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/17] Massive OMAP730/OMAP850 cleanup
Date: Wed, 14 Oct 2009 17:19:53 -0700
Message-ID: <20091015001953.GE14531@atomide.com>
References: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com> <20091014211206.GL12700@atomide.com> <3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58084 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758427AbZJOAUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 20:20:39 -0400
Content-Disposition: inline
In-Reply-To: <3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

* Alistair Buxton <a.j.buxton@gmail.com> [091014 17:13]:
> 2009/10/14 Tony Lindgren <tony@atomide.com>:
> > * Alistair Buxton <a.j.buxton@gmail.com> [091014 13:03]:
> >> Reposting the full series for review. Assuming this is all OK would it
> >> be a good idea to merge the config variables into a single
> >> CONFIG_ARCH_OMAP7XX? There doesn't seem to be any reason to have both.
> >> Original description follows.
> >
> > Yeah, those should be merged too. Let's do that as a separate patch.
> 
> On a related note, the omap850.h and omap730.h should go away too,
> when everyone is happy with the new omap7xx.h. Perhaps we should add a
> #warning to them so people know they will be removed at some point?

OK, let's do that, but let's first get all the recently posted patches
merged into the omap for-next branch. After that we can have some
static commit on which to create more patches.

Regards,

Tony
