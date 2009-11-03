From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] New mux code for 34xx
Date: Tue, 3 Nov 2009 08:46:46 -0800
Message-ID: <20091103164646.GF8981@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <4AED6321.7020002@compulab.co.il>
 <20091102185649.GC6692@atomide.com>
 <f870da180911022242p2ddbd8f8j94da3fb466966d20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53808 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZKCQqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 11:46:45 -0500
Content-Disposition: inline
In-Reply-To: <f870da180911022242p2ddbd8f8j94da3fb466966d20@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Mike Rapoport <mike.rapoport@gmail.com> [091102 22:42]:
> On Mon, Nov 2, 2009 at 8:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Mike Rapoport <mike@compulab.co.il> [091101 02:29]:
> >> Hi Tony,
> >>
> >> Tony Lindgren wrote:
> >> > Hi all,
> >> >
> >> > Here's an initial version of the new mux code to play with.
> >> > Big thanks to Paul & Benoit for the 34xx mux data!
> >>
> >> I've tried your patches, they seem to work just fine on CM-T35.
> >
> > OK cool.
> >
> >> > To try out the new code, compile a kernel with CONFIG_OMAP_MUX
> >> > and CONFIG_DEBUG_FS and these patches. The series is also
> >> > availabe in the l-o git in mux branch.
> >>
> >> [ snip ]
> >>
> >> >
> >> > Comments welcome as always.
> >>
> >> There are some comments on patches 2 (Add new style pin multiplexing code for
> >> omap3) and 3 (Add new style pin multiplexing data for 34xx). No nitpicking for
> >> now, but checkpatch.pl is unhappy with the patchset :)
> >
> > OK, will run checkpatch.pl --strict on them. Thanks for the
> > comments!
> 
> While on it, can you please update board-cm-t35.c to use CUS package?

OK, will do.

FYI, currently working on converting the old style omap_cfg_reg()
calls so we can remove the old code for 34xx. It will be probably
few days before I get around posting updated patches because of
some meetings over next few days.

Regards,

Tony
