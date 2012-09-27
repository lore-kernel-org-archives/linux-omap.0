From: linux@johnea.net
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 13:16:29 -0700
Message-ID: <5064B41D.9030709@johnea.net>
References: <50648AA2.2010004@johnea.net> <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com> <5064A173.5000909@johnea.net> <CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com> <CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:23568 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2I0UQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 16:16:31 -0400
Received: from [192.168.1.143] (wsip-70-166-88-164.sd.sd.cox.net [70.166.88.164])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id 9A19673F188B
	for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 13:16:30 -0700 (PDT)
In-Reply-To: <CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 09/27/2012 12:39 PM, Robert Nelson wrote:

>>
>> So, i would first look at the config (zcat /proc/config.gz) between
>> those two releases, and if the arch developers added any more patches
>> to it..
>
> https://github.com/archlinuxarm/PKGBUILDs/commit/68a9e5a1609fde10a2f31dac8df211f0c3874eb7
>
> It looks like they disabled CONFIG_OMAP_RESET_CLOCKS
>
> I'm pretty sure that would force you to be stuck with what ever u-boot
> sets up for those pins...

Thank you very much Robert!

I found this in your 3.5 series patchset logs:

"beagle: video works now, had to drop the hi-speed pll divider, as the infastructure for it looks to have been removed"

https://github.com/RobertCNelson/stable-kernel/commit/e7c8d9e8894997ae6a1ad9c83292ed75c5ac32c5

Which makes me think 3.5.4 on the beagle with your patches will have DVI again.

I just received a kernel to test from the archlinuxarm devs, if spidev is still missing, I'll pass along your advice regarding CONFIG_OMAP_RESET_CLOCKS.

Thanks again for your help! I'll follow up with the results...

johnea
