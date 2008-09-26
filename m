From: Tony Lindgren <tony@atomide.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Fri, 26 Sep 2008 10:40:17 +0300
Message-ID: <20080926074013.GA7962@atomide.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com> <200809252220.43229.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51468 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbYIZHhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:37:37 -0400
Content-Disposition: inline
In-Reply-To: <200809252220.43229.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Siarhei Siamashka <siarhei.siamashka@gmail.com> [080925 22:20]:
> On Tuesday 23 September 2008, Arun KS wrote:
> > Hi all,
> >
> > I am writing an ASOC driver for tlvaic23 on osk5912 platform.
> [...]
> 
> Hi. Coincidentally I have been hacking the old aic23 driver in the last few
> days to make it work on Nokia 770. Don't know if these fixes have any value
> for linux-omap tree, but I would be glad if anybody finds some of them useful.
> Patch against old 2.6.16 kernel can be found here:
> http://lists.maemo.org/pipermail/maemo-developers/2008-September/035053.html

Of course we want all the patches integrated! Please start posting
your patches to alsa-devel and cc linux-omap.

> A bug with current position detection in 'audio_get_dma_pos' is especially bad
> as it causes sound stuttering on video playback.

Tony
