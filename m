From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 0/3] OMAP3 EVM: enable ethernet support
Date: Fri, 9 May 2008 15:00:14 -0700
Message-ID: <20080509220014.GH5976@atomide.com>
References: <5e088bd90805080947u5ffc7188h4a1df0309841b767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52709 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbYEIWAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 18:00:16 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90805080947u5ffc7188h4a1df0309841b767@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080508 09:48]:
> This series of patches enables ethernet support on the OMAP3 EVM.  It
> has been tested with an x11 image and I was able to successfully
> browse the web and download OE packages.
> 
> The first patch has been submitted to linux-netdev by Nishant Kamat
> and is currently under consideration there.  The second two patches
> are linux-omap specific.

Good to hear it was sent to linux-netdev.

> I'm posting this series for comment while we wait for acceptance of
> the first patch.

Well I'll push them so the board is more usable :) I'll use whatever
version comes from upstream for the smc91x files.

Tony
