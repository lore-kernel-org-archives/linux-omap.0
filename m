From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Wed, 24 Apr 2013 12:44:50 -0700
Message-ID: <20130424194450.GD5184@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16640 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757650Ab3DXToz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Apr 2013 15:44:55 -0400
Content-Disposition: inline
In-Reply-To: <20130419171318.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Tony Lindgren <tony@atomide.com> [130419 10:18]:
> 
> 4. WLAN with wl12xx fails with both legacy and DT booting
> 
> No real output here with the legacy mode, just the usual
> using pinctrl dummy state warning.

The WLAN legacy booting issue was caused by me not having
lib80211 module loaded.

Regards,

Tony
