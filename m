From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Mon, 20 Sep 2010 09:39:13 +0300
Message-ID: <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
 <1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
 <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
 <4C91DF66.6020003@compulab.co.il>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55648 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab0ITGjY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 02:39:24 -0400
Content-Disposition: inline
In-Reply-To: <4C91DF66.6020003@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 16, 2010 at 04:12:06AM -0500, Igor Grinberg wrote:
>Yes it will, but even if the hub reset gpio is for some reason unavailable,
>we don't want to disable ehci completely...

then you should set the gpio to an invalid number, otherwise you might
cause lots of WARN() to appear due to fiddling with unrequested gpio.

-- 
balbi
