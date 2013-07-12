From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
Date: Fri, 12 Jul 2013 13:03:13 +0530
Message-ID: <51DFB139.8060408@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com> <20130712072244.GB7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44103 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab3GLHdn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 03:33:43 -0400
In-Reply-To: <20130712072244.GB7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

On Friday 12 July 2013 12:52 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
>> This series should fix the issue with the early serial crash seen
>> during hwmod _setup() as reported by [1]
>>
>> The issue was reported on a am33xx device and was not seen on omap4
>> or omap5 devices as the hwmod data for both omap4 and omap5 had
>> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
>> uart3 which happens to be the debug console used on omap4 panda and
>> omap5 uevm boards.
> 
> The serial driver should be capable of setting this on it's own
> as it sets up the console.

These flags are used to avoid an early reset that hwmod does to all devices
on the SoC and is done much before serial driver is initialized.

> 
> Regards,
> 
> Tony
> 

