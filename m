From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Fri, 23 May 2014 07:46:17 -0700
Message-ID: <20140523144617.GD2321@atomide.com>
References: <cover.1399884780.git.jsarha@ti.com>
 <20140512150616.GF31772@atomide.com>
 <537F2ACD.6030603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62485 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291AbaEWOqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 10:46:24 -0400
Content-Disposition: inline
In-Reply-To: <537F2ACD.6030603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140523 04:03]:
> On 12/05/14 18:06, Tony Lindgren wrote:
> > * Jyri Sarha <jsarha@ti.com> [140512 02:13]:
> >> Since RFC version of the patch set: 
> >> - Split callbacks removal patch away from "Integrated ASoC DAI
> >>   component driver implementation" patches for easier reading
> >>
> >> This set of patches fixes OMAP4+ HDMI audio. The structure of the
> >> implementatin looks a bit different than before. Instead of creating a
> >> driver specific API for a separate ASoC component driver to connect
> >> to, this implementation integrates an the component driver into the
> >> HDMI driver.
> >>
> >> The idea is to use an existing ASoC component driver API instead of
> >> creating a new custom API for each HDMI IP and to avoid splitting the
> >> driver to half for separate video and audio parts connected with the
> >> API.
> >>
> >> The new implementation also uses simple-audio-card for a machine
> >> driver instead of having its own HW specific machine driver.
> > 
> > Can you guys please post this split into the following separate
> > parts for the maintainers to merge:
> > 
> > - ASoC changes
> > - DSS changes
> > - DTS changes
> > 
> > And once those are all in, please post the defconfig changes.
> 
> Tony, this series will get delayed until 3.17, but I'd like to merge the
> HDMI DMA channel changes to omap4/omap5.dtsi already to 3.16. They are
> patches 13 and 15.
> 
> Those are very trivial, but I'd rather have acks from you for all the
> .dts changes I'll be sending.

OK fine with me:

Acked-by: Tony Lindgren <tony@atomide.com>
