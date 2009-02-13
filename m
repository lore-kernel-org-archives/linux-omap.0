From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Add support for TPS6235x support
Date: Fri, 13 Feb 2009 15:41:05 -0800
Message-ID: <200902131541.05850.david-b@pacbell.net>
References: <1233723366-13053-1-git-send-email-mani.pillai@ti.com> <200902131415.54104.david-b@pacbell.net> <20090213230201.GA6447@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:40052 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758817AbZBMXlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 18:41:09 -0500
In-Reply-To: <20090213230201.GA6447@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Manikandan Pillai <mani.pillai@ti.com>, linux-omap@vger.kernel.org

On Friday 13 February 2009, Mark Brown wrote:
> On Fri, Feb 13, 2009 at 02:15:53PM -0800, David Brownell wrote:
> 
> > So what's the plan for merging it then?  I suspect it
> > relates to board-specific init ... regulator_register()
> > having changed signature for the 2.6.30 merge window,
> > and this FIXME remaining un-addressed:
> 
> Yes, it'll need to be updated for mainline.  I'd expect the updated
> version to be submitted via linux-kernel to myself and Liam (it's Liam
> who'd be doing the actual merge with Linus).

Me too.  I just wanted to be clear on those steps.  As you
noted, this has been around a few times ... IMO it would be
good to stick a useful milestone, like "mainline merge", in
the process.  ;)

Especially with 2.6.29-rc5 out now ... get it in the regulator
merge queue, so it can cook for a bit in the MM tree.  I think
the URL is

  http://git.kernel.org/?p=linux/kernel/git/lrg/voltage-2.6.git;a=shortlog;h=for-next


> > >        /* FIXME board init code should provide init_data->driver_data
> > >         * saying how to configure this regulator:  how big is the
> > >         * inductor (affects light PFM mode optimization), slew rate,
> > >         * PLL multiplier, and so forth.
> > >         */
> 
> > Maybe there should be a <linux/regulator/tps6235x.h>
> > header with that board-specific data, and the framework
> > data that's now thankfully not required to be held in
> > the platform_data.  (That init_data->driver_data was
> 
> I'd expect that would be done

I assume "that" is a struct defining the platform_data contents.


> for whatever data is required - it's the 
> standard thing and it's not new for regulator drivers either.  I've no
> specific knowledge of this chip so I can't really assess what's vital to
> get implemented prior to merge and what can be added in further patches
> later.

Minimally

	struct tps6235x_board_info {
		struct regulator_init_data *init_data;
	};

but presumably at least a few of the CTRL1 and CTRL2 fields.
Heck ... doing *all* of them is trivial, just add two bytes to
that struct (and move the bitfield decls to that header).

- Dave
