From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
Date: Tue, 1 Jun 2010 12:20:30 +0300
Message-ID: <20100601092030.GH841@atomide.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
 <1275143831-7629-4-git-send-email-thara@ti.com>
 <4C02EE9F.70305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0FAJUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 05:20:35 -0400
Content-Disposition: inline
In-Reply-To: <4C02EE9F.70305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>

* Benoit Cousson <b-cousson@ti.com> [100531 01:57]:
> >+
> >+#define NO_EARLY_TIMERS                        2
> The "NO_" is a little bit confusing, you should maybe use _COUNT.

Also NR_ is commonly used.

Tony
