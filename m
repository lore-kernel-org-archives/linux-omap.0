From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 20/20] OMAPDSS: split hdmi muxing function
Date: Wed, 24 Oct 2012 09:23:15 -0700
Message-ID: <20121024162314.GF5605@atomide.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
 <1351070951-18616-21-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11907 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933634Ab2JXQXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 12:23:17 -0400
Content-Disposition: inline
In-Reply-To: <1351070951-18616-21-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121024 02:32]:
> Split the omap4_hdmi_mux_pads() function into two parts, one handles the
> tpd12s015 gpio muxing, the other handles the hdmi pins.
> 
> This is clearer, as hdmi and tpd12s015 are separate devices, and it also
> allows us to mux those separately with DT.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ricardo Neri <ricardo.neri@ti.com>

Looks OK to me to merge with the rest of the DSS patches:

Acked-by: Tony Lindgren <tony@atomide.com>
