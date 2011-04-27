From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
Date: Wed, 27 Apr 2011 07:01:30 -0700
Message-ID: <20110427140129.GH3755@atomide.com>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60541 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932811Ab1D0OBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 10:01:35 -0400
Content-Disposition: inline
In-Reply-To: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
> use gpio_request_<one|array>() instead of multiple gpiolib calls,
> remove unneeded variables, etc.

Great :)

Tony
