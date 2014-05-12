From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 12 May 2014 08:06:16 -0700
Message-ID: <20140512150616.GF31772@atomide.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33805 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758642AbaELPGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 11:06:24 -0400
Content-Disposition: inline
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com

* Jyri Sarha <jsarha@ti.com> [140512 02:13]:
> Since RFC version of the patch set: 
> - Split callbacks removal patch away from "Integrated ASoC DAI
>   component driver implementation" patches for easier reading
> 
> This set of patches fixes OMAP4+ HDMI audio. The structure of the
> implementatin looks a bit different than before. Instead of creating a
> driver specific API for a separate ASoC component driver to connect
> to, this implementation integrates an the component driver into the
> HDMI driver.
> 
> The idea is to use an existing ASoC component driver API instead of
> creating a new custom API for each HDMI IP and to avoid splitting the
> driver to half for separate video and audio parts connected with the
> API.
> 
> The new implementation also uses simple-audio-card for a machine
> driver instead of having its own HW specific machine driver.

Can you guys please post this split into the following separate
parts for the maintainers to merge:

- ASoC changes
- DSS changes
- DTS changes

And once those are all in, please post the defconfig changes.

Regards,

Tony
 
