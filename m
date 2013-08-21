From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add new bindings for OMAP
Date: Wed, 21 Aug 2013 05:23:28 -0700
Message-ID: <20130821122327.GI7656@atomide.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
 <1376983966-16490-3-git-send-email-rnayak@ti.com>
 <20130821074514.GU7656@atomide.com>
 <52147E95.5000606@ti.com>
 <20130821085330.GH7656@atomide.com>
 <521486E1.6030009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55663 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751462Ab3HUMXd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 08:23:33 -0400
Content-Disposition: inline
In-Reply-To: <521486E1.6030009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: bcousson@baylibre.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [130821 02:29]:
> On Wednesday 21 August 2013 02:23 PM, Tony Lindgren wrote:
> > 
> > Or you could also have various bus specific bindings for the ocp
> > with lists of phandles?
> > 
> > ocp {
> > 	reg = <...>;
> > 	interrupts = <...>;
> > 	ti,reset-on-init = <&module1, &module2>;
> > 	...
> > };
> > 
> > Or something similar.
> 
> The only problem I see with this is that some of these modules could be
> board specific ones and need to be part of the board dts files, like
> some boards which have PMIC power switch hooked up to some gpio etc.
> So there could be some SoC specific modules (like emif/gpmc on OMAPs)
> and some which depend on how the boards are designed.

You can still override the ocp entry in the board specific .dts file.
Would probably be a lot easier than to override each module separately
in the board specific .dts file.

Regards,

Tony
