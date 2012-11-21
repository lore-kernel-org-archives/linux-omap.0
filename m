From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Wed, 21 Nov 2012 17:13:41 +0200
Message-ID: <50ACEFA5.4080104@ti.com>
References: <Pine.LNX.4.44L0.1211210942570.1731-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab2KUPNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 10:13:44 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211210942570.1731-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>

On 11/21/2012 04:52 PM, Alan Stern wrote:
> On Wed, 21 Nov 2012, Felipe Balbi wrote:
> 
>> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
>>> From: Andy Green <andy.green@linaro.org>
>>>
>>> This patch changes the management of the two GPIO for
>>> "hub reset" (actually controls enable of ULPI PHY and hub reset) and
>>> "hub power" (controls power to hub + eth).
>>
>> looks like this should be done by the hub driver. Alan, what would you
>> say ? Should the hub driver know how to power itself up ?
> 
> Not knowing the context, I'm a little confused.  What is this hub 
> you're talking about?  Is it a separate USB hub incorporated into the 
> IP (like Intel's "rate-matching" hubs in their later chipsets)?  Or is 
> it the root hub?
> 

This is actually a USB HUB + Ethernet combo chip (LAN9514) that is hard
wired on the panda board with its Power and Reset pins controlled by 2
GPIOs from the OMAP SoC.

When powered, this chip can consume significant power (~0.7 W) because
of the (integrated Ethernet even when suspended. I suppose the ethernet
driver SMSC95XX) doesn't put it into a low enough power state on suspend.

It doesn't make sense to power the chip when USB is not required on the
whole (e.g. ehci_hcd module is not loaded). This is what this patch is
trying to fix.

cheers,
-roger
