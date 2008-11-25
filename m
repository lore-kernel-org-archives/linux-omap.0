From: David Brownell <david-b@pacbell.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Tue, 25 Nov 2008 12:14:53 -0800
Message-ID: <200811251214.54155.david-b@pacbell.net>
References: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com> <200811251054.29156.david-b@pacbell.net> <20081125200411.GA6572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:45990 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751607AbYKYUPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 15:15:16 -0500
In-Reply-To: <20081125200411.GA6572@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: arunks@mistralsolutions.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, steve@sakoman.com

On Tuesday 25 November 2008, Mark Brown wrote:
> BTW, it'd also be really handy if you could remove the OMAP dependencies
> from TWL4030_CORE - I know it currently needs them to actually be useful
> at runtime but it'd mean that it's possible to build things like the
> codec driver on other configs which helps when working on subsystems.

Patches for that are ready, but need a bit more testing
in the OMAP tree before they go to mainline.  I may prep
the mainline patches anyway ... the patches are roughly

 - updates to twl4030-core device creation, which
   are now in the OMAP tree, passing more IRQs via
   platform_device resources;

 - updates to various TWL drivers that won't go to
   mainline for a while, so they get the IRQs from
   those new resources;

 - removing the global IRQ symbols from the headers,
   and thus the OMAP dependencies.

The need for testing is from that second set of
patches.  There's also regulator framework stuff.

- Dave
