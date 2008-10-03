From: David Brownell <david-b@pacbell.net>
Subject: Re: [alsa-devel] [patch] bugfix: SOUND: SOC: OMAP: Add support for Gumstix Overo
Date: Fri, 3 Oct 2008 08:37:14 -0700
Message-ID: <200810030837.15131.david-b@pacbell.net>
References: <200810030811.33484.david-b@pacbell.net> <20081003151846.GA9127@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:39088 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751092AbYJCPhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 11:37:18 -0400
In-Reply-To: <20081003151846.GA9127@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Friday 03 October 2008, Mark Brown wrote:
> > ---
> > I'm not sure where the four patches for Overo support are
> > in the ALSA queue (that's how they'll merge, yes?) but I'll
> > suggest this one merge into the initial "overo.c" submit...
> 
> They're not queued in ALSA since they depend on the PMIC codec driver
> which in turn depends on the PMIC core driver being merged.

I'm working on getting the twl4030 core merged ... expecting
it to be there for 2.6.28-early.   Since this codec driver
doesn't need interrupts, it's particularly undemanding.  :)

So if the only place these are queued is the OMAP tree, and
there is no particular objection to the patch, then there'd
seem be no issue merging it to the OMAP tree and having it
be part of the initial merge-to-mainline...

- Dave
