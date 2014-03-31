From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Mon, 31 Mar 2014 14:59:51 -0500
Message-ID: <5339C937.8060308@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com> <53399C21.1070908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40284 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaCaUAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 16:00:16 -0400
In-Reply-To: <53399C21.1070908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

On 03/31/2014 11:47 AM, Nishanth Menon wrote:
> On 03/31/2014 10:15 AM, Tero Kristo wrote:
>> Hi,
>>
>> This set is continuation for the work started earlier to cleanup the CM/PRM
>> and attempt to make it a separate driver. This set depends on these
>> two sets:
>>
>> CM/PRM cleanup set:
>> http://marc.info/?l=linux-omap&m=139395000918201&w=2
>>
>> OMAP2 clock DT set:
>> http://comments.gmane.org/gmane.linux.ports.arm.omap/111257
>>
>> This set is pretty huge but the patches can be applied in stages if need be.
>> Anyway, it would be good to get some feedback whether the driver folder
>> locations etc. are good, and whether the effort taken here will be enough
>> to actually move the driver. Clockdomain / powerdomain code can also be
>> moved easily under the drivers/power/omap folder (or someplace else if
>> requested) once this set is in. Also, clockdomain / powerdomain data
>> should be possible to convert to DT format or some sort of firmware
>> blob once this is done.
>>
>> Patch #55 in this set is pretty massive as it moves all the C files at
>> the same time, this should probably be split up as multiple patches.
>>
>> Testing branch pushed here (contains also the CM/PRM cleanup set and OMAP2
>> clock DT conversion):
>>
>> tree: https://github.com/t-kristo/linux-pm.git
>> branch: 3.14-rc4-cm-prm-driver-v1
>>
> 
> Tested this branch after rebase to v3.14 final (needed a few manual
> rebase fixes.. trivial ones)
> 
> major fail is around sdp2430 which fails to boot ->
> with DEBUG_LL sdp2430 : http://slexy.org/raw/s2MRoxsaJH
> 
> 
> kristo-3.14-cm-prm-driver-v1-omap2plus_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2YLPt80Ui
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21fyrFaCx
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21lquhrjO
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2VAGZMV5L
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21vX0JPy6
>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2tfyxYceR
>  7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2zQOfp9JM
>  8: beaglebone:  Boot PASS: http://slexy.org/raw/s2K848ipJj
>  9: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20OteG4I3
> 10: OMAP3430-Labrador(LDP):  Boot FAIL: http://slexy.org/raw/s21DupyTRc
> ^^ legacy behavior
> 11: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21HMWU7XE
> 12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s2ex7L8gYg
> ^^ regression
> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s21Xl1pQGp
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2oYwjOXu5
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20havbuwY
> TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2
> 
> v3.14-omap2plus_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2fsTX7RLo
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s204it5W7s
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20RHMAlQk
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2y0jKiClC
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2094U1Iwa
>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2jfuRAl9n
>  7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s28LGuHny3
>  8: beaglebone:  Boot PASS: http://slexy.org/raw/s2zSlZ6hbK
>  9: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s21IA9TS0U
> 10: OMAP3430-Labrador(LDP):  Boot FAIL: http://slexy.org/raw/s2ZKEdCt2g
> ^^ legacy behavior
> 11: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2IJBjcuU1
> 12:    sdp2430:  Boot PASS: http://slexy.org/raw/s2YjBF8dq8
> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s22vE9i5W5
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2EIb4li37
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2hBJQyZ4M
> TOTAL = 15 boards, Booted Boards = 14, No Boot boards = 1
> 
> 

and a kernel_patch_verify static check report:
http://slexy.org/view/s20MhigkXd

I think many of these could be squelched as well.

-- 
Regards,
Nishanth Menon
