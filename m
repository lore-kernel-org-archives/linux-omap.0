From: Tony Lindgren <tony@atomide.com>
Subject: Re: HSI: any status updates on omap_ssi?
Date: Tue, 24 Apr 2012 08:23:16 -0700
Message-ID: <20120424152316.GH3739@atomide.com>
References: <20120421105235.GA3296@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56169 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab2DXPXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 11:23:23 -0400
Content-Disposition: inline
In-Reply-To: <20120421105235.GA3296@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Carlos Chinea <carlos.chinea@nokia.com>, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [120421 04:26]:
> Hi,
> 
> Missing omap_ssi support is currently the most important missing
> feature, to make the mainline kernel on the Nokia N900 useful, see
> also [0].
> 
> Can you prepare SSI inclusion into the mainline kernel, now that HSI
> has been pulled into 3.4? Do you think we get SSI support in 3.5?

Also FYI related to n900, you need to have bce492c0 (ARM: OMAP2+: UART: Fix
incorrect population of default uart pads) applied after v3.1 if using
CONFIG_OMAP_MUX to avoid some SSI pins getting wronly muxed to UART.

Then to verify, the hw floating point error you reported a while back
with omap2plus_defconfig got resolved, right?

Regards,

Tony

 
> [0] http://elinux.org/N900

