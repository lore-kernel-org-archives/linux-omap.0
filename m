From: Nishanth Menon <nm@ti.com>
Subject: Re: linux-next regressions (next-20140423 A15: uevm/dra7)
Date: Wed, 23 Apr 2014 09:23:42 -0500
Message-ID: <5357CCEE.3000102@ti.com>
References: <5357C481.4090906@ti.com> <5357C647.9000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbaDWOXn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 10:23:43 -0400
In-Reply-To: <5357C647.9000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>

On 04/23/2014 08:55 AM, Peter Ujfalusi wrote:
> On 04/23/2014 04:47 PM, Nishanth Menon wrote:
>> Hi,
>>
>> Will be great if someone else could confirm as well.
>>
>> next-20140423-multi_lpae_defconfig
>>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2HJJ9SKzM
>>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2HoDCbtO0
>> TOTAL = 2 boards, Booted Boards = 0, No Boot boards = 2
>>
>> next-20140423-multi_v7_defconfig
>>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2070nXdAg
>>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s20wKQEqGp
>> TOTAL = 2 boards, Booted Boards = 0, No Boot boards = 2
>>
>> next-20140423-omap2plus_defconfig
>>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2XrqUmRqz
>>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2gQkdoTH4
> 
> I suspect you are using ext4 as rootfs?
> I just sent a fix for this or similar crash (as in the OMAP5432uEVM log):
> http://marc.info/?l=linux-kernel&m=139826085609497&w=2


yep... I cherry-picked
https://patchwork.kernel.org/patch/4041201/
https://patchwork.kernel.org/patch/4041211/

and the platforms look fine in the round of testing I did. please feel
free to add
Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
