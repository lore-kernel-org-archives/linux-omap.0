From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 00:45:27 +0200
Message-ID: <CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:49176 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaDVWp2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 18:45:28 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so4036192wiv.10
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 15:45:27 -0700 (PDT)
In-Reply-To: <5356E5E4.1060509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hello Nishanth,

On Tue, Apr 22, 2014 at 11:57 PM, Nishanth Menon <nm@ti.com> wrote:
> On 04/22/2014 10:13 AM, Nishanth Menon wrote:
>> Logs with with DEBUG_LL and early printk below:
>> Thread: http://marc.info/?t=139817273800014&r=1&w=2
>>
>> On 04/22/2014 08:18 AM, Nishanth Menon wrote:
>>> next-20140422-omap2plus_defconfig
>>>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
>>>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
>>>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
>>>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
>>>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>>>> known
>>>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
>>
>>>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3icwS
>>
>>>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
>>>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
>>> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
>>> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
>> looks like my fdt_high was 0xFFFFFFFF and fdt was at 0x80f80000 :( so
>> got stomped all over...
>>
>> Time for me to verify every platform again.
> ok, boards updated with u-boot fixes etc..
>
> next-20140422-omap2plus_defconfig
>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2o4V7QFmX
> This one is in discussion in this thread.
>
>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s21U08MZIu
>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2TYm46GgG
>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21wjoqqjl
>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2X8Rh0sSw
> we know of this one.

The fix for this is [PATCH] ARM: dts: am437x-gp-evm: Do not reset
gpio5 [0] right?

So this makes only am335x-sk to fail with the gpiolib irpchip
conversion as reported by Peter and you.

Do you know what special use of GPIO have this board to behave
differently than the other boards? I've looked at the DTS but didn't
find anything evident.

>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s29BVtv6dR
>  7: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s21ThDvDWV
>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s20XNhvNId
>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2SqD9D9X8
> 10: craneboard:  Boot PASS: http://slexy.org/raw/s20bcCjsJi
> 11: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20K7XSURP
> 12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2oDI6XGSV
> 13:       n900:  Boot PASS: http://slexy.org/raw/s2F9nMXZJr
> 14: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21M66ujw0
> 15: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2G7n7kez5
> 16:    sdp2430:  Boot PASS: http://slexy.org/raw/s21OIS6Z6H
> 17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20pO2iusO
> 18:    sdp4430:  Boot PASS: http://slexy.org/raw/s20SVaZoDZ
> 19: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2H8TeWUxt
> TOTAL = 19 boards, Booted Boards = 17, No Boot boards = 2
>
> Apologies on the noise.
>
> --
> Regards,
> Nishanth Menon
> --

Thanks a lot and best regards,
Javier

[0]: http://www.spinics.net/lists/linux-omap/msg104702.html
