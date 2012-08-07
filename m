From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP5: Add minimal OMAP5 SOC support for 3.6
Date: Tue, 7 Aug 2012 00:00:57 -0700
Message-ID: <20120807070056.GI11011@atomide.com>
References: <1341846143-11137-1-git-send-email-santosh.shilimkar@ti.com>
 <20120710083354.GM1122@atomide.com>
 <CAMQu2gwNeYUm7iL+30wwoHCNGZ3dXF2k+w-PE=tw-pMSO9F3NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31276 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2HGHA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:00:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwNeYUm7iL+30wwoHCNGZ3dXF2k+w-PE=tw-pMSO9F3NQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120726 00:27]:
> On Tue, Jul 10, 2012 at 10:33 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 08:07]:
> >> Tony,
> >>
> >> Please pull below OMAP5 SOC minimal support. It is generated against the
> >> cleanup-part2 branch of yours. As you suggested, I have dropped CK_54XX
> >> flag changes to avoid conflicts.
> >
> > OK seems to merge fine now, pulled into devel-omap5.
> >
> Now OMAP5 support appearing in mainline. In case you would like
> to boot mainline on your OMAP5 board, you need to merge a
> OMAP5 SOC hwmod/clock data which is out of tree. I have
> put that on a branch and same is available [1]. Please note
> that the only DT boot supported.

Nice to see it being a small set :) Have these changes been
posted to the mailing lists for review?

Regards,

Tony

 
> [1] git://github.com/SantoshShilimkar/linux.git out-of-tree/omap5-data
