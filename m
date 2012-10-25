From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 11:02:38 +0530
Message-ID: <5088CEF6.5000606@ti.com>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com> <20121023191124.GB853@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:54787 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab2JYFcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 01:32:47 -0400
Received: by mail-ie0-f198.google.com with SMTP id 17so3560043iea.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 22:32:46 -0700 (PDT)
In-Reply-To: <20121023191124.GB853@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

On 10/24/2012 12:41 AM, Felipe Balbi wrote:
>>
>> >    	return 0;
>> >    }
> another thing, the few places in omap_i2c_xfer_msg() which are currently
> calling omap_i2c_init() should also be converted to call the newly added
> __omap_i2c_init(). We don't need to recalculate any of those clock
> dividers and whatnot.

Yes in fact omap_i2c_init() can be reset - calculate - and __omap_i2c_init.
Then in those places the recalculate can be optimised.


