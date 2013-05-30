From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap-usb-host: clean up pin mux setup code
Date: Thu, 30 May 2013 12:13:22 +0300
Message-ID: <51A71832.70305@ti.com>
References: <1366624673-2684-1-git-send-email-rogerq@ti.com> <20130508235232.GW32546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48824 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030209Ab3E3JNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:13:49 -0400
In-Reply-To: <20130508235232.GW32546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 05/09/2013 02:52 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130422 03:02]:
>> The USB host pins are named quite differently between OMAP3 and
>> OMAP4+ SoCs. To make this managable in code, we create a pin mapping
>> table (pin_names) that maps pin function to pin name.
>>
>> This pin mapping table is populated at runtime based on a pin
>> name template. Templates are provided for OMAP3 and 4 SoCs.
>>
>> The setup_io_mux() function uses the pin mapping table to
>> setup the pin mux.
>>
>> The resulting code is a lot more clean, manageable and scalable.
> 
> I'm planning to drop all the omap4 pdata soonish. Will post some
> patches after -rc1 to do that. Do you still need this patch
> considering that?
> 

In that case we don't need this.

cheers,
-roger
