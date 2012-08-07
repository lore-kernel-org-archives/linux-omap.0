From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm/dts: Mark vcxio, v2v1 and v1v8 regulators as
 always on
Date: Tue, 7 Aug 2012 03:44:41 -0700
Message-ID: <20120807104441.GW11011@atomide.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36935 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab2HGKop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:44:45 -0400
Content-Disposition: inline
In-Reply-To: <1343653940-16614-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com

* Rajendra Nayak <rnayak@ti.com> [120730 06:17]:
> vcxio, v2v1 and v1v8 are expected to be always on, update the dtsi
> for twl6030 to reflect this.
> 
> commit '86f5fc' regulator: core: Mark all DT based boards as having
> full constraints) caused these to be disabled at late boot causing
> OMAP4 boards (using twl6030) to lockup.

Thanks I'll apply this one into fixes.

Tony
