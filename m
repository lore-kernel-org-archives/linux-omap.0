From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Tue, 21 Sep 2010 10:07:00 +0300
Message-ID: <20100921070700.GH11123@legolas.emea.dhcp.ti.com>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
 <1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
 <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
 <4C91DF66.6020003@compulab.co.il>
 <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
 <4C9773CA.4010102@compulab.co.il>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36120 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0IUHHJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 03:07:09 -0400
Content-Disposition: inline
In-Reply-To: <4C9773CA.4010102@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Sep 20, 2010 at 09:46:34AM -0500, Igor Grinberg wrote:
> On 09/20/10 08:39, Felipe Balbi wrote:
>> On Thu, Sep 16, 2010 at 04:12:06AM -0500, Igor Grinberg wrote:
>>> Yes it will, but even if the hub reset gpio is for some reason unavailable,
>>> we don't want to disable ehci completely...
>>
>> then you should set the gpio to an invalid number, otherwise you might
>> cause lots of WARN() to appear due to fiddling with unrequested gpio.
>
>What gpio should be set to invalid number?

the one which fails to be requested.

>It is a reset gpio for usb _hub_ and it has nothing to do with ehci.
>Can you please, explain the case when I might cause those WARN()'s?

ok, I misunderstood then. Nevermind

-- 
balbi
