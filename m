From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/23] ARM: OMAP2+: PRCM cleanups towards 3.19 / part2
Date: Mon, 1 Dec 2014 17:58:04 +0200
Message-ID: <547C900C.20003@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1411271913040.1406@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074AbaLAP50 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Dec 2014 10:57:26 -0500
In-Reply-To: <alpine.DEB.2.02.1411271913040.1406@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On 11/27/2014 09:15 PM, Paul Walmsley wrote:
> On Thu, 27 Nov 2014, Tero Kristo wrote:
>
>> Yet another PRCM cleanup set, towards making PRCM a separate driver.
>> This set is most likely too late for 3.19, but hopefully it can make
>> it to 3.20.
>
> Yep too late for 3.19.
>
> ...
>
>> Testing done:
>>
>
> ...
>
>> omap3-beagle: boot, suspend (ret), suspend (off) (UART wakeup seems broken on 3.18-rc1 btw)
>
> v3.18-rc1 UART wakeups worked here on both of the 35xx Beagles:
>
> http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/README.txt
> http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/pm/3530es3beagle/3530es3beagle_log.txt
> http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/pm/3530es31beagle/3530es31beagle_log.txt

After investigating this a bit, it seems you are right. It looks like I 
just had wakeup disabled on the tty port, the default behaviour has 
changed at some point for some reason. After enabling wakeup, resume 
with console works also.

-Tero

