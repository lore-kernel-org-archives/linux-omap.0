From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed
 from board files
Date: Fri, 16 Sep 2011 12:41:53 +0530
Message-ID: <4E72F6B9.4050207@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <20110915133236.GH7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41912 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428Ab1IPHMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:12:01 -0400
Received: by mail-yw0-f47.google.com with SMTP id 7so4134266ywf.6
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:12:00 -0700 (PDT)
In-Reply-To: <20110915133236.GH7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thursday 15 September 2011 07:02 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:57PM +0530, Rajendra Nayak wrote:
>> The TWL driver seems to set the default .valid_modes_mask to
>> (REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY) and .valid_ops_mask
>> to (REGULATOR_CHANGE_VOLTAGE | REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS)
>> for all the registered regulators.
>>
>> There is no need for all the board files to pass this information
>> additionally, when the driver already sets them by default.
>
> "the driver"?  This sounds very buggy...

Yeah, the driver currently sets some default based on what
the chip itself supports and completely ignores the board
inputs.
How about the driver using the defaults and letting the boards
override it (if it ever wants to)?
Currently none of the boards (using any of the twl
regulators) seem to override the defaults and that way a lot of
this duplication in board files could be avoided.

