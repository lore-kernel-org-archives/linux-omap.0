From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for OMAP3 EVM
Date: Wed, 25 Feb 2009 15:25:59 -0500
Message-ID: <20090225202559.GO4368@mvista.com>
References: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com> <20081125132120.1d740c04.jarkko.nikula@nokia.com> <20081125145257.GD12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:4467 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbZBYU0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 15:26:04 -0500
Content-Disposition: inline
In-Reply-To: <20081125145257.GD12414@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, ext Misael Lopez Cruz <mesak82@gmail.com>

Hi,

On Tue, Nov 25, 2008 at 02:52:58PM +0000, Mark Brown wrote:
> On Tue, Nov 25, 2008 at 01:21:20PM +0200, Jarkko Nikula wrote:
> 
> > Or if those EVM's & SDP's can route TWL4030 audio connections more
> > flexible than Beagle but somewhat similar manner, then probably have one
> > single machine driver for all EVM's?
> 
> > Otherwise it doesn't make very much sense to have n similar machine
> > drivers where only functions and variable names differ.
> 
> Yes, it looks like a lot of these drivers could be redone along the
> lines of s3c24xx_uda134x.c with platform data specifying the differences
> between the boards.

Is someone working on updating ASoC drivers for OMAP TWL4030 based
boards as recommended above?  Just curious since I already made the
mistake of creating my own OMAP3 EVM ASoC driver w/o checking the
list first.  : /

--
Regards,
George
