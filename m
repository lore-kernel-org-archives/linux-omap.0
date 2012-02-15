From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed .atag_offset
 for DT_MACHINE
Date: Wed, 15 Feb 2012 14:14:53 +0100
Message-ID: <4F3BAFCD.2000508@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com> <20120214195249.GS1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566Ab2BONPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 08:15:01 -0500
In-Reply-To: <20120214195249.GS1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2/14/2012 8:52 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [120213 07:59]:
>> Some .atag_offset entries were wrongly added during a merge conflict
>> resolution in 3.3.
>> Remove them all, since DT boot does not use that attribute anymore.
>>
>> Replace as well the #if... by #ifdef for consistency.
>
> How about let's also remove the 0x from the serial@0x.. in the .dts
> files in this clean-up patch?

In the same patch?

I'm fine with fixing that as well, but since this is not in the same 
file / directory, I'd rather do a different patch.

I'll do the fix anyway, it is up to you for the proper location.

Thanks,
Benoit
