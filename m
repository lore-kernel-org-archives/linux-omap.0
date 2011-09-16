From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed
 from board files
Date: Fri, 16 Sep 2011 14:55:57 +0530
Message-ID: <4E731625.1040707@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <20110915133236.GH7988@opensource.wolfsonmicro.com> <4E72F6B9.4050207@ti.com> <20110916085732.GB22062@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:45907 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495Ab1IPJ0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 05:26:05 -0400
Received: by mail-yi0-f53.google.com with SMTP id 21so3433183yie.12
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 02:26:03 -0700 (PDT)
In-Reply-To: <20110916085732.GB22062@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Friday 16 September 2011 02:27 PM, Mark Brown wrote:
> On Fri, Sep 16, 2011 at 12:41:53PM +0530, Rajendra Nayak wrote:
>> On Thursday 15 September 2011 07:02 PM, Mark Brown wrote:
>>> On Thu, Sep 15, 2011 at 04:51:57PM +0530, Rajendra Nayak wrote:
>
>>>> There is no need for all the board files to pass this information
>>>> additionally, when the driver already sets them by default.
>
>>> "the driver"?  This sounds very buggy...
>
>> Yeah, the driver currently sets some default based on what
>> the chip itself supports and completely ignores the board
>> inputs.
>> How about the driver using the defaults and letting the boards
>> override it (if it ever wants to)?
>> Currently none of the boards (using any of the twl
>> regulators) seem to override the defaults and that way a lot of
>> this duplication in board files could be avoided.
>
> No, this is just plain buggy.  It's fine for OMAP to have some common
> stuff that the board reference but if the drivers are doing this that's
> bad.  The drivers and framework shouldn't touch the hardware unless the
> board says it's OK.

fair enough, I'll fix up the driver then.

