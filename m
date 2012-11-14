From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv3 0/7] i2c: omap: updates
Date: Wed, 14 Nov 2012 18:39:37 +0530
Message-ID: <50A39811.9030406@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com> <20121114120400.GH5954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422805Ab2KNNKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 08:10:11 -0500
In-Reply-To: <20121114120400.GH5954@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com

On Wednesday 14 November 2012 05:34 PM, Wolfram Sang wrote:
> On Mon, Nov 05, 2012 at 05:53:35PM +0530, Shubhrajyoti D wrote:
>
>> Shubhrajyoti D (8):
>>       i2c: omap: Fix the revision register read
>>       i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>>       i2c: omap: remove the dtrev
>>       ARM: i2c: omap: Remove the i207 errata flag
>>       i2c: omap: re-factor omap_i2c_init function
>>       i2c: omap: make reset a seperate function
>>       i2c: omap: Restore i2c context always
>>       i2c: omap: cleanup the sysc write
> Pushed the series to for-next, after fixing a trivial merge conflict
> caused by reverting the QoS patch.

Thanks.
>

