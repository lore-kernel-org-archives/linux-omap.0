From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 11/11] ARM: OMAP4: register DT clocks and remove old
 data
Date: Mon, 24 Jun 2013 10:45:23 +0300
Message-ID: <51C7F913.7070104@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com> <1371647942-4811-12-git-send-email-t-kristo@ti.com> <20130621072518.GN5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58303 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab3FXHpy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jun 2013 03:45:54 -0400
In-Reply-To: <20130621072518.GN5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 06/21/2013 10:25 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [130619 06:25]:
>> Now that the OMAP4 PRCM clock data has been converted to device tree
>> representation, it is no longer needed as static clock data. OMAP4
>> clock init routine is also changed to register DT clocks first.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/cclock44xx_data.c | 1674 +--------------------------------
>>   1 file changed, 38 insertions(+), 1636 deletions(-)
>
> This is nice, thanks for working on this. While at it, can
> you also keep your eyes open for the register defines in the
> header files we can also drop?
>
> Some of those headers are quite huge.. and should eventually
> be private to the related drivers if needed at all with DT.

Yeah, I can take a look at this after this set is done. It seems like 
large portion of the headers can be dropped completely once this 
exercise is done.

-Tero

