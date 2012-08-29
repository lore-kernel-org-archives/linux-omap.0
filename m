From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 2/5] mfd: introduce retu-mfd driver
Date: Wed, 29 Aug 2012 16:37:18 -0700
Message-ID: <20120829233717.GH1303@atomide.com>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40049 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754642Ab2H2XhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 19:37:20 -0400
Content-Disposition: inline
In-Reply-To: <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com

* Aaro Koskinen <aaro.koskinen@iki.fi> [120828 14:35]:
> Retu is a multi-function device found on Nokia Internet Tablets
> implementing at least watchdog, RTC, headset detection and power button
> functionality.
> 
> This patch implements a minimum functionality providing only register
> access functions.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: sameo@linux.intel.com

Probably makes sense to merge this along with the I2C patch?

Acked-by: Tony Lindgren <tony@atomide.com>
