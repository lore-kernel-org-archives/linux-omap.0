From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7: hwmod: Fix GPMC from preventing core suspend
Date: Wed, 3 Jun 2015 13:51:33 +0300
Message-ID: <556EDC35.2060101@ti.com>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com> <1433239373-14653-3-git-send-email-rogerq@ti.com> <alpine.DEB.2.02.1506022135000.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43004 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbbFCKvr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 06:51:47 -0400
In-Reply-To: <alpine.DEB.2.02.1506022135000.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, tony@atomide.com
Cc: nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org

Paul,

On 03/06/15 00:36, Paul Walmsley wrote:
> On Tue, 2 Jun 2015, Roger Quadros wrote:
>
>> GPMC hwmod is flagged as HWMOD_INIT_NO_IDLE so it is kept
>> enabled at boot. If the GPMC driver is not loaded then
>> GPMC will not be idled thus preventing CORE from going idle
>> during suspend.
>>
>> Disable HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET.
>>
>> The only reason HWMOD_INIT_NO_RESET was there was to retain
>> GPMC timings/settings configured by bootloader. We no longer
>> need that as we're configuring the timins in the kernel.
>>
>> There is no reasoning as to why HWMOD_INIT_NO_IDLE was there.
>> Seems to have beein blindly copied from omap3/4 hwmod code.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>
> Hi Roger, could you take a look at Tony's patch "memory: omap-gpmc: Add
> Kconfig option for debug" and see if this needs to be changed in light of
> that patch?

Yes. We don't need this patch if we can just rid of HWMOD_SWSUP_SIDLE
as done in the first patch.

cheers,
-roger
