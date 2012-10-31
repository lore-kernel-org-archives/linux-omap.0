From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Wed, 31 Oct 2012 04:22:11 -0400
Message-ID: <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40470 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935002Ab2JaIWL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 04:22:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1675379iea.19
        for <linux-omap@vger.kernel.org>; Wed, 31 Oct 2012 01:22:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Tue, Oct 30, 2012 at 9:17 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 30 Oct 2012, Felipe Balbi wrote:
>
>> On Tue, Oct 30, 2012 at 12:50:52PM +0000, Paul Walmsley wrote:
>> > certainly PM-idle related, given that the problem goes away by reverting
>> > Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert
>> > I2C driver to PM QoS for MPU latency constraints".
>> >
>> > The problem is consistent and easy to reproduce here.
>>
>> I don't doubt that :-) What I think, however, is that PM QoS just made
I dont doubt either but cannot have it reproduced.

>> the problem a bit easier to trigger for whatever reason. Maybe because
>> pm qos defers constraint updates, or something similar ?
PM QoS just influences the cpuidle decision on the next power state of
the CPU and CORE power domains.

>
> Based on a very quick look, I'd say the original patch 3db11fe is broken.
> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
> omap2plus_defconfig.
Withtout CPU_IDLE set the PM QoS has no influence on the power domains states.

>
>
> - Paul

Jean
