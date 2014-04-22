From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 17:52:20 -0500
Message-ID: <5356F2A4.6010106@ti.com>
References: <53566C20.6000208@ti.com>	<53568706.1050204@ti.com>	<5356E5E4.1060509@ti.com> <CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60547 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbaDVWwW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 18:52:22 -0400
In-Reply-To: <CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 04/22/2014 05:45 PM, Javier Martinez Canillas wrote:
[...]
>>> Time for me to verify every platform again.
>> ok, boards updated with u-boot fixes etc..
>>
>> next-20140422-omap2plus_defconfig
>>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2o4V7QFmX
>> This one is in discussion in this thread.

We just managed to get am335x-evm up and running as well.
am335x-evm:  Boot PASS: http://slexy.org/raw/s2WSAKSG2S

I checked with DEBUG_LL a few mins back on AM335x-sk:
http://slexy.org/raw/s2P8L4FGBY

>>
>>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s21U08MZIu
>>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2TYm46GgG
>>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21wjoqqjl
>>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2X8Rh0sSw
>> we know of this one.
> 
> The fix for this is [PATCH] ARM: dts: am437x-gp-evm: Do not reset
> gpio5 [0] right?

Yep, This is a different issue compared to the AM335x-sk discussion.
http://marc.info/?l=linux-omap&m=139819642824190&w=2
two patches for this one:
https://patchwork.kernel.org/patch/3871201/
https://patchwork.kernel.org/patch/4034201/

we are still debating about how to go about it.

> 

on AM335x-sk:
> So this makes only am335x-sk to fail with the gpiolib irpchip
> conversion as reported by Peter and you.
> 
> Do you know what special use of GPIO have this board to behave
> differently than the other boards? I've looked at the DTS but didn't
> find anything evident.

I could not find anything interesting yet. Peter did mention that
reverting d04b76626e94 helped make the platform boot fine. I am trying
to add a few prints and see which specific line does things go bad..
and if so why.. unfortunately, I am using the board remotely as well..
Will try to track this down in the next few hours and post back.

> 
> [0]: http://www.spinics.net/lists/linux-omap/msg104702.html
> 


-- 
Regards,
Nishanth Menon
