From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: omap3:  Adapt USB OTG to generic PHY framework
Date: Mon, 7 Oct 2013 16:49:41 +0300
Message-ID: <5252BBF5.1060406@ti.com>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com> <1381152493-28055-2-git-send-email-rogerq@ti.com> <5252B9C7.5040109@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429Ab3JGNuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 09:50:37 -0400
In-Reply-To: <5252B9C7.5040109@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kishon@ti.com
Cc: bcousson@baylibre.com, pavel@ucw.cz, aaro.koskinen@iki.fi, marek@goldelico.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/07/2013 04:40 PM, Sebastian Andrzej Siewior wrote:
> On 10/07/2013 03:28 PM, Roger Quadros wrote:
>> The generic PHY framewrok expects different properties than the
>> old USB PHY framework. Supply those properties.
>>
>> Fixes USB OTG port on GAT04 and N900 after the Generic PHY framework was
>> merged in greg/usb-next. [1]
> 
> Would it be much pain (and do we want this at all) to add a fallback
> into the kernel or at least a printk pointing out to update the .dts
> for two releases or so? So the user does not need to spent hours to
> figure out why it suddenly stopped working.
> 

I agree with you. 

Also, figuring out which kernel configs to enable for
USB OTG to work on OMAP is a pain in itself to the user.

cheers,
-roger

