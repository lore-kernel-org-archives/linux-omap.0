From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Mon, 20 Sep 2010 16:46:34 +0200
Message-ID: <4C9773CA.4010102@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il> <1284627281-26059-4-git-send-email-grinberg@compulab.co.il> <20100916090018.GM3393@legolas.emea.dhcp.ti.com> <4C91DF66.6020003@compulab.co.il> <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56197 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756314Ab0ITOqn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 10:46:43 -0400
In-Reply-To: <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 On 09/20/10 08:39, Felipe Balbi wrote:
> On Thu, Sep 16, 2010 at 04:12:06AM -0500, Igor Grinberg wrote:
>> Yes it will, but even if the hub reset gpio is for some reason unavailable,
>> we don't want to disable ehci completely...
>
> then you should set the gpio to an invalid number, otherwise you might
> cause lots of WARN() to appear due to fiddling with unrequested gpio.

What gpio should be set to invalid number?
It is a reset gpio for usb _hub_ and it has nothing to do with ehci.
Can you please, explain the case when I might cause those WARN()'s?

-- 
Regards,
Igor.

