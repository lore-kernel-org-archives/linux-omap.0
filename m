From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 16:57:56 -0500
Message-ID: <5356E5E4.1060509@ti.com>
References: <53566C20.6000208@ti.com> <53568706.1050204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34873 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaDVV55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 17:57:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s3MLvviM001257
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 16:57:57 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s3MLvvWH021843
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 16:57:57 -0500
In-Reply-To: <53568706.1050204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 04/22/2014 10:13 AM, Nishanth Menon wrote:
> Logs with with DEBUG_LL and early printk below:
> Thread: http://marc.info/?t=139817273800014&r=1&w=2
> 
> On 04/22/2014 08:18 AM, Nishanth Menon wrote:
>> next-20140422-omap2plus_defconfig
>>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
>>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
>>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
>>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
>>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>>> known
>>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
> 
>>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3icwS
> 
>>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
>>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
>> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
>> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
> looks like my fdt_high was 0xFFFFFFFF and fdt was at 0x80f80000 :( so
> got stomped all over...
> 
> Time for me to verify every platform again.
ok, boards updated with u-boot fixes etc..

next-20140422-omap2plus_defconfig
 1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2o4V7QFmX
This one is in discussion in this thread.

 2: am3517-evm:  Boot PASS: http://slexy.org/raw/s21U08MZIu
 3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2TYm46GgG
 4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21wjoqqjl
 5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2X8Rh0sSw
we know of this one.
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s29BVtv6dR
 7: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s21ThDvDWV
 8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s20XNhvNId
 9: beaglebone:  Boot PASS: http://slexy.org/raw/s2SqD9D9X8
10: craneboard:  Boot PASS: http://slexy.org/raw/s20bcCjsJi
11: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20K7XSURP
12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2oDI6XGSV
13:       n900:  Boot PASS: http://slexy.org/raw/s2F9nMXZJr
14: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21M66ujw0
15: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2G7n7kez5
16:    sdp2430:  Boot PASS: http://slexy.org/raw/s21OIS6Z6H
17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20pO2iusO
18:    sdp4430:  Boot PASS: http://slexy.org/raw/s20SVaZoDZ
19: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2H8TeWUxt
TOTAL = 19 boards, Booted Boards = 17, No Boot boards = 2

Apologies on the noise.

-- 
Regards,
Nishanth Menon
