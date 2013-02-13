From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback
 removal from panel drivers
Date: Wed, 13 Feb 2013 08:46:47 -0800
Message-ID: <20130213164647.GF7144@atomide.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60387 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756619Ab3BMQqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 11:46:49 -0500
Content-Disposition: inline
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Archit Taneja <archit@ti.com> [130213 06:26]:
> init functions in omap board files request panel specific gpios, and provide
> functions which omapdss panel drivers call to enable or disable them.
> 
> Instead of the board files requesting these gpios, they should just pass the
> platform specific data(like the gpio numbers), the panel should retrieve the
> platform data and request the gpios. Doing this prevents the need of the panel
> driver calling platform functions in board files.
> 
> Panel drivers have their own platform data struct, and the board files populate
> these structs and pass the pointer to the 'data' field of omap_dss_device. This
> work will make it easier for the panel drivers be more adaptable to the
> DT model.
> 
> There is also removal of passing panel reset_gpio numbers through
> omap_dss_device struct directly, reset gpios are passed through platform data
> only.

To avoid merge conflicts and dependencies between drivers and core
Soc code, please break thes kind of patches into following parts:

1. Any platform_data header changes needed so both I and Tomi
   can pull it in as needed.

2. Changes to DSS drivers. Please keep stubs around for the
   board specific callback functions so omap2plus_defconfig
   won't break with just #1 merged into arm soc tree.

3. All the arch/arm/*omap* changes based on #1 above to
   drop obsolete callback functions and add new pdata if still
   needed. This needs to build and boot on #1 so I can merge
   this in via arm soc tree.

4. Any .dts changes needed.

Regards,

Tony
