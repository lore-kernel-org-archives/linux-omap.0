From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 0/8] ARM: omap2: GPMC cleanup
Date: Mon, 4 Mar 2013 13:25:32 -0600
Message-ID: <5134F52C.1010300@ti.com>
References: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com> <20130304185259.GQ11806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54826 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758166Ab3CDTZl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 14:25:41 -0500
In-Reply-To: <20130304185259.GQ11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Afzal Mohammed <afzal@ti.com>


On 03/04/2013 12:53 PM, Tony Lindgren wrote:
> * Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [130212 11:26]:
>> This patchset is v3 of the small cleanup consisting in:
>>  * mark some functions as 'static' when appropriate
>>  * remove an unused function from gpmc.c
>>  * improve error messages when a CS request fails
>>  * migrate to dev_err and dev_warn
>>
>> Changes from v2:
>>  * add a commit message to some trivial patches,
>>    that omitted it due to author's laziness.
>>
>> Changes from v1:
>>  * fix gpmc_cs_reserved to return a boolean instead
>>    of an integer error code
>>  * add a new patch to the patchset cleaning redundant checks
>>
>> It has been tested on a IGEP v2 board with OneNAND,
>> which means the gpmc-nand patch is tested by compilation only.
>>
>> Altough this patchset is almost trivial,
>> any feedback or testing is more than welcome.
>>
>> Thanks to Jon Hunter for his kind review!
> 
> Looks good to me. Jon, can you please queue all the GPMC related
> patches into one pull request around -rc2 time assuming no more
> comments? 

Yes will do.

Jon
