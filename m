From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: MMC2 support in linux-omap-2.6.27 (omap1)
Date: Thu, 26 Mar 2009 10:46:52 +0200
Message-ID: <49CB40FC.5070907@nokia.com>
References: <dbdb2ea60903250713s2eba347aib5758cf5157979da@mail.gmail.com> <dbdb2ea60903251449u5d8e3edfvd58291923ecf6693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48320 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZCZIqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 04:46:25 -0400
In-Reply-To: <dbdb2ea60903251449u5d8e3edfvd58291923ecf6693@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

twebb wrote:
> On Wed, Mar 25, 2009 at 10:13 AM, twebb <taliaferro62@gmail.com> wrote:
>> I'm currently using linux-omap-2.6.27 (tag=omap1) and trying to add
>> MMC2 support.  I've back ported what I think I need from various files
>> inn l-o-2.6.28-omap1.  I will eventually move to 2.6.28-omap1 but for
>> now am trying to get it working on 2.6.27.
>>
>> Traces show that all looks good up until first command is issued, then
>> nothing seems to happen.  STAT reg shows 0, don't see clock or cmd
>> activity.  MMC1 is working fine with an SD card; MMC2 is connected to
>> eMMC flash.  Seems like I'm missing something basic like a clock or
>> enable, though I've confirmed ICLK and FCLK are enabled.  Any ideas?
>>
>> Thanks,
>> twebb
>>
> 
> I found at least part of my problem.  SDVS field of HCTL was being set
> to 0x7 (3.3V) instead of 0x5 (1.8V), and apparently MMC2 must be set
> for 0x5.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

The most up to date omap_hsmmc.c is here:

http://git.kernel.org/?p=linux/kernel/git/drzeus/mmc.git;a=blob;f=drivers/mmc/host/omap_hsmmc.c;h=488f222054f8a1493142d02da526c951def5ddfe;hb=next

That includes the 10 patches on LKML except number 8

