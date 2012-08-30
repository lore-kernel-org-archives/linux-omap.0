From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Thu, 30 Aug 2012 14:07:37 +0530
Message-ID: <503F2651.50609@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <20120830000849.GD25765@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37161 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751944Ab2H3Ihn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 04:37:43 -0400
Received: by obbuo13 with SMTP id uo13so2753858obb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 01:37:42 -0700 (PDT)
In-Reply-To: <20120830000849.GD25765@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: paul@pwsan.com, mturquette@ti.com, mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 30 August 2012 05:38 AM, Russell King - ARM Linux wrote:
> On Wed, Aug 29, 2012 at 02:26:15PM +0530, Rajendra Nayak wrote:
>> Moving to Common clk framework for OMAP would mean we no longer use
>> internal lookup mechanism like omap_clk_get_by_name().
>> get rid of all its usage mostly from hwmod and omap_device
>> code.
>>
>> Also use IS_ERR_OR_NULL() for error checking.
>
> This is wrong.  IS_ERR() is the only check you should ever use with clk_get().

okay, thanks, will fix.


