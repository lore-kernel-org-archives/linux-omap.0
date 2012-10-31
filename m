From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Wed, 31 Oct 2012 04:34:21 -0400
Message-ID: <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
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
	<alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38910 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935097Ab2JaIeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 04:34:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1685025iea.19
        for <linux-omap@vger.kernel.org>; Wed, 31 Oct 2012 01:34:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, rjw@sisk.pl
Cc: Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Paul,

- Added Rafael for the PM QoS discussion -

On Tue, Oct 30, 2012 at 10:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 30 Oct 2012, Paul Walmsley wrote:
>
>> Based on a very quick look, I'd say the original patch 3db11fe is broken.
>> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
>> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
>> omap2plus_defconfig.
>
> So in fact to follow up on this, looks like one of two changes are needed:
>
> 1. Revert 3db11fe
>
> or
>
> 2. If CONFIG_CPU_IDLE=n, the driver needs to call disable_hlt() in place
> of the pm_qos constraint add, and call enable_hlt() in place of the pm_qos
> constraint remove.
I do not think this is correct. Using disable_hlt is a too radical
solution and will prevent the idle completely, this is not what we
want.

Rafael, what do you think?

Furthermore without the patch 3db11fe enable_hlt and disable_hlt are
not used in the driver so this change is not the real fix for the
issue. To me the cause is somewhere else. I was hoping Felipe's
ordering fix would do it...

>
> Jean, could you please pick a solution and send a patch for the 3.7-rc
> timeframe, to fix the bug in 3db11fe?
> ?
Let me try to reproduce the issue and hopefully investigate a bit more.
Feel free to revert the patch if you feel like it is the thing to do.

>
> - Paul

Jean
