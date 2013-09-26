From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Thu, 26 Sep 2013 10:29:10 -0500
Message-ID: <524452C6.6090801@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <52445115.7010800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3IZP3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 11:29:36 -0400
In-Reply-To: <52445115.7010800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.orgBenoit Cousson <bcousson@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 09/26/2013 10:21 AM, Nishanth Menon wrote:
> On 09/25/2013 03:48 AM, Tero Kristo wrote:
> [...]
>> Test branch available here:
>> https://github.com/t-kristo/linux-pm.git
>> branch: mainline-3.12-rc2-ti-dt-clks-v7
>>
>> Testing done:
>> - am335x-bone : boot only
>> - omap5-sevm : boot only
>> - dra7-evm : boot only
>> - omap3-beagle : boot + suspend/resume (ret + off)
>> - omap4-panda-es : boot + suspend/resume
>>
>> Nishanth has also been doing some tests with omap3-beagle-xm with some WIP
>> versions of this branch, but not with this latest one. Nishanth, maybe you
>> can provide test results to this one also?
> I rebased the branch on top of benoit's for_3.13/dts merged with
> v3.12-rc2 tag
> 45646cd ARM: dts: AM33XX: don't redefine OCP bus and device nodes
> 
> All platforms were to MMC filesystem boot (SD card). u-boot used
> v2013.10-rc3 on all platforms (mainline u-boot).
> 
> OMAP3630: Beagle-XM:
> http://pastebin.pandaboard.org/index.php/view/96577127
> (needs additional patch
> -> https://patchwork.kernel.org/patch/2919661/ )
dependency patch needs rework
> 
> OMAP4460: Panda-ES: http://pastebin.pandaboard.org/index.php/view/85143661
> 
> OMAP5432: OMAP5-UEVM:
> http://pastebin.pandaboard.org/index.php/view/91361843
> (nice to have patch
> -> https://patchwork.kernel.org/patch/2907761/ )
Acked,tested, pending merge from  maintainers
> 
> AM335x: BeagleBone Black:
> http://pastebin.pandaboard.org/index.php/view/42000597
> (needs additional patches:
>  https://patchwork.kernel.org/patch/2902711/
-> merged to Shekar's davinci branch -> pending upstream.
>  https://patchwork.kernel.org/patch/2902711/
Correction on ^^: should have been:
https://patchwork.kernel.org/patch/2919661/
tested, pending ack, merge.
> )
> 
> DRA7: DRA7-EVM: http://pastebin.pandaboard.org/index.php/view/38362805
> (needs additional patches:
> -> https://patchwork.kernel.org/patch/2849391/
> -> https://patchwork.kernel.org/patch/2849601/
> -> https://patchwork.kernel.org/patch/2849602/
> -> https://patchwork.kernel.org/patch/2907761/
All of the above:
Acked,tested, pending merge from  maintainers
> )
> 
> So, for the entire series:
> Tested-by: Nishanth Menon <nm@ti.com>
> 

Maybe Benoit and Tony could help reduce few of these acked patches
pending merge from having to be cherry-picked by folks.

-- 
Regards,
Nishanth Menon
