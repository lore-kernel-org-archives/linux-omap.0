From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] hsmmc: Add MMC3 support
Date: Fri, 20 Feb 2009 12:16:57 -0800
Message-ID: <20090220201657.GB7414@atomide.com>
References: <1233050022-5769-1-git-send-email-notasas@gmail.com> <200902081141.56632.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61971 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZBTURB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 15:17:01 -0500
Content-Disposition: inline
In-Reply-To: <200902081141.56632.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090208 11:42]:
> On Tuesday 27 January 2009, Grazvydas Ignotas wrote:
> > Device connected to MMC3 is assumed to be self-powered, so
> > set_power() function is empty. It can't be omited because
> > host driver requires it. Array size for hsmmc[] is specified
> > because hsmmc[2].name is needed for MMC3 name.
> 
> Just for the record ... this should eventually be handled
> using the regulator framework, which will also help with the
> decoupling of hsmmc setup from twl4030 setup.
> 
> So for example if a given slot is hooked up to an SDIO
> chip with a hard-wired 3v3 supply (Pandora MMC3, and
> Overo MMC2) then it'd have a fixed voltage regulator;
> and the HSMMC driver would just use that.  (It would
> get a "can't do that" error on disable though.)

Adding to omap3-upstream and pushing to linux-omap.

Tony
