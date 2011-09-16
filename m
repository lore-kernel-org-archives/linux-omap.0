From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 02/11] regulator: Fix error check in set_consumer_device_supply
Date: Fri, 16 Sep 2011 12:42:23 +0530
Message-ID: <4E72F6D7.6090302@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <20110915133337.GI7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49200 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428Ab1IPHM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:12:29 -0400
Received: by mail-yi0-f43.google.com with SMTP id 24so2774032yic.30
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:12:28 -0700 (PDT)
In-Reply-To: <20110915133337.GI7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thursday 15 September 2011 07:03 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:58PM +0530, Rajendra Nayak wrote:
>> The parameters to set_consumer_device_supply() can be considered
>> invalid (and hence it could return -EINVAL) if nether consumer_dev nor
>> consumer_dev_name are passed, not when *both* are passed.
>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> No, passing both is a clear bug on the part of the caller - the two ways
> of specifying the device are not supposed to be used together.

Got it, I'll just drop this one.

